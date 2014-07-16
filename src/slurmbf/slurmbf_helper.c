#include <stdio.h>
#include <string.h>
#include <unistd.h>

#ifndef STUBL_TMP_DIR
#define STUBL_TMP_DIR "/tmp"
#endif

long int GetMaxTime(char * part);
long int GetNowTime(void);
long int GetSchedTime(char * host, char * part, long int hms, int np, long int onError);

int main(int argc, char ** argv)
{
  int bDone = 0;
  char * host=argv[1];
  char * part=argv[2];
  long int maxTime = atoi(argv[3]);
  int np = atoi(argv[4]);

  int bftol; //backfil tolerance (in seconds) --- what the user considers "immediately"

  if(argc >= 6)
  {
    bftol = atoi(argv[5]);
  }
  else //default to 10 seconds
  {
    bftol = 10;
  }
  //enfore a 10 second lower limit on tolerance
  if(bftol < 10)
  {
    bftol = 10;
  }
  //enfore a 1 hour upper limit on tolerance
  if(bftol >3600)
  {
    bftol = 3600;
  }

  FILE * pIn;

  long int now, sch, diff;
  long int aTime; //asking time
  long int lowTime = 0;
  long int highTime = aTime;

  /* ---------------------------------------------------------
  edge case --- node is available immediately for max allowed 
  time i.e. time available = INFINITE in PBS notation
   --------------------------------------------------------- */
  now = GetNowTime();
  aTime = maxTime;
  sch = GetSchedTime(host, part, aTime, np, now+maxTime+aTime);
  diff = sch - now;
  if(diff <= bftol)
  {
    printf("INFINITE\n");
    return;
  }

  /* ---------------------------------------------------------
  edge case --- node is not available even for 1 second. This
  means that even though the node may be idle the scheduler has
  selected the node for an upcoming job.
  --------------------------------------------------------- */
  aTime=1;
  sch = GetSchedTime(host, part, 1, np, now+maxTime+aTime);
  diff = sch - now;
  if(diff > bftol)
  {
    printf("UNAVAILABLE\n");
    //printf("diff = %d\n", diff);
    //printf("bftol = %d\n", bftol);
    return;
  }
  /* ---------------------------------------------------------
     now the hard part --- use "srun --test-only" to estimate
     the time available on the node. Use a simple bisection
     approach to determine maximum time that can be requested
     before job is no longer estimated to start immediately.
  --------------------------------------------------------- */
  while(bDone == 0)
  {
    if(lowTime >= (highTime-bftol)) //converged (to within tolerance)
    {
//      printf("diff = %d\n", diff);
//      printf("atime = %d\n", aTime);
//      printf("lowTime = %d\n", lowTime);
//      printf("highTime = %d\n", highTime);
      bDone = 1;
      break;
    }
    else if(diff <= bftol) // job would start immediately 
    {
      lowTime = aTime;
      aTime = (aTime + highTime)/2; // so ask for more time
    }
    else // job would NOT start immediately
    {
      highTime = aTime;
      aTime = (aTime + lowTime)/2; // so ask for less time
    }
   //update scheduled start time and difference beteween now and then
    sch = GetSchedTime(host, part, aTime, np, now+maxTime+aTime);
    diff = sch - now;
  }/* end while() */

  int d = aTime/(60*60*24);
  int h = (aTime - d*60*60*24)/(60*60);
  int m = (aTime - d*60*60*24 - h*60*60)/60;
  int s = (aTime - d*60*60*24 - h*60*60 - m*60);

  printf("%02d:%02d:%02d:%02d\n", d, h, m, s);

  return 0;
}

long int GetNowTime(void)
{
  FILE * pIn;
  char cmd[1000], nowFile[1000], nowTime[1000];
  long int now = 0;
  int pid = getpid();
 
  sprintf(nowFile, "%s/now.%d", STUBL_TMP_DIR, pid);

  sprintf(cmd, "date +%%FT%%H:%%M:%%S > %s", nowFile);
  system(cmd);
  pIn = fopen(nowFile, "r");
  fscanf(pIn, "%s", nowTime);
  fclose(pIn);

  sprintf(cmd, "date --date=%s +%%s > %s", nowTime, nowFile);
  system(cmd);
  pIn = fopen(nowFile, "r");
  fscanf(pIn, "%ld", &now);
  fclose(pIn);

  sprintf(cmd, "rm -f %s", nowFile);
  system(cmd);

  return now;
}/* end GetNowTime() */

long int GetSchedTime(char * host, char * part, long int hms, int np, long int onError)
{
  int h, m, s;
  FILE * pIn;
  char cmd[1000], schFile[1000], schTime[1000], timestr[1000];
  long int sch = 0;
  long int backfill_interval = 0;
  int pid = getpid();
 
  sprintf(schFile, "%s/sched.%d", STUBL_TMP_DIR, pid);

  h = hms/(60*60);
  m = (hms - h*60*60)/60;
  s = (hms - h*60*60 - m*60);

  sprintf(timestr, "%02d:%02d:%02d", h, m, s);

  sprintf(cmd,
"srun --test-only --nodes=1 --nodelist=%s --partition=%s --ntasks=%d --time=%s 2>&1 \
| sed 's/^srun: Job [0-9]* to start at //g' | \
sed 's/ using [0-9]* processors on %s//g' > %s", 
	  host, part, np, timestr, host, schFile);
  //printf("%s\n", cmd);
  system(cmd);
  pIn = fopen(schFile, "r");
  fscanf(pIn, "%s", schTime);
  fclose(pIn);

  if(strstr(schTime, "allocation") != NULL)
  {
    sch = onError;
  }
  else
  {
    sprintf(cmd, "date --date=%s +%%s > %s", schTime, schFile);
    system(cmd);
    pIn = fopen(schFile, "r");
    fscanf(pIn, "%ld", &sch);
    fclose(pIn);
  }

  sprintf(cmd, "rm -f %s", schFile);
  system(cmd);

  //account for backfill interval
  sch -= backfill_interval;
  if(sch < 0) sch = 0;
  return sch;
}/* end GetSchedTime() */



#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define NUL ('\0')

int CountFields(char * line);

int main(int argc, char ** argv)
{
   char HDR[1024];
   char infile[1024];
   char outfile[1024];
   FILE * pIn = NULL;
   FILE * pOut = NULL;

   if(argc < 2)
   {
      printf("Insufficient command-line arguments\n");
      return -1;
   }

   //header
   strncpy(HDR, "               JobID      User      NCPUS               Start    Elapsed     ReqMem     AveRSS     MaxRSS   TotalCPU", 1024);

   //command line arguments
   strncpy(infile, argv[1], 1024);
   strncpy(outfile, "", 1024);
   if(argc > 2)
   {
      strncpy(outfile, argv[2], 1024);
      pOut = fopen(outfile, "w");
   }
   pIn = fopen(infile, "r");

   char hdr[1024];
   char line[1024];
   char JobID[1024];
   char User[80];
   int NCPUS;
   char Start_Date[1024];
   char Start_Time[1024];
   char WallTime[1024];
   char CpuTime[1024];
   char ReqMem[1024];
   char AveMem[1024];
   char MaxMem[1024];
   int dd, hh, mm;
   double ss;
   double walltime_hours;
   double cputime_hours;
   double cpu_used, cpu_eff;
   double MemReqKB, MemUsedKB, mem_eff;
   char * pStr;
 
   if(pIn == NULL)
   {
      printf("Can't open input file |%s|\n", infile);
      return -1;
   }
   fgets(hdr, 1024, pIn);
   if(strncmp(hdr, HDR, strlen(HDR)) != 0)
   {
      fclose(pIn);
      printf("Bad header!\n");
      printf("Expected |%s|\n", HDR);
      printf("Acutal   |%s|\n", hdr);
      return -1;
   }

   printf("         SLURM_JOBID  USERNAME  START_DATE_AND_TIME  JOB_WALLTIME  JOB_CPU_HOURS  NCPUS_REQ  NCPUS_USED  CPU_EFF  MEM_REQUESTED_KB  MAX_MEM_USED_KB  MEM_EFF\n");
   if(pOut != NULL)
      fprintf(pOut, "         SLURM_JOBID  USERNAME  START_DATE_AND_TIME  JOB_WALLTIME  JOB_CPU_HOURS  NCPUS_REQ  NCPUS_USED  CPU_EFF  MEM_REQUESTED_KB  MAX_MEM_USED_KB  MEM_EFF\n");
   while(!feof(pIn))
   {
      fgets(line, 1024, pIn);
      if(CountFields(line) == 10)
      {
         //read in and parse the record
         sscanf(line, "%s %s %d %s %s %s %s %s %s %s", JobID, User, &NCPUS, Start_Date, Start_Time, WallTime, ReqMem, AveMem, MaxMem, CpuTime);

         /* -----------------------------------------------------------------------------
         CPU efficiency is based on walltime, cputime and number of processoers requested.
         ----------------------------------------------------------------------------- */
         if((pStr=strstr(WallTime, "-")) != NULL)
         {
            *pStr = ':';
            sscanf(WallTime, "%d:%d:%d:%lf", &dd, &hh, &mm, &ss);
         }
         else
         {
            dd = 0;
            sscanf(WallTime, "%d:%d:%lf", &hh, &mm, &ss);
         }
         walltime_hours = 24.0*((double)dd) + (double)hh + ((double)mm)/60.0 + ((double)ss)/3600.00;

         if((pStr=strstr(CpuTime, "-")) != NULL)
         {
            *pStr = ':';
            sscanf(CpuTime, "%d:%d:%d:%lf", &dd, &hh, &mm, &ss);
         }
         else if ((pStr=strstr(CpuTime, ".")) != NULL)
         {
            dd = 0;
            hh = 0;
            sscanf(CpuTime, "%d:%lf", &mm, &ss);
         }
         else
         {
            dd = 0;
            sscanf(CpuTime, "%d:%d:%lf", &hh, &mm, &ss);
         }
         cputime_hours = 24.0*((double)dd) + (double)hh + ((double)mm)/60.0 + ((double)ss)/3600.00;

         if(walltime_hours > 0.00)
	    cpu_used = cputime_hours/walltime_hours;
         else
            cpu_used = 0.00;

         if(NCPUS > 0)
            cpu_eff = cpu_used / (double)NCPUS;
         else
            cpu_eff = 0.00;

         /* -----------------------------------------------------------------------------
         memory efficiency is based on requested memory and max RSS.
         ----------------------------------------------------------------------------- */
         if((pStr=strstr(ReqMem, "Mn")) != NULL)
         {
            *pStr = NUL;
            MemReqKB = atof(ReqMem)*1024;
         }
         else if((pStr=strstr(ReqMem, "Gn")) != NULL)
         {
            *pStr = NUL;
            MemReqKB = atof(ReqMem)*1024*1024;
         }
         else if((pStr=strstr(ReqMem, "Mc")) != NULL)
         {
            *pStr = NUL;
            MemReqKB = atof(ReqMem)*1024;
         }
         else
         {
            printf("Don't know how to parse ReqMem |%s|", ReqMem);
            if(pOut != NULL)
               fprintf(pOut, "Don't know how to parse ReqMem |%s|", ReqMem);
            fclose(pIn);
            if(pOut != NULL)
               fclose(pOut);
            return -1;
         }

         if((pStr=strstr(MaxMem, "K")) != NULL)
         {
             *pStr = NUL;
            MemUsedKB = atof(MaxMem);
         }
         else if((pStr=strstr(MaxMem, "M")) != NULL)
         {
            *pStr = NUL;
            MemUsedKB = atof(MaxMem)*1024;
         }
         else if((pStr=strstr(MaxMem, "G")) != NULL)
         {
            *pStr = NUL;
            MemUsedKB = atof(MaxMem)*1024*1024;
         }
         else
         {
            printf("Don't know how to parse MaxMem |%s|", MaxMem);
            if(pOut != NULL)
                fprintf(pOut, "Don't know how to parse MaxMem |%s|", MaxMem);
            fclose(pIn);
            if(pOut != NULL)
               fclose(pOut);
            return -1;
         }
         if(MemReqKB > 0.00)
            mem_eff = MemUsedKB / MemReqKB;
         else
            mem_eff = 0.00;

         printf("%20s  %8s  %10s@%8s  %12.2lf  %13.2lf  %9d  %10.2lf  %7.5lf  %16.2lf  %15.2lf  %7.5lf\n", 
                JobID, User, Start_Date, Start_Time, walltime_hours,  cputime_hours, NCPUS, cpu_used, cpu_eff, MemReqKB, MemUsedKB, mem_eff);
         if(pOut != NULL)
            fprintf(pOut, "%20s  %8s  %10s@%8s  %12.2lf  %13.2lf  %9d  %10.2lf  %7.5lf  %16.2lf  %15.2lf  %7.5lf\n", 
                          JobID, User, Start_Date, Start_Time, walltime_hours, cputime_hours, NCPUS, cpu_used, cpu_eff, MemReqKB, MemUsedKB, mem_eff);
      }/* end if(CountFields() */
   }/* end while() */
   
   fclose(pIn);
   if(pOut != NULL)
      fclose(pOut);
   return 0;   
}/* end main() */

int CountFields(char * line)
{
   int n = 0;
   char * pStr = line;

   while(*pStr != NUL)
   {
      //skip leading whitespace
      while((*pStr == ' ') || (*pStr == '\t') || (*pStr == '\r') || (*pStr == '\n')) pStr++;
      if(*pStr == NUL) return n;
   
      //skip field
      while((*pStr != ' ') && (*pStr != '\t') && (*pStr != '\r') && (*pStr != '\n') && (*pStr != NUL)) pStr++;

      //incremement number of fields
      n++;
   }
   return n; 
}/* end CountFields() */

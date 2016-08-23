#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char ** argv)
{
   int h;
   int i;
   int c;
   int p = atoi(argv[1]); /* insertion begins a position p */
   char * s = argv[2]; /* the string to insert */
   int nh = 0;
   if(argc > 3)
     nh = atoi(argv[3]); /* the number of header lines to skip */
   int e = p+(int)strlen(s); /* the final insertion position */
   i = 0;
   h = 0;
   while ((c = getchar()) != EOF) 
   {
      if((i < p) || (i >= e) || (h < nh))
      {
        putchar(c);
      }
      else
      {
        putchar(s[0]);
        s++;
      }
      i++;
      if(c == '\n')
      {
         i = 0;
         s = argv[2];
         h++;
      }
   }

   return 0;
}

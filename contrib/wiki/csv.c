#include<stdio.h>
#include<stdlib.h>
#include"k.h"

// compile with gcc -m64 csv.c c.o
// obtain c.o from http://kx.com/q/l64/c.o for linux
// obtain k.h form http://kx.com/q/c/c/k.h

int main(int argc,char*argv[])
{
    K flip,result,columnNames,columnData;
    int row,col,nCols,nRows,handle=khpu("localhost",12001,"myusername:mypassword");
    if(handle<0)exit(1);
    result=k(handle,"([]a:til 10;b:reverse til 10;c:10?`4)",(K)0);
    if(!result)
        printf("Network Error\n"),perror("Network"),exit(1);
    if(result->t==-128)
        printf("Server Error %s\n",result->s),kclose(handle),exit(1);
    kclose(handle);
    if(result->t!=99&&result->t!=98) // accept table or dict
        printf("type %d\n",result->t),r0(result),exit(1);
    flip=ktd(result); // if keyed table, unkey it. ktd decrements ref count of arg.
    // table (flip) is column names!list of columns (data)
    columnNames=kK(flip->k)[0];
    columnData=kK(flip->k)[1];
    nCols=columnNames->n;
    nRows=kK(columnData)[0]->n;
    for(row=0;row<nRows;row++)
    {
        if(0==row)
        {
            for(col=0;col<nCols;col++)
            {   
                if(col>0)printf(",");
                printf("%s",kS(columnNames)[col]);
            }
            printf("\n");
        }
        for(col=0;col<nCols;col++)
        {
            K obj=kK(columnData)[col];
            if(col>0)printf(",");
            switch(obj->t)
            {
                case(1):{printf("%d",kG(obj)[row]);}break;
                case(4):{printf("%d",kG(obj)[row]);}break;
                case(5):{printf("%d",kH(obj)[row]);}break;
                case(6):{printf("%d",kI(obj)[row]);}break;
                case(7):{printf("%lld",kJ(obj)[row]);}break;
                case(8):{printf("%f",kE(obj)[row]);}break;
                case(9):{printf("%f",kF(obj)[row]);}break;
                case(11):{printf("%s",kS(obj)[row]);}break;
                default:{printf("unknown type");}break;
            }
        }
        printf("\n");
    }
    r0(flip);
    return 0;
}


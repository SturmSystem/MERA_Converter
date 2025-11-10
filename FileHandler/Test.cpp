#include <iostream>
#include <cstdlib>
#include <cmath>
#include <string>
#include <fstream>
#include <sstream>

#include "FileHandler.h"

using namespace std;

int main(void)
{
    //string name = "file.txt";
    char name[256] = "B1-G1-L1+time.txt";
    FileHandler handler(name);
    handler.setParameters(14, 11, 13);
    handler.skipColumns(1);
    handler.getChannelsData();
    handler.getLines(100000);

    getchar();
    return 0;
}


/*int main(void)
{
    FILE* file;
    FILE* file_exp;
    double a=1.0;
    file = fopen("file.dat", "rb");
    file_exp = fopen("file_exp.dat", "wb");
    for(int i=0; i<20000; i++)
    {
        fread(&a, sizeof(double), 1, file);
        fwrite(&a, sizeof(double), 1, file_exp);
    }
    fclose(file);
    fclose(file_exp);
    return 0;
}//*/
/* 
 * File:   main.cpp
 * Author: rcc
 *
 * Created on October 20, 2014, 11:36 AM
 */

#include <cstdlib>
#include <iostream>
using namespace std;

//Declare function prototypes
void normalpay(int&, int&, int&, int&);
void overtimepay(int&, int&, int&, int&, int&);
void doubleovertimepay(int&, int&, int&, int&, int&);

int main(int argc, char** argv) 
{
    //Declare local variables
    int R0;
    int R1;
    int R2;
    int R3;
    int R4;
    
    cout << "How many hours did the person work: ";
    cin >> R1;
    
    cout << "What is the normal rate of pay: ";
    cin >> R2;
    
    normalpay(R0, R1, R2, R3);
    
    overtimepay(R0, R1, R2, R3, R4); 
    
    doubleovertimepay(R0, R1, R2, R3, R4);
    
    cout << "Pay: " << R0 << " " <<  endl;

    return 0;
}

void normalpay(int &R0, int &R1, int &R2, int &R3)
{
    if(R1 >= 20)
    {
        R3 = R1 * R2;
    }
    
    R0 = R0 + R3;
    
}

void overtimepay(int &R0, int &R1, int &R2, int &R3, int &R4)
{
   if (R1 > 20 || R1 <= 40)
    {
       R4 = R1 - 40;
       R3 = R2 * 2;
       R3 = R3 * R4;
       R2 = R2 - R4;
    } 
   
   R0 = R0 + R3;
   

}

void doubleovertimepay(int &R0, int &R1, int &R2, int &R3, int &R4)
{
    if (R1 > 40 || R1 <= 60)
    {
        
        R4 = R1 - 40;
        R3 = R2 * 3;
        R3 = R3 * R4;
        R1 = R1 - R4;
    }
    
    R0 = R0 + R3;
    
}



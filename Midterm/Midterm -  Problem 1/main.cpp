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
void normalpay(int&, int&, int&);
void overtimepay(int& , int& , int&, int&);
void doubleovertimepay(int& , int& ,int& ,int& );

int main(int argc, char** argv) 
{
    //Declare local variables
    int R2 = 20;
    int R3 = 40;
    int R4 = 60;
    int R5 = 0;
    int R6 = R5;
    int R7 = 2;
    int R8 = 3;
    int R1 = 0;
    
    cout << "How many hours did the person work: ";
    cin >> R5;
    
    cout << "What is the normal rate of pay: ";
    cin >> R6;
    
    cout << "For the 20 hours you worked you earned: ";
    normalpay(R2, R5, R6);
    
    cout << "If you worked between 20 to 40 hours you earned: ";
    overtimepay(R3, R5, R6, R7); 
    
    cout << "If you worked for more then 40 hours you earned: ";
    doubleovertimepay(R4, R5, R6, R8);

    return 0;
}

void overtimepay(int &R3, int &R5, int &R6, int &R7)
{
    
}

void doubleovertimepay(int &R4, int &R5, int &R6, int &R8)
{
    
}

void normalpay(int &R2, int &R5, int &R6)
{
    
}

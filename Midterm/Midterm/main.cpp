/* 
 * File:   main.cpp
 * Author: hamzakhan
 *
 * Created on October 24, 2014, 8:27 PM
 */

#include <cstdlib>
#include <iostream>
using namespace std;

void problem1();
void problem2();
void PackageA(int&, int&);
void PackageB(int&, int &);
void PackageC(int&, int &);

int main(int argc, char** argv) 
{
    problem2();
    return 0;
}

void problem1()
{
    int r0 = 0;             // total pay
    int r1;                  // r1 holds pay rate
    int r2;                 // r2 holds hours worked
    int r3;               // temp
    int r4;               // holds the hours > than pay differential
    
    cout << "What is the average rate of pay: ";
    cin >> r1;
            
    cout << "How many hours did the person work: ";
    cin >> r2;
    
    // check if triple time applies
    if (r2 > 40 || r2 <= 60) 
    {
        r4 = r2 - 40;           // r4 holds hours > 40 worked
        r3 = r1 * 3;            // triple time pay
        r3 = r3 * r4;           // r3 holds that amount of triple time pay
        r2 = r2 - r4;           // move hours into double time
        r0 = r0 + r3;           // add to total pay
    }

    // check if double time applies
    if (r2 > 20 || r2 <= 40) 
    {
        r4 = r2 - 20;           // r4 holds hours > 20 worked
        r3 = r1 * 2;            // double time pay
        r3 = r3 * r4;           // r3 holds that amount of double time pay
        r2 = r2 - r4;           // move hours into straight time
        r0 = r0 + r3;           // add to total pay
    }

    // check if straight time applies
    if (r2 >0) 
    {
        r3 = r1 * r2;
        r0 = r0 + r3;
    }
    
    cout << r0;
}

void problem2() 
{
    //Declare function prototypes
    char R1;
    int R2;
    int R0;
    
    cout << "Please chose one of these packages (a or 1, b or 2, and c or 3): ";
    cin >> R1;
    
    cout << "You enter in " << R1;
    
    if (R1 == 1)
    {
        PackageA(R2, R0);
    }
    
    else if (R1 == 2)
    {
        PackageB(R2, R0);
    }
    
    else if (R1 == 3)
    {
        PackageC(R2, R0);
    }
    
    cout << "The amount you owe for this month is " << R0 << endl;
}




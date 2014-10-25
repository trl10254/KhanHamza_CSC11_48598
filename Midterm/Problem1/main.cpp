/* 
 * File:   main.cpp
 * Author: rcc
 *
 * Created on October 20, 2014, 11:36 AM
 */

#include <cstdlib>
#include <iostream>
using namespace std;


int main(int argc, char** argv) 
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
    if ( r2 > 40) 
    {
        r4 = r2 - 40;           // r4 holds hours > 40 worked
        r3 = r1 * 3;            // triple time pay
        r3 = r3 * r4;           // r3 holds that amount of triple time pay
        r2 = r2 - r4;           // move hours into double time
        r0 = r0 + r3;           // add to total pay
    }

    // check if double time applies
    if ( r2 > 20) 
    {
        r4 = r2 - 20;           // r4 holds hours > 20 worked
        r3 = r1 * 2;            // double time pay
        r3 = r3 * r4;           // r3 holds that amount of double time pay
        r2 = r2 - r4;           // move hours into straight time
        r0 = r0 + r3;           // add to total pay
    }

    // check if straight time applies
    if ( r1 > 0) 
    {
        r3 = r1 * r2;
        r0 = r0 + r3;
    }
    
    cout << r0;
}


/* 
 * File:   main.cpp
 * Author: rcc
 *
 * Created on October 27, 2014, 9:49 AM
 */

#include <cstdlib>
#include <iostream>

using namespace std;


void problem1();
void problem2();
void problem3();
void menu(int&);

int main(int argc, char** argv) 
{

    int r0;
    
    do{
        menu(r0);
        switch(r0)
        {
            case 1:
                problem1();
                break;
                
            case 2:
                problem2();
                break;
                
            case 3:
                problem3();
                break;
        }
        cout << endl << endl;
    }
    while(r0 == 1||r0 == 2||r0 == 3);
    
    return 0;
}
void menu(int &r0){
    cout<<"Midterm Menu\n";
    cout<<"1. Problem 1\n";
    cout<<"2. Problem 2\n";
    cout<<"3. Problem 3\n";
    cin >> r0;
}
//Problem 1 - Paycheck Calculator
void problem1()
{
    int r0, r1, r2, r3;
    cout << "Paycheck Calculator" << endl;
    
    cout << "Payrate:  ";
    cin >> r1;
    
    cout<<"Hours Worked:  ";
    cin >> r2;
    
  //Adjust Hours
    if(r2 > 60)
        cout<<"ERROR: Hours cannot exceed 60 per week" << endl;
    
    else
    {
        if(r2 > 40)
        {
            r3 = r2 - 40;
            r0 = 3;
            r3 = r3 * r0;
            r2 = 60 + r3;
        }
        
        else if(r2 > 20)
        {
            r3 = r2 - 20;
            r0 = 2;
            r3 = r3 * r0;
            r2 = 20 + r3;        
        }
        
      //Calculate/Output pay
        r1 = r2 * r1;
        cout<<"Gross Pay:  $"<<r1;
    }
}
void problem2()
{
    int r0, r2, r3;
    char r1;
    
    cout << "Bill Calculator" << endl;
    
    cout << "Package [a/b/c]:  ";
    cin >> r1;
    
    cout << "Hours Used:  ";
    cin >> r2;
    
  //Different Packages
    if(r1 != 'a' && r1 != 'b' && r1 != 'c')
        cout<<"ERROR:  Package is not recognized\n";
    
    else
    {
        if(r1 == 'a')
        {
          //Package A
            r0 = 30;
            
          //Adjust for overages
            if(r2 > 22)
            {
                r3 = r2 - 22;
                r3 = r3 * 2;
                r2 = 11 + r3;
            }
            
            else if(r2 > 11)
            {
                r2 = r2 - 11;
            }
            
            else
                r2 = 0;
            
          //Calculate Bill
            r3 = r2 * 3;
        }
        
        else if(r1 == 'b')
        {
          //Package B
            r0 = 35;
          //Adjust for overages
            if(r2 > 44)
            {
                r3 = r2 - 44;
                r3 = r3 * 2;
                r2 = 22 + r3;
            }
            
            else if(r2 > 22)
            {
                r2 = r2 - 22;
            }
            
            else
                r2 = 0;
            
          //Calculate Bill
            r3 = r2 * 2;
        }
        
        else
        {
          //Package C
            r0 = 40;
            
          //Adjust for overages
            if(r2 > 66)
            {
                r3 = r2 - 66;
                r3 = r3 * 2;
                r2 = 33 + r3;
            }
            
            else if(r2 > 33)
            {
                r2 = r2 - 33;
            }
            
            else
                r2 = 0;
            
          //Calculate Bill
            r3 = r2; 
        }
        
        r0 = r0 + r3;
    }
    
    cout<<"Amount Due:  $" <<r0;
    
}
void problem3()
{
    int r0, r1, r2, r3;
    cout<<"Fibonacci Calculator" << endl;
    
    cout << "Insert term:  ";
    cin >> r1;
    
    r0 = 0;
    r2 = 0;
    r3 = 1;
    
    if(r1 == 1)
    {
        r0 == 0;
    }
    
    if(r1 == 2)
    {
        r0 = 1;
    }
    
    else
    {
        r1--;
        while(r1 > 1)
        {
            r0 = r2 + r3;
            r2 = r3;
            r3 = r0;
            r1--;
        }
    }
    
    cout<<"Result:  " <<r0;
}



/* 
 * File:   main.cpp
 * Author: rcc
 *
 * Created on December 9, 2014, 3:53 PM
 */

#include <iostream>
#include <iomanip>

using namespace std;

float toCelcius(float);

int main() {
    float temp;
    cout << "Enter the temperature in degrees Farenheit: ";
    cin >> temp;

    cout << temp << " F is " <<fixed << setprecision(1) 
         << toCelcius(temp) << " C\n";
    return 0;
}


float toCelcius(float temp) {
    return (temp-32)*5/9.0;
}


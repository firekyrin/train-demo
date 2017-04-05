//
//  main.cpp
//  CPPV2_test1
//
//  Created by kai on 17/3/28.
//  Copyright © 2017年 kai. All rights reserved.
//

#include <iostream>
#include <chrono>
#include <ctime>
#include <string>

std::string asString(const std::chrono::system_clock::time_point& tp)
{
    std::time_t t = std::chrono::system_clock::to_time_t(tp);
    std::cout << "t:" << t << std::endl;
    std::string ts = std::ctime(&t);
    ts.resize(ts.size()-1);
    
    return ts;
}

std::string asString2(const std::chrono::system_clock::time_point& tp)
{
    std::time_t t = std::chrono::system_clock::to_time_t(tp);
    if (t <= 0) {
        return "";
    }
    std::string ts = std::ctime(&t);
    ts.resize(ts.size()-1);
    
    return ts;
}

void test1();
void test2();

void test1() {
    try {
        std::chrono::system_clock::time_point tp;
        std::cout << "epoch: " << asString(tp) << std::endl << std::endl;
        
        tp = std::chrono::system_clock::now();
        std::cout << "now: " << asString(tp) << std::endl << std::endl;
        
        tp = std::chrono::system_clock::time_point::max();
        std::cout << "max: " << asString(tp) << std::endl << std::endl;
        
        tp = std::chrono::system_clock::time_point::min();
        
        std::cout << "hours since epoch: " << std::chrono::duration_cast<std::chrono::hours>(tp.time_since_epoch()).count() << '\n';
        std::cout << "min: " << asString(tp) << std::endl << std::endl;
    } catch (std::exception& ex) {
        std::cout << "err: " << ex.what() << '\n';
    }
}

void test2()
{
    try {
        std::chrono::system_clock::time_point tp;
        std::cout << "epoch: " << asString2(tp) << std::endl << std::endl;
        
        
        tp = std::chrono::system_clock::now();
        std::cout << "now: " << asString2(tp) << std::endl << std::endl;
        
        tp = std::chrono::system_clock::time_point::max();
        std::cout << "max: " << asString2(tp) << std::endl << std::endl;
        
        tp = std::chrono::system_clock::time_point::min();
        std::cout << "hours since epoch: " << std::chrono::duration_cast<std::chrono::hours>(tp.time_since_epoch()).count() << '\n';
        
        std::cout << "min: " << asString2(tp) << std::endl << std::endl;
    } catch (std::exception& ex) {
        std::cout << "err: " << ex.what() << '\n';
    }
}

int main(int argc, const char * argv[]) {
    
    test2();
    
    std::cout << "Hello, World!\n";
    return 0;
}

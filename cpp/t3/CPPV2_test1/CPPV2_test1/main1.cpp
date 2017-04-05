//
//  main.cpp
//  CPPV2_test1
//
//  Created by kai on 17/3/28.
//  Copyright © 2017年 kai. All rights reserved.
//

#include <stdio.h>
#include <chrono>
#include <ctime>
#include <iostream>
#include <string>
#include <system_error>

std::string asString(const std::chrono::system_clock::time_point& tp)
{
    std::time_t t = std::chrono::system_clock::to_time_t(tp);
    std::string ts = std::ctime(&t);
    ts.resize(ts.size()-1);
    
    return ts;
}

std::string asString2(const std::chrono::system_clock::time_point& tp)
{
    std::time_t t = std::chrono::system_clock::to_time_t(tp);
    if (t <= 0) {
        std::error_code ec(-1, std::generic_category());
        throw std::system_error(ec, "error time");
    }
    std::string ts = std::ctime(&t);
    ts.resize(ts.size()-1);
    
    return ts;
}

void test1();
void test2();

int main(int argc, const char* argv[])
{
    test1();
    
    return 0;
}

void test1()
{
    typedef std::chrono::duration<int, std::ratio<3600*24>> Days;
    
    std::chrono::time_point<std::chrono::system_clock> tp;
    std::cout << "epoch: " << asString(tp) << std::endl;
    
    tp += Days(1) + std::chrono::hours(23) + std::chrono::minutes(55);
    std::cout << "later: " << asString(tp) << std::endl;
    
    auto diff = tp - std::chrono::system_clock::time_point();
    std::cout << "diff: "
    << std::chrono::duration_cast<std::chrono::minutes>(diff).count()
    << "minute(s)" << std::endl;
    
    Days days = std::chrono::duration_cast<Days>(diff);
    std::cout << "diff: " << days.count() << " day(s)" << std::endl;
    
    tp -= std::chrono::hours(24*365);
    std::cout << "-1 year: " << asString(tp) << std::endl;
    
    tp  -= std::chrono::duration<int, std::ratio<3600*24*365>>(50);
    std::cout << "-50 years: " << asString(tp) << std::endl;
    
    tp -= std::chrono::duration<int, std::ratio<3600*24*365>>(50);
    std::cout << "-50 years: " << asString(tp) << std::endl;
}

void test2()
{
    typedef std::chrono::duration<int, std::ratio<3600*24>> Days;
    
    try {
        std::chrono::time_point<std::chrono::system_clock> tp;
        std::cout << "epoch: " << asString2(tp) << std::endl;
        
        tp += Days(1) + std::chrono::hours(23) + std::chrono::minutes(55);
        std::cout << "later: " << asString2(tp) << std::endl;
        
        auto diff = tp - std::chrono::system_clock::time_point();
        std::cout << "diff: "
        << std::chrono::duration_cast<std::chrono::minutes>(diff).count()
        << " minute(s)" << std::endl;
        Days days = std::chrono::duration_cast<Days>(diff);
        std::cout << "diff: " << days.count() << " day(s)" << std::endl;
        
        tp -= std::chrono::hours(24*365);
        std::cout << "-1 year: " << asString2(tp) << std::endl;
        
        tp -= std::chrono::duration<int, std::ratio<3600*24*365>>(50);
        std::cout << "-50 years: " << asString2(tp) << std::endl;
        
        tp -= std::chrono::duration<int, std::ratio<3600*24*365>>(50);
        std::cout << "-50 years: " << asString2(tp) << std::endl;
    } catch (const std::system_error& err) {
        std::cout << "ERROR:\n";
        std::cout << "\tCODE: " << err.code() << '\n';
        std::cout << "\tMSG: " << err.what() << '\n';
    }
}

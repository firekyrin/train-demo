//
//  main.cpp
//  iomanip-demo
//
//  Created by kai on 17/3/21.
//  Copyright © 2017年 kai. All rights reserved.
//

#include <iostream>
#include <iomanip>

void test1() {
    std::cout << std::setw(3) << 1 <<std::setw(3) << 10 << std::setw(3) << 100 << std::endl;
    
    std::cout << std::setw(5) << 255 << std::endl;
    
    std::cout << std::setfill('@') << std::setw(5) << 255 << std::endl;
    
    std::cout << std::setfill('*') << std::setw(6) << 123 << 456 << std::endl;
    
    std::cout << std::setbase(8) << std::setw(5) << 255 << std::endl;
    
    std::cout << std::setbase(10) << std::setw(5) << 255 << std::endl;
    
    std::cout << std::setbase(16) << std::setw(5) << 255 << std::endl;
    
    
    std::cout << 12345.0 << std::endl; //输出12345
    std::cout << std::setiosflags(std::ios::fixed) << std::setprecision(3) << 1.2345 << std::endl; //输出1.234（遵循四舍六入五成双原则，而不是四舍五入原则）
    std::cout << std::resetiosflags(std::ios::fixed) << std::endl; //需要用resetiosflags()函数清楚前面的输出格式
    std::cout << std::setiosflags(std::ios::scientific) << 12345.0 << std::endl; //输出1.234e+04
    std::cout << std::setiosflags(std::ios::fixed) << std::setprecision(3) << 12345.0 << std::endl; //输出1.234e+04
}

int main(int argc, const char * argv[]) {
    test1();
    
    std::cout << "Hello, World!\n";
    return 0;
}

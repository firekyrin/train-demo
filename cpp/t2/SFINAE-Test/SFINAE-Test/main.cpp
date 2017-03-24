//
//  main.cpp
//  SFINAE-Test
//
//  Created by kai on 17/3/24.
//  Copyright © 2017年 kai. All rights reserved.
//

#include <iostream>

long multiply(int i, int j) {
    return i * j;
}

template <class T>
typename T::multiplication_result multiply(T t1, T t2) {
    return t1 * t2;
}

int main(int argc, const char * argv[]) {
    std::cout << multiply(4, 5) << std::endl;
    
    std::cout << "Hello, World!\n";
    return 0;
}

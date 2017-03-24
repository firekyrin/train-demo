//
//  main.cpp
//  SFINAE-Test3
//
//  Created by kai on 17/3/24.
//  Copyright © 2017年 kai. All rights reserved.
//

#include <iostream>

template<typename T>
struct has_no_destry {
    template<typename C>
    static char test(decltype(&C::no_destroy));
    
    template<typename C>
    static int32_t test(...);
    
    const static bool value = sizeof(test<T>(0)) == 1;
};

struct A {
    
};

struct B {
    void no_destroy(){}
};

struct C {
    int no_destroy;
};

struct D : B {
    
};

void testNoDestroy() {
    printf("%d\n", has_no_destry<A>::value);
    printf("%d\n", has_no_destry<B>::value);
    printf("%d\n", has_no_destry<C>::value);
    printf("%d\n", has_no_destry<D>::value);
}


int main(int argc, const char * argv[]) {
    testNoDestroy();
    
    std::cout << "Hello, World!\n";
    return 0;
}

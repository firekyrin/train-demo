//
//  main.cpp
//  SFINAE-Test2
//
//  Created by kai on 17/3/24.
//  Copyright © 2017年 kai. All rights reserved.
//

#include <iostream>

template <class T>
struct is_pointer {
    template <class U>
    static char is_ptr(U *);
    
    template <class X, class Y>
    static char is_ptr(Y X::*);
    
    template <class U>
    static char is_ptr(U (*)());
    
    static double is_ptr(...);
    
    static T t;
    enum {value = sizeof(is_ptr(t)) == sizeof(char)};
};

struct Foo {
    int bar;
};

void testTypeCheck() {
    typedef int * IntPtr;
    typedef int Foo::* FooMemberPtr;
    typedef int (*FuncPtr)();
    
    printf("%d\n", is_pointer<IntPtr>::value);
    printf("%d\n", is_pointer<FooMemberPtr>::value);
    printf("%d\n", is_pointer<FuncPtr>::value);
}

int main(int argc, const char * argv[]) {
    
    testTypeCheck();
    
    std::cout << "Hello, World!\n";
    return 0;
}

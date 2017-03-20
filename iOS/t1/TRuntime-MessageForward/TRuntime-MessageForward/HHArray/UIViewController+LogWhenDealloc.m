//
//  UIViewController+LogWhenDealloc.m
//  TRuntime-MessageForward
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import "UIViewController+LogWhenDealloc.h"
#import <objc/runtime.h>

@implementation UIViewController (LogWhenDealloc)

+ (void)load {
    Method originDealloc = class_getInstanceMethod(self, NSSelectorFromString(@"dealloc"));
    Method swizzleDealloc = class_getInstanceMethod(self, @selector(swizzleDealloc));
    method_exchangeImplementations(originDealloc, swizzleDealloc);
    
    Method originDidReceiveMemoryWarning = class_getInstanceMethod(self, @selector(didReceiveMemoryWarning));
    Method swizzleDidReceiveMemoryWarning = class_getInstanceMethod(self, @selector(swizzleDidReceiveMemoryWarning));
    method_exchangeImplementations(originDidReceiveMemoryWarning, swizzleDidReceiveMemoryWarning);
}

- (void)swizzleDealloc {
    NSString *className = NSStringFromClass([self class]);
    if (![className hasPrefix:@"UI"] && ![className hasPrefix:@"_UI"]) {
        NSLog(@"-----------------Dealloc:%@------------------", className);
    }
    [self swizzleDealloc];
}

- (void)swizzleDidReceiveMemoryWarning {
    NSString *className = NSStringFromClass([self class]);
    if (![className hasPrefix:@"UI" ] && ![className hasPrefix:@"_UI"]) {
        NSLog(@"----------------------MemoryWarning:%@-----------", className);
    }
    
    [self swizzleDidReceiveMemoryWarning];
}

@end

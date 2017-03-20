//
//  NSArray+SafeArray.m
//  TRuntime-MessageForward
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import "NSArray+SafeArray.h"
#import <objc/runtime.h>

@implementation NSArray (SafeArray)

+ (void)load {
    Method originMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method swizzleMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(swizzleObjectAtIndex:));
    method_exchangeImplementations(originMethod, swizzleMethod);
}

- (id)swizzleObjectAtIndex:(NSUInteger)index {
    return index < self.count ? [self swizzleObjectAtIndex:index] : nil;
}

@end

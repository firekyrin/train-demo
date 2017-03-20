//
//  NSNull+SafeJson.m
//  TRuntime-MessageForward
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import "NSNull+SafeJson.h"

#define NSNullObjects @[@"", @0, @{}, @[]]

@implementation NSNull (SafeJson)

- (id)forwardingTargetForSelector:(SEL)aSelector {
    for (id null in NSNullObjects) {
        if ([null respondsToSelector:aSelector]) {
            return null;
        }
    }
    
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        for (NSObject *object in NSNullObjects) {
            signature = [object methodSignatureForSelector:aSelector];
            if (signature) {
                break;
            }
        }
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = [anInvocation selector];
    for (NSObject *object in NSNullObjects) {
        if ([object respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    
    return [self doesNotRecognizeSelector:aSelector];
}

@end

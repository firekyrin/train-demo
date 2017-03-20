//
//  SomeObject.m
//  TRuntime-MessageForward
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import "SomeObject.h"

@interface SomeObject ()

@property (strong, nonatomic) NSString *name;

@end

@implementation SomeObject

- (void)dealloc {
    NSLog(@"dealloc: %@", self.name);
}

+ (instancetype)objectWithName:(NSString *)name {
    SomeObject *object = [SomeObject new];
    object.name = name;
    return object;
}

- (void)doAnything {
    NSLog(@"%@: doAnything", self.name);
}

- (void)doSomething {
    NSLog(@"%@: doSomething", self.name);
}

@end

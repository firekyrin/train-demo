//
//  Person.m
//  TRuntime-MessageForward
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    if (self = [super init]) {
        self.age = age;
        self.name = name;
        
        [self personFunc:@"everything, nothing"];
    }
    
    return self;
}

- (void)personFunc:(NSString *)func {
    NSLog(@"personFunc--%@", func);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Person: name(%@) age(%ld)", self.name, self.age];
}

@end

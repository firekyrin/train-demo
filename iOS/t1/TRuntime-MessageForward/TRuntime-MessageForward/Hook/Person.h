//
//  Person.h
//  TRuntime-MessageForward
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age;

@end

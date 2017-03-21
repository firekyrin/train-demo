//
//  NSObject+DataMerge.h
//  TRunTime-ProtobufParser
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DataMerge)

- (instancetype)deepCopy;

+ (instancetype)instanceWithObject:(id)object;
+ (instancetype)instanceWithObject:(id)object ignoreProperties:(NSArray<NSString *> *)ignoreProperties;
+ (instancetype)instanceWithObject:(id)object mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues;
+ (instancetype)instanceWithObject:(id)object ignoreProperties:(NSArray<NSString *> *)ignoreProperties mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues;

- (void)setupWithObject:(id)object;
- (void)setupWithObject:(id)object ignoreProperties:(NSArray<NSString *> *)ignoreProperties;
- (void)setupWithObject:(id)object mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues;
- (void)setupWithObject:(id)object ignoreProperties:(NSArray<NSString *> *)ignoreProperties mapKeyValues:(NSDictionary<NSString *, NSString *> *)mapKeyValues;

@end

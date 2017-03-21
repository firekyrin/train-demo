//
//  NSObject+ProtobufExtension.h
//  TRunTime-ProtobufParser
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kHHObjectClassName;
extern NSString *const kHHProtobufObjectKeyPath;

@protocol HHProtobufExtension <NSObject>

+ (NSArray *)ignorePropertiesForProtobuf; //从protobuf解析时忽略的属性
+ (NSDictionary *)replacedPropertyKeypathsForProtobuf; //protobuf替换键值
+ (NSDictionary *)containerPropertyKeypathsForProtobuf; //model中有model/model数组时对应的kepath

@end

@interface NSObject (ProtobufExtension)

+ (instancetype)instanceWithProtoObject:(id)protoObject; //protobuf数据转换为模型
@end

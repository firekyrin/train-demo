//
//  HHClassInfo.h
//  TRunTime-ProtobufParser
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef enum : NSUInteger {
    HHPropertyTypeUnknown = 0,
    HHPropertyTypeVoid = 1,
    HHPropertyTypeBool = 2,
    HHPropertyTypeInt8 = 3,
    HHPropertyTypeUInt8 = 4,
    HHPropertyTypeInt16 = 5,
    HHPropertyTypeUInte16 = 6,
    HHPropertyTypeInt32 = 7,
    HHPropertyTypeUInt32 = 8,
    HHPropertyTypeInt64 = 9,
    HHPropertyTypeUInt64 = 10,
    HHPropertyTypeFloat = 11,
    HHPropertyTypeDouble = 12,
    HHPropertyTypeLongDouble = 13,
    HHPropertyTypeArray = 14,
    HHPropertyTypeCustomObject = 15,
    HHPropertyTypeFoundationObject = 16
}HHPropertyType;

@interface HHPropertyInfo : NSObject {
    @package
    SEL _setter;
    SEL _getter;
    Class _cls;
    NSString *_name;
    NSString *_getPath;
    HHPropertyType _type;
}

+ (instancetype)propertyWithProperty:(objc_property_t)property;

@end

@interface HHClassInfo : NSObject

+ (instancetype)classInfoWithClass:(Class)cls ignoreProperties:(NSArray *)ignoreProperties replacePropertyKeypaths:(NSDictionary *)replacePropertyKeypaths;

- (NSArray<HHPropertyInfo *> *)properties;

@end

//
//  HHClassInfo.m
//  TRunTime-ProtobufParser
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import "HHClassInfo.h"

#pragma mark - HHPropertyInfo

@interface HHPropertyInfo ()

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) SEL getter;
@property (assign, nonatomic) SEL setter;
@property (assign, nonatomic) Class cls;
@property (assign, nonatomic) HHPropertyType type;
@property (assign, nonatomic) objc_property_t property;

@end

@implementation HHPropertyInfo

NS_INLINE HHPropertyType getPropertyType(const char *type) {
    switch (*type) {
        case 'B': return HHPropertyTypeBool;
        case 'c': return HHPropertyTypeInt8;
        case 'C': return HHPropertyTypeUInt8;
        case 's': return HHPropertyTypeInt16;
        case 'S': return HHPropertyTypeUInte16;
        case 'i': return HHPropertyTypeInt32;
        case 'I': return HHPropertyTypeUInt32;
        case 'l': return HHPropertyTypeInt32;
        case 'L': return HHPropertyTypeUInt32;
        case 'q': return HHPropertyTypeInt64;
        case 'Q': return HHPropertyTypeUInt64;
        case 'f': return HHPropertyTypeFloat;
        case 'd': return HHPropertyTypeDouble;
        case 'D': return HHPropertyTypeLongDouble;
        case '@': {
            NSString *typeString = [NSString stringWithCString:type encoding:NSUTF8StringEncoding];
            if ([typeString rangeOfString:@"Array"].length > 0) {
                return HHPropertyTypeArray;
            }
            if ([typeString rangeOfString:@"NS"].length > 0) {
                return HHPropertyTypeFoundationObject;
            }
            return HHPropertyTypeCustomObject;
        }
            
        default:
            return 0;
    }
}

+ (instancetype)propertyWithProperty:(objc_property_t)property {
    HHPropertyInfo *info = [HHPropertyInfo new];
    
    char *propertyAttribute = property_copyAttributeValue(property, "T");
    info->_name = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
    info->_type = getPropertyType(propertyAttribute);
    info->_setter = NSSelectorFromString([NSString stringWithFormat:@"set %@%@:", [[info->_name substringToIndex:1] uppercaseString], [info->_name substringFromIndex:1]]);
    info->_getter = NSSelectorFromString(info->_name);
    info->_getPath = info->_name;
    info->_property = property;
    
    if (info->_type >= 14) {
        NSString *propertyClassName = [NSString stringWithCString:propertyAttribute encoding:NSUTF8StringEncoding];
        if (![propertyClassName isEqualToString:@"@"]) {
            info->_cls = NSClassFromString([[propertyClassName componentsSeparatedByString:@"\""] objectAtIndex:1]);
        }
    }
    
    free(propertyAttribute);
    
    return info;
}

@end

@interface HHClassInfo ()

@property (strong, nonatomic) NSArray *properties;
@property (nonatomic) Class cls;

@end

#define IgnorePropertyNames @[@"debugDescription", @"description", @"superclass", @"hash"]

@implementation HHClassInfo

+ (instancetype)classInfoWithClass:(Class)cls ignoreProperties:(NSArray *)ignoreProperties replacePropertyKeypaths:(NSDictionary *)replacePropertyKeypaths {
    HHClassInfo *classInfo = [HHClassInfo new];
    classInfo.cls = cls;
    NSMutableArray *properties = [NSMutableArray array];
    while (cls != [NSObject class] && cls != [NSProxy class]) {
        [properties addObjectsFromArray:[self propertiesWithClass:cls ignoreProperties:ignoreProperties replacePropertyKeypaths:replacePropertyKeypaths]];
        cls = [cls superclass];
    }
    classInfo.properties = [properties copy];
    return classInfo;
}

+ (NSArray *)propertiesWithClass:(Class)cls ignoreProperties:(NSArray *)ignoreProperties replacePropertyKeypaths:(NSDictionary *)replacePropertyKeypaths {
    uint count;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    NSMutableArray *propertyInfos = [NSMutableArray array];
    
    NSMutableSet *ignorePropertySet = [NSMutableSet setWithArray:IgnorePropertyNames];
    [ignorePropertySet addObjectsFromArray:ignoreProperties];
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([ignorePropertySet containsObject:propertyName]) {
            continue;
        }
        
        
        HHPropertyInfo *propertyInfo = [HHPropertyInfo propertyWithProperty:property];
        if (replacePropertyKeypaths.count > 0) {
            NSString *replaceKey = replacePropertyKeypaths[propertyInfo->_name];
            if (replaceKey != nil) {
                propertyInfo->_getter = NSSelectorFromString(replaceKey);
                propertyInfo->_getPath = replaceKey;
            }
        }
        [propertyInfos addObject:propertyInfo];
    }
    free(properties);
    
    return propertyInfos;
}

@end

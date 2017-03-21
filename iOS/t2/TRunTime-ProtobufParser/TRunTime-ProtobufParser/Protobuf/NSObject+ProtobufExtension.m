//
//  NSObject+ProtobufExtension.m
//  TRunTime-ProtobufParser
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import "NSObject+ProtobufExtension.h"
#import <objc/runtime.h>
#import <objc/message.h>

#import "HHClassInfo.h"

#pragma mark - Protobuf

NSString *const kHHObjectClassName = @"kHHObjectClassName";
NSString *const kHHProtobufObjectKeyPath = @"kHHProtobufObjectKeyPath";

@implementation NSObject (ProtobufExtension)

+ (instancetype)instanceWithProtoObject:(id)protoObject {
    if (!protoObject) {
        return nil;
    }
    
    static SEL toNSArraySEL;
    if (toNSArraySEL == nil) {
        toNSArraySEL = NSSelectorFromString(@"toNSArray");
    }
    
    Class cls = [self class];
    id instance = [self new];
    
    NSArray *properties = [NSObject classInfoToParseProtobuf:cls].properties; //1.获取对象的变量信息
    NSDictionary *containerPropertyKeypaths; //2.获取Model中属性为数组，数组中也是model的映射字典
    if ([(id)cls respondsToSelector:@selector(containerPropertyKeypathsForProtobuf)]) {
        containerPropertyKeypaths = [(id)cls containerPropertyKeypathsForProtobuf];
    }
    
    for (HHPropertyInfo *property in properties) {
        if (containerPropertyKeypaths[property->_name]) {
            //针对2中的情况进行处理后赋值
            id propertyValue = [self propertyValueForKeypathWithProtoObject:protoObject propertyName:property->_name];
            if (propertyValue) {
                ((void (*)(id, SEL, id))(void *) objc_msgSend)(instance, property->_setter, propertyValue);
            }
        }
        else if ([protoObject respondsToSelector:property->_getter]) {
            id propertyValue = [protoObject valueForKey:property->_getPath];
            if (propertyValue != nil) {
                //3.通过变量信息进行相应的赋值
                
                HHPropertyType type = property->_type;
                switch (type) {
                    case HHPropertyTypeBool:
                    case HHPropertyTypeInt8:
                    {
                        if ([propertyValue respondsToSelector:@selector(boolValue)]) {
                            ((void (*)(id, SEL, bool))(void *)objc_msgSend)(instance, property->_setter, [propertyValue boolValue]);
                        }
                    }
                        break;

                        case HHPropertyTypeInt32:
                        case HHPropertyTypeUInt32:
                    {
                        if ([propertyValue respondsToSelector:@selector(intValue)]) {
                            ((void (*)(id, SEL, int))(void *)objc_msgSend)(instance, property->_setter, [propertyValue intValue]);
                        }
                    }
                        break;
                        
                    case HHPropertyTypeInt64:
                    case HHPropertyTypeUInt64:
                    {
                        if ([propertyValue respondsToSelector:@selector(longValue)]) {
                            ((void (*)(id ,SEL, long))(void *)objc_msgSend)(instance, property->_setter, [propertyValue longValue]);
                        }
                    }
                        break;
                    case HHPropertyTypeFloat:
                    {
                        if ([propertyValue respondsToSelector:@selector(floatValue)]) {
                            ((void (*)(id, SEL, float))(void *)objc_msgSend)(instance, property->_setter, [propertyValue floatValue]);
                        }
                    }
                        break;
                    case HHPropertyTypeDouble:
                    {
                        if ([propertyValue respondsToSelector:@selector(doubleValue)]) {
                            ((void (*)(id, SEL, double))(void *)objc_msgSend)(instance, property->_setter, [propertyValue doubleValue]);
                        }
                    }
                        break;
                    case HHPropertyTypeCustomObject:
                    {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)(instance, property->_setter, [property->_cls instanceWithProtoObject:propertyValue]);
                    }
                        break;
                    case HHPropertyTypeArray:
                    {
                        if ([propertyValue respondsToSelector:@selector(toNSArraySEL)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                            propertyValue = [propertyValue performSelector:toNSArraySEL];
#pragma clang diagnostic pop
                        }
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)(instance, property->_setter, propertyValue);
                    }
                        break;
                        
                             
                    default:
                    {
                        ((void (*)(id, SEL, id))(void *)objc_msgSend)(instance, property->_setter, propertyValue);
                    }
                        break;
                }
            }
        }
    }
    
    return instance;
}

+ (id)propertyValueForKeypathWithProtoObject:(id)protoObject propertyName:(NSString *)propertyName {
    Class cls = self;
    id map = [[cls containerPropertyKeypathsForProtobuf] objectForKey:propertyName];
    
    NSString *keyPath;
    Class objectClass;
    if ([map isKindOfClass:[NSDictionary class]]) {
        keyPath = [map objectForKey:kHHProtobufObjectKeyPath];
        objectClass = NSClassFromString(map[kHHObjectClassName]);
    }
    else {
        keyPath = propertyName;
        objectClass = NSClassFromString(map);
    }
    
    id value = [protoObject valueForKeyPath:keyPath];
    if (![value isKindOfClass:[NSArray class]]) {
        return [objectClass instanceWithProtoObject:value];
    }
    else {
        NSMutableArray *mArr = [NSMutableArray array];
        for (id message in value) {
            [mArr addObject:[objectClass instanceWithProtoObject:message]];
        }
        
        return mArr;
    }
    
    return nil;
}


+ (HHClassInfo *)classInfoToParseProtobuf:(Class)cls {
    static NSMutableDictionary<Class, HHClassInfo *> *objectClassess;
    static dispatch_semaphore_t lock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lock = dispatch_semaphore_create(1);
        objectClassess = [NSMutableDictionary dictionary];
    });
    
    HHClassInfo *classInfo = objectClassess[cls];
    if (!classInfo) {
        NSArray *ignoreProperties = [(id)cls respondsToSelector:@selector(ignorePropertiesForProtobuf)] ? [(id)cls ignorePropertiesForProtobuf] : nil;
        NSDictionary *replacePropertyKeypaths = [(id)cls respondsToSelector:@selector(replacedPropertyKeypathsForProtobuf)] ?[(id)cls replacedPropertyKeypathsForProtobuf] : nil;
        
        classInfo = [HHClassInfo classInfoWithClass:cls ignoreProperties:ignoreProperties replacePropertyKeypaths:replacePropertyKeypaths];
        dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
        objectClassess[(id)cls] = classInfo;
        dispatch_semaphore_signal(lock);
    }
    
    return classInfo;
}

@end

//
//  HHContainerAlbum.m
//  TRunTime-ProtobufParser
//
//  Created by kai on 17/3/21.
//  Copyright © 2017年 kai. All rights reserved.
//

#import "HHContainerAlbum.h"
#import "NSObject+ProtobufExtension.h"

@implementation ProtoResult

@end

@implementation ProtoContainerAlbum

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"albumArray": @"ProtoAlbum"};
}

@end

@implementation HHContainerAlbum

+ (NSDictionary *)map {
    return @{@"HHavatar": @"avatar",
             @"HHnickname": @"nickname",
             @"HHalbumName": @"albumName",
             @"HHuserId": @"userId"};
}

#pragma mark - Protobuf

+ (NSDictionary *)replacedPropertyKeypathsForProtobuf {
    return [self map];
}

+ (NSDictionary *)containerPropertyKeypathsForProtobuf {
    return @{@"albumArray": @"HHAlbum",
             @"strangeAlbumArray": @{kHHObjectClassName: @"HHAlbum",
                                     kHHProtobufObjectKeyPath: @"result.albumArray"}};
}

#pragma mark - YY
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return [self map];
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"albumArray": @"HHAlbum"};
}

#pragma mark - MJ
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return [self map];
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"albumArray": @"HHAlbum"};
}

@end

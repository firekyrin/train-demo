//
//  HHCustomAlbum.m
//  TRunTime-ProtobufParser
//
//  Created by kai on 17/3/21.
//  Copyright © 2017年 kai. All rights reserved.
//

#import "HHCustomAlbum.h"

@implementation ProtoCustomAlbum

@end

@implementation HHCustomAlbum

+ (NSDictionary *)map {
    return @{@"HHavatar": @"avatar",
             @"HHnickname": @"nickname",
             @"HHalbumName": @"albumName",
             @"HHuserId": @"userId"};
}

#pragma mark - Protobuf

+ (NSDictionary *)replacedPropertyKeypathsProtobuf {
    return [self map];
}

#pragma mark - YY
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return [self map];
}

#pragma mark - MJ
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return [self map];
}

@end

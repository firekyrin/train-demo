//
//  HHAlbum.h
//  TRunTime-ProtobufParser
//
//  Created by kai on 17/3/21.
//  Copyright © 2017年 kai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYKit.h>

@interface ProtoAlbum : NSObject

@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *albumDesc;
@property (strong, nonatomic) NSString *albumCover;

@property (assign, nonatomic) BOOL subscribeState;

@property (assign, nonatomic) NSInteger level;
@property (assign, nonatomic) NSInteger userId;
@property (assign, nonatomic) NSInteger albumId;
@property (assign, nonatomic) NSInteger clickTime;
@property (assign, nonatomic) NSInteger createTime;
@property (assign, nonatomic) NSInteger lastUpdTime;

@property (assign, nonatomic) NSInteger subscribeCount;
@property (assign, nonatomic) NSInteger albumVoiceCount;
@property (assign, nonatomic) NSInteger updateVoiceCount;
@property (assign, nonatomic) NSInteger friendSubscribeCount;

@property (strong, nonatomic) NSArray *subscribeUserArray;

@end

@interface HHAlbum : NSObject

@property (strong, nonatomic) NSString *HHavatar;
@property (strong, nonatomic) NSString *HHnickname;
@property (strong, nonatomic) NSString *albumDesc;
@property (strong, nonatomic) NSString *HHalbumName;
@property (strong, nonatomic) NSString *albumCover;

@property (assign, nonatomic) BOOL subscribeState;

@property (assign, nonatomic) NSInteger level;
@property (assign, nonatomic) NSInteger HHuserId;
@property (assign, nonatomic) NSInteger albumId;
@property (assign, nonatomic) NSInteger albumType;
@property (assign, nonatomic) NSInteger clickTime;
@property (assign, nonatomic) NSInteger createTime;
@property (assign, nonatomic) NSInteger lastUpdTime;

@property (assign, nonatomic) NSInteger subscribeCount;
@property (assign, nonatomic) NSInteger albumVoiceCount;
@property (assign, nonatomic) NSInteger updateVoiceCount;
@property (assign, nonatomic) NSInteger frinedSubscribeCount;

@property (strong, nonatomic) NSArray *subscribeUserArray;

@end

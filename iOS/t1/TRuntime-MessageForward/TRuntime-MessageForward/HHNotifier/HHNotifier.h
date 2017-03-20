//
//  HHNotifier.h
//  TRuntime-MessageForward
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HHNotifObservers(action) if (self.observers.hasObserver) { [self.observers action]; }

@interface HHNotifier : NSProxy

+ (instancetype)notifier;
+ (instancetype)ratainNotifier;

- (BOOL)hasObserver;
- (void)addObserver:(id)observer;
- (void)removeObserver:(id)observer;

@end

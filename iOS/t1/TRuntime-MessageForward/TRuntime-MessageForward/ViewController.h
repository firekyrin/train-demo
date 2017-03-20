//
//  ViewController.h
//  TRuntime-MessageForward
//
//  Created by kai on 17/3/20.
//  Copyright © 2017年 kai. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewController <NSObject>

@optional
- (void)doAnything;
- (void)doSomething;

@end

@interface ViewController : UIViewController


@end


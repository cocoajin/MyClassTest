//
//  KKProgressHUB.h
//  MyClassTest
//
//  Created by cocoa on 13-9-6.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kHUB_AnimateTimes 0.9f
#define kHUB_Alpha 0.85f
#define kHUB_margin_top 200

@interface KKProgressHUB : UIView


- (void)showLoadingHUB;
- (void)closeLoadedHUB;

+ (void)showLoadingHUB;
+ (void)showLoadingHUBcloseAfterDelay:(float )delayTime;

+ (void)closeLoadedHUB;



@end

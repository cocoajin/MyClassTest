//
//  KKTextHUB.h
//  BlockTest
//
//  Created by cocoa on 13-8-21.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  文本提示 HUB
 *
 */

#define kText_AnimateTimes 0.8f
#define kText_margin_top 200
#define kText_Alpha 1.0f

@interface KKTextHUB : UIView



+ (void)showWithText:(NSString *)aText;

@end

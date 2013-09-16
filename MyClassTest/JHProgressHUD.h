//
//  JHProgressHUD.h
//  MyClassTest
//
//  Created by cocoa on 13-9-6.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//


/*
     交通银行 网络加载 hud @cocoa版;
 */

#import <UIKit/UIKit.h>

/*
 * hud显示的位置；默认在正中间
 * 更改 kMarginTop 的值 可以调整 hud 居中 上下显示的位置
 */
#define kMarginTop 0

@interface JHProgressHUD : UIView

//显示
+ (void)showHUD;

//关闭
+ (void)closeHUD;

//显示并添加取消回调
+ (void)showHUDtapedCancel:(id)target callBack:(SEL)action;

//关闭并添加回调
+ (void)closeHUD:(id)target callBack:(SEL)action;

@end

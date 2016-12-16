//
//  KKLoadingView.h
//  KKLoadingView
//
//  Created by cocoajin on 14-4-12.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KKLoadingView : UIView

/**
 *  设置loading 文本；
 */
@property (nonatomic,strong)NSString *loadingText;

/**
 *  设置loading 背景颜色，默认为 whiteColor
 */
@property (nonatomic,strong)UIColor *loadingBackColor;

/**
 *  设置loading 背景图片，默认为 nil
 */
@property (nonatomic,strong)UIImage *loadingBackImage;

/**
 *  设置loading 文本颜色，默认为 darkGrayColor
 */
@property (nonatomic,strong)UIColor *loadingTextColor;

/**
 *  设置loading 指示器颜色，默认为 grayColor
 */
@property (nonatomic,strong)UIColor *loadingActivityColor;

/**
 *  隐藏并删除loadingView
 */
- (void)hideAndRemove;

@end




/**
 *  demo
 
 KKLoadingView *loadV = [KKLoadingView new];
 //loadingText为必填参数；
 loadV.loadingText = @"加载中...";
 
 //loadV.loadingBackImage = [UIImage imageNamed:@"backTest.png"];
 //loadV.loadingBackColor = [UIColor blueColor];
 //loadV.loadingTextColor = [UIColor blueColor];
 //loadV.loadingActivityColor = [UIColor redColor];
 
 
 //删除view
 //[loadV hideAndRemove];
 
 [self.view addSubview:loadV];
 
 
 */






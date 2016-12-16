//
//  KKLoadingErrorView.h
//  KKLoadingView
//
//  Created by cocoajin on 14-4-14.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^KKErrorBlock)(void);

@interface KKLoadingErrorView : UIView

/**
 *  设置 显示文本，支持UILabel的属性
 */
@property (nonatomic,readonly)UILabel *errorLabel;

/**
 *  设置 显示图片，UIImage
 */
@property (nonatomic,strong)UIImage *errorImage;

/**
 *  错误处理,如刷新操作
 */
@property (nonatomic,copy)KKErrorBlock errorHandle;

/**
 *  隐藏并删除
 */
- (void)hideAndRemove;

@end



/**
 *  Demo
 
 KKLoadingErrorView *loadViewError = [KKLoadingErrorView new];
 loadViewError.errorImage = [UIImage imageNamed:@"refresh56.png"];
 loadViewError.errorHandle = ^{
 NSLog(@"line<%d> %s",__LINE__,__func__);
 };
 [self.view addSubview:loadViewError];
 
 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
 
 [loadViewError hideAndRemove];
 
 });
 
 
 
 */

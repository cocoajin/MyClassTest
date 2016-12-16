//
//  KKShowImage.h
//  ImageViewer
//
//  Created by cocoajin on 14-5-9.
//  Copyright (c) 2014年 www.zhgu.net. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAnimationTime 0.5


@interface KKShowImage : UIView

@property(nonatomic,strong)UIImage *image;

+ (void)showImage:(UIImage *)image;


@end

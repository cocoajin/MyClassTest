//
//  KKLoadingErrorView.m
//  KKLoadingView
//
//  Created by cocoajin on 14-4-14.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import "KKLoadingErrorView.h"

@interface KKLoadingErrorView ()

{
    UILabel *errorLabel;
    UIImageView *errorImageView;
}

@end

@implementation KKLoadingErrorView

- (id)initWithFrame:(CGRect)frame
{
    frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initTheUI];
        
    }
    return self;
}

- (void)hideAndRemove
{
    [self removeFromSuperview];
}

- (void)initTheUI
{
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.errorLabel];
    
    
    errorImageView = [[UIImageView alloc]init];
    errorImageView.backgroundColor = [UIColor clearColor];
    errorImageView.userInteractionEnabled = YES;
    
    [self addSubview:errorImageView];
    
}

//默认label设置
- (UILabel *)errorLabel
{
    if (!errorLabel) {
        errorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
        errorLabel.center = CGPointMake(self.center.x, self.center.y -50);
        errorLabel.text = @"加载失败，请点击刷新重新加载";
        errorLabel.textAlignment = NSTextAlignmentCenter;
        errorLabel.textColor = [UIColor darkGrayColor];
        errorLabel.font = [UIFont systemFontOfSize:15.0];
        errorLabel.shadowColor = [UIColor whiteColor];
		errorLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    }
    return errorLabel;
}


- (void)setErrorImage:(UIImage *)errorImage
{
    CGSize imageSize = errorImage.size;
    errorImageView.frame = CGRectMake((self.bounds.size.width-imageSize.width)/2, 0, imageSize.width, imageSize.height);
    errorImageView.center = CGPointMake(errorLabel.center.x, errorLabel.center.y-errorLabel.bounds.size.height/2-errorImageView.bounds.size.height/2);
    errorImageView.image = errorImage;
    
    _errorImage = errorImage;
    
}

- (void)setErrorHandle:(KKErrorBlock)errorHandle
{
    if (errorHandle) {
        _errorHandle = errorHandle;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doErrorHandle)];
        [errorImageView addGestureRecognizer:tapGest];

    }
}

- (void)doErrorHandle
{
    _errorHandle();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

//
//  KKProgressHUB.m
//  MyClassTest
//
//  Created by cocoa on 13-9-6.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "KKProgressHUB.h"
#define kWindow [[UIApplication sharedApplication].windows objectAtIndex:0]


@implementation KKProgressHUB


{
    UIView *hubContentView;
    UIActivityIndicatorView *indicator;
    UILabel *aLabel;
    
}

- (void)dealloc
{
    NSLog(@"line:(%d) class %s",__LINE__,__func__);
    [[KKProgressHUB sharedHub] release];
    [super dealloc];
}

+ (KKProgressHUB *)sharedHub
{
    static KKProgressHUB *sharedHub = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHub = [[self alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    });
    
    return  sharedHub;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame = CGRectMake(115, kHUB_margin_top, 95,95 );
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0f;
        
        hubContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        hubContentView.backgroundColor = [UIColor clearColor];
        [self addSubview:hubContentView];
        
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicator.color = [UIColor whiteColor];
        indicator.frame = CGRectMake(46 , 35, 0, 0);
        [hubContentView addSubview:indicator];
        [indicator startAnimating];
        
        aLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 53, 86, 35)];
        aLabel.backgroundColor = [UIColor clearColor];
        aLabel.textColor = [UIColor whiteColor];
        aLabel.font = [UIFont boldSystemFontOfSize:15];
        aLabel.textAlignment = NSTextAlignmentCenter;
        aLabel.text = @"加载中...";
        [hubContentView addSubview:aLabel];
        
        
        [kWindow addSubview:self];
        
        [aLabel release];
        [indicator release];
        [hubContentView release];
        
    }
    
    
    return self;
}

- (void)showLoadingHUB
{
    [self show];
}
- (void)closeLoadedHUB
{
    [self close];
}

+ (void)showLoadingHUB
{
    [[KKProgressHUB sharedHub] show];
}

+ (void)closeLoadedHUB
{
    [[KKProgressHUB sharedHub] close];
}

+ (void)showLoadingHUBcloseAfterDelay:(float )delayTime
{
    [KKProgressHUB showLoadingHUB];
    [[KKProgressHUB sharedHub] closeLoadedHUBdelayTime:delayTime];
}

- (void)closeLoadedHUBdelayTime:(float)delayTime
{
    [NSTimer scheduledTimerWithTimeInterval:delayTime target:self selector:@selector(close) userInfo:nil repeats:NO];
}

- (void)show
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [indicator startAnimating];
    [UIView animateWithDuration:kHUB_AnimateTimes animations:^{
        self.alpha = kHUB_Alpha;
    }];
    
}
- (void)close
{
    [UIView animateWithDuration:kHUB_AnimateTimes animations:^{
        self.alpha = 0.0f;
    }];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [NSTimer scheduledTimerWithTimeInterval:kHUB_AnimateTimes target:self selector:@selector(removeTheObject) userInfo:nil repeats:NO];
}

- (void)removeTheObject
{
    [indicator stopAnimating];
    //[self removeFromSuperview];
}


//Draw background

- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIGraphicsPushContext(context);
    
	CGRect boxRect = self.bounds;
	float radius = 10.0f;
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
	CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * (float)M_PI / 2, 0, 0);
	CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMaxY(boxRect) - radius, radius, 0, (float)M_PI / 2, 0);
	CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
	CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect) + radius, radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
	CGContextClosePath(context);
	CGContextFillPath(context);
	UIGraphicsPopContext();
    
    
}


@end


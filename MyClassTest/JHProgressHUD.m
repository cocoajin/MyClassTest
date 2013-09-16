//
//  JHProgressHUD.m
//  MyClassTest
//
//  Created by cocoa on 13-9-6.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "JHProgressHUD.h"

#define kWindow [[UIApplication sharedApplication].windows objectAtIndex:0]


@interface JHProgressHUD ()

@property(nonatomic,retain)id theTarget;
@property(nonatomic,assign)SEL theAction;
@property(nonatomic,assign)BOOL isCancelTap;


@end

@implementation JHProgressHUD

{
    UIActivityIndicatorView *activiView;
    UIViewController *rootVC;
}

@synthesize theAction,theTarget;


+ (JHProgressHUD *)sharedHud
{
    static JHProgressHUD *sharedHud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHud = [[self alloc]initWithFrame:CGRectZero];
    });
    
    return  sharedHud;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        rootVC = [self getRootViewController];
        [self setUpUI];
        [self addHudOnWindow];
        
    }
    return self;
}


+ (void)showHUD
{
    [[JHProgressHUD sharedHud] show];
    [JHProgressHUD sharedHud].isCancelTap = NO;

}

+ (void)closeHUD
{
    [[JHProgressHUD sharedHud] close];

}

+ (void)showHUDtapedCancel:(id)target callBack:(SEL)action
{
    [[JHProgressHUD sharedHud] show];
    [JHProgressHUD sharedHud].isCancelTap = YES;
    [[JHProgressHUD sharedHud] setTheTarget:target theAction:action];
}

+ (void)closeHUD:(id)target callBack:(SEL)action
{
    [[JHProgressHUD sharedHud] setTheTarget:target theAction:action];
    [JHProgressHUD sharedHud].isCancelTap = YES;
    [self closeHUD];
}

#pragma mark ------------  setUp   --------------------------


- (void)setTheTarget:(id)target theAction:(SEL)action
{
    self.theTarget = target;
    self.theAction = action;
}

- (void)show
{
    self.alpha = 1;
    
    [activiView startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    rootVC.view.userInteractionEnabled = NO;
    rootVC.view.alpha = 0.7;
    
}

- (void)close
{
    rootVC.view.userInteractionEnabled = YES;
    [self closeAnimation];
    rootVC.view.alpha = 1;


}

- (void)closeAnimation
{
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;

    }];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(closeTheActivi) userInfo:nil repeats:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

}

- (void)closeTheActivi
{
    [activiView stopAnimating];
    [self targetDoAction];
}

- (void)cancelTap
{
    [self close];
    //[self targetDoAction];
}

- (void)targetDoAction
{
    if (theTarget!=nil&&self.isCancelTap) {
        [theTarget performSelector:theAction];
    }

}

- (void)setUpUI
{
    int top = [self marginTop];
    self.frame = CGRectMake(105, top, 110, 35);
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0;
    self.isCancelTap = NO;
    
    activiView  =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(23, 17.5, 0, 0)];
    activiView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    activiView.color = [UIColor whiteColor];
    [self addSubview:activiView];
    
    UILabel *cancelLabel = [[UILabel alloc]initWithFrame:CGRectMake(46,0 , 55, 35)];
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.font = [UIFont boldSystemFontOfSize:18];
    cancelLabel.text = @"取消";
    cancelLabel.backgroundColor = [UIColor clearColor];
    cancelLabel.textColor = [UIColor whiteColor];
    cancelLabel.userInteractionEnabled = YES;
    [self addSubview:cancelLabel];
    UITapGestureRecognizer *cancelGuest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelTap)];
    [cancelLabel addGestureRecognizer:cancelGuest];
    
    [cancelGuest release];
    [cancelLabel release];
}

- (UIViewController *)getRootViewController
{
    return ((UIWindow *)[[UIApplication sharedApplication].windows objectAtIndex:0]).rootViewController;
}

- (void)addHudOnWindow
{
    
//    NSEnumerator *frontToBackWindows = [[[UIApplication sharedApplication]windows]reverseObjectEnumerator];
//    for (UIWindow *window in frontToBackWindows)
//        if (window.windowLevel == UIWindowLevelNormal) {
//            [window addSubview:self];
//            break;
//        }
    
    [kWindow addSubview:self];
    

}

- (CGFloat)marginTop
{
    return [UIScreen mainScreen].bounds.size.height/2 + kMarginTop;
}

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


- (void)lifeCycle
{
    
    [activiView release];
    activiView=nil;
    rootVC = nil;
}

- (void)dealloc
{
    theTarget = nil;
    theAction = nil;
    
    [[JHProgressHUD sharedHud] release];
    [super dealloc];
}

@end

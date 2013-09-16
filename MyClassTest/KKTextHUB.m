//
//  KKTextHUB.m
//  BlockTest
//
//  Created by cocoa on 13-8-21.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "KKTextHUB.h"
#define kWindow [[UIApplication sharedApplication].windows objectAtIndex:0]


@implementation KKTextHUB

{
    UILabel *theTextLabel;
}

+ (KKTextHUB *)sharedTextHUB
{
    static KKTextHUB *sharedHub = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHub = [[self alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    });
    
    return sharedHub;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(50, 50, 100, 50);
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0;
        
        theTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
        theTextLabel.text = @"";
        theTextLabel.textColor = [UIColor whiteColor];
        theTextLabel.textAlignment = NSTextAlignmentCenter;
        theTextLabel.numberOfLines = 0;
        theTextLabel.lineBreakMode = NSLineBreakByCharWrapping;
        theTextLabel.font = [UIFont boldSystemFontOfSize:16];
        theTextLabel.backgroundColor = [UIColor clearColor];
        
        
        [self addSubview:theTextLabel];
        [theTextLabel release];
        
        [kWindow addSubview:self];
        
        
    }
    
    return self;
}



+ (void)showWithText:(NSString *)aText
{
    [[KKTextHUB sharedTextHUB] setUpTheText:aText];
}

- (CGSize)sizeOfTheLabel:(UILabel *)aLabel
{
    CGSize theSize = CGSizeMake(0, 0);
    theSize = [aLabel.text sizeWithFont:aLabel.font constrainedToSize:CGSizeMake(230, 500) lineBreakMode:NSLineBreakByCharWrapping];
    return theSize;
}

- (void)setUpTheText:(NSString *)aText
{
    theTextLabel.text = aText;
    CGSize size = [self sizeOfTheLabel:theTextLabel];
    theTextLabel.frame = CGRectMake(25, 15, size.width, size.height);
    float marginLeft = (320 - size.width - 45)/2 ;
    self.frame = CGRectMake(marginLeft, kText_margin_top, size.width + 45, size.height + 30);
    if (marginLeft < 20) {
        theTextLabel.frame = CGRectMake(25, 15, size.width, size.height);
        self.frame = CGRectMake(20, kText_margin_top, 280, size.height + 30);
    }
    [self show];
}

- (void)show
{
    [UIView animateWithDuration:kText_AnimateTimes animations:^{
        self.alpha = kText_Alpha;
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(close) userInfo:nil repeats:NO];
}

- (void)close
{
    [UIView animateWithDuration:kText_AnimateTimes animations:^{
        self.alpha = 0;
    }];
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


@end



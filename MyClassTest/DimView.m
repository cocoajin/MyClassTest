//
//  DimView.m
//  MyClassTest
//
//  Created by cocoa on 13-9-5.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "DimView.h"

@implementation DimView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0 alpha:0.5] set];
    CGContextFillRect(context, self.bounds);
    
}


@end

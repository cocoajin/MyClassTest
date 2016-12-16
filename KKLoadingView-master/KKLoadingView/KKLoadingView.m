//
//  KKLoadingView.m
//  KKLoadingView
//
//  Created by cocoajin on 14-4-12.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import "KKLoadingView.h"



@interface KKLoadingView ()
{
    UILabel *loadingLabel;
    UIActivityIndicatorView *loadingActivityIndicator;
    UIImageView *backImageView;
}

@end

@implementation KKLoadingView

- (id)initWithFrame:(CGRect)frame
{
    frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self initTheView];
        
    }
    return self;
}



- (void)hideAndRemove
{
    [self removeFromSuperview];
}


#pragma mark private method

- (void)initTheView
{
    
    self.backgroundColor = [UIColor whiteColor];
    
    //set backImage
    backImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    backImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:backImageView];
    
    //set label
    loadingLabel = [[UILabel alloc]initWithFrame:self.bounds];
    loadingLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.font = [UIFont systemFontOfSize:15];
    loadingLabel.textColor = [UIColor darkGrayColor];
    loadingLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:loadingLabel];
    
    //set activityIndicator
    loadingActivityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingActivityIndicator.hidesWhenStopped = YES;
    [self addSubview:loadingActivityIndicator];

    

    
}

- (void)setLoadingText:(NSString *)loadingText
{
    loadingLabel.text = loadingText;
    
    
//    CGSize textSize = [loadingLabel.text sizeWithFont:loadingLabel.font constrainedToSize:CGSizeMake(300, 100)
//                                        lineBreakMode:NSLineBreakByWordWrapping];
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    CGSize textSize = [loadingText boundingRectWithSize:CGSizeMake(300, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    

    
    loadingActivityIndicator.center = CGPointMake(self.center.x - textSize.width/2 - 10, self.center.y);
    [loadingActivityIndicator startAnimating];
    
    _loadingText = loadingText;
}

- (void)setLoadingBackColor:(UIColor *)loadingBackColor
{
    if (loadingBackColor) {
        self.backgroundColor = loadingBackColor;
    }
    
    _loadingBackColor = loadingBackColor;

}

- (void)setLoadingBackImage:(UIImage *)loadingBackImage
{
    if (loadingBackImage) {
        backImageView.image = loadingBackImage;
    }
    
    _loadingBackImage = loadingBackImage;
}

- (void)setLoadingTextColor:(UIColor *)loadingTextColor
{
    if (loadingTextColor) {
        loadingLabel.textColor = loadingTextColor;
    }
    
    _loadingTextColor = loadingTextColor;
}

- (void)setLoadingActivityColor:(UIColor *)loadingActivityColor
{
    if (loadingActivityColor) {
        loadingActivityIndicator.color = loadingActivityColor;
    }
    _loadingActivityColor = loadingActivityColor;
}

@end

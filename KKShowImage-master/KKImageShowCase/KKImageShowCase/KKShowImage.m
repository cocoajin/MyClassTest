//
//  KKShowImage.m
//  ImageViewer
//
//  Created by cocoajin on 14-5-9.
//  Copyright (c) 2014年 www.zhgu.net. All rights reserved.
//

#import "KKShowImage.h"

#define kWindow [[UIApplication sharedApplication].windows objectAtIndex:0]


@interface KKShowImage ()

{
    UIImageView *imageView;
    UIScrollView *scrollView;
    CGFloat topLocation;
    
    UITapGestureRecognizer *tapGest;
    UITapGestureRecognizer *tapGest2;
    UIPinchGestureRecognizer *pinGest;
    UIPanGestureRecognizer *panGest;
    
}

@end

@implementation KKShowImage

- (id)initWithFrame:(CGRect)frame
{
    frame = [UIScreen mainScreen].bounds;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0;
        [self setUPBASE];
    }
    return self;
}

- (void)setUPBASE
{
 
    
    scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.userInteractionEnabled = YES;
    [scrollView addSubview:imageView];
}

- (void)taptheIMG
{
    if (self.alpha==1) {
        [self disMiss];
    }
    
    else if (self.alpha==0)
    {
        [self show];
    }
}

- (void)taped2ZoomIMAGE
{
    static BOOL isZoom = YES;
    if (isZoom) {
        panGest.enabled = NO;
        pinGest.enabled = NO;
        [self zoomDA];
    }
    else
    {
        panGest.enabled = YES;
        pinGest.enabled = YES;
        
        [self zoomXiao];
    }
    
    isZoom = !isZoom;
    
}

- (void)pinChangeImage:(UIPinchGestureRecognizer *)pins
{

    pins.view.transform = CGAffineTransformMakeScale(pins.scale, pins.scale);

    

}

- (void)pinTheImageInfo:(UIPanGestureRecognizer *)pan
{
    CGPoint superP = [pan translationInView:[pan.view superview]];
    [pan.view setCenter:CGPointMake([pan.view center].x + superP.x, [pan.view center].y + superP.y)];
    //把移动偏移量在移动中清0操作；
    [pan setTranslation:CGPointZero inView:pan.view.superview];
}

- (void)zoomDA
{
    [UIView animateWithDuration:0.35 animations:^{
        imageView.frame = CGRectMake(0, 0,[self widthFotImage:imageView.image]*1.2, [UIScreen mainScreen].bounds.size.height*1.2);
        scrollView.contentSize = imageView.bounds.size;

    }];
}

- (void)zoomXiao
{
    [UIView animateWithDuration:0.35 animations:^{
        
        imageView.frame = CGRectMake(0,self.center.y - [self heightForImage:imageView.image]/2,[UIScreen mainScreen].bounds.size.width, [self heightForImage:imageView.image]);
        scrollView.contentSize = imageView.bounds.size;
        
    }];
}


- (void)setImage:(UIImage *)image
{
    _image = image;
    
    if (image) {
        imageView.frame = CGRectZero;
        //imageView.center = CGPointMake(self.center.x, self.center.y);
        imageView.image = image;
        tapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taptheIMG)];
        tapGest.numberOfTapsRequired = 1;
        [imageView addGestureRecognizer:tapGest];
        
        tapGest2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(taped2ZoomIMAGE)];
        tapGest2.numberOfTapsRequired = 2;
        [imageView addGestureRecognizer:tapGest2];
        
        [tapGest requireGestureRecognizerToFail:tapGest2];
        
        pinGest = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinChangeImage:)];
        [imageView addGestureRecognizer:pinGest];
        [tapGest requireGestureRecognizerToFail:pinGest];
        
        panGest = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pinTheImageInfo:)];
        [imageView addGestureRecognizer:panGest];
        [tapGest requireGestureRecognizerToFail:panGest];
        panGest.enabled = NO;
        pinGest.enabled = NO;
        
        [self show];
    }
    
}


- (void)show
{
    [UIView animateWithDuration:kAnimationTime-0.2 animations:^{
        imageView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [self heightForImage:imageView.image]);
        imageView.center = CGPointMake(self.center.x, self.center.y);

    }];
    self.alpha = 1.0f;
    topLocation = self.center.y - imageView.bounds.size.height/2;
    
    pinGest.enabled = YES;
    panGest.enabled = YES;

}

- (void)disMiss
{
    [UIView animateWithDuration:kAnimationTime animations:^{
        imageView.frame = CGRectMake(0, topLocation*1.3,imageView.bounds.size.width*1.3, imageView.bounds.size.height*1.3);
        self.alpha = 0.0f;

    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kAnimationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self removeFromSuperview];
        
    });
    
    

    
}

- (CGFloat)widthFotImage:(UIImage *)image
{
    float scale = image.size.height >= [UIScreen mainScreen].bounds.size.height ? image.size.height/[UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.height/image.size.height;
    return image.size.width*scale;
}

- (CGFloat )heightForImage:(UIImage *)image
{
    float scale = image.size.width <= [UIScreen mainScreen].bounds.size.width ? image.size.width/[UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.width/image.size.width;
    return image.size.height*scale;
}

+ (void)showImage:(UIImage *)image
{
    KKShowImage *imageVV = [[KKShowImage alloc]initWithFrame:CGRectZero];
    imageVV.image = image;
    [kWindow addSubview:imageVV];
}



- (void)drawRect:(CGRect)rect {
    

    
}

@end

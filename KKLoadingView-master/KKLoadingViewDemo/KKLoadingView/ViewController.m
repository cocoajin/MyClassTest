//
//  ViewController.m
//  KKLoadingView
//
//  Created by cocoajin on 14-4-12.
//  Copyright (c) 2014年 www.zhgu.net. All rights reserved.
//

#import "ViewController.h"
#import "KKLoadingView.h"
#import "KKLoadingErrorView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    KKLoadingView *loadView = [[KKLoadingView alloc]init];
//    loadView.loadingText = @"加载中。。。";
//    //loadView.loadingBackImage = [UIImage imageNamed:@"loadBackTest.png"];
//    [self.view addSubview:loadView];
//    
//    self.view.backgroundColor = [UIColor grayColor];
    
    
    KKLoadingErrorView *loadViewError = [KKLoadingErrorView new];
    loadViewError.errorImage = [UIImage imageNamed:@"refresh56.png"];
    loadViewError.errorHandle = ^{
        NSLog(@"line<%d> %s",__LINE__,__func__);
    };
    [self.view addSubview:loadViewError];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //[loadViewError hideAndRemove];
        
    });
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

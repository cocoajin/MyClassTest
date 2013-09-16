//
//  ProgressHUBVC.m
//  MyClassTest
//
//  Created by cocoa on 13-9-6.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "ProgressHUBVC.h"
#import "KKProgressHUB.h"

@interface ProgressHUBVC ()

@end

@implementation ProgressHUBVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showBtn.frame = CGRectMake(10, 10, 130, 35);
    [showBtn setTitle:@"showBtn" forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showBtnTaped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeBtn.frame = CGRectMake(10, 55, 130, 35);
    [closeBtn setTitle:@"closeBtn" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnTaped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
}

- (void)showBtnTaped
{
    //[KKProgressHUB showLoadingHUBcloseAfterDelay:3.0f];
    [KKProgressHUB showLoadingHUB];
}

- (void)closeBtnTaped
{
    [KKProgressHUB closeLoadedHUB];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

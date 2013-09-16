//
//  JHProgressHUDVC.m
//  MyClassTest
//
//  Created by cocoa on 13-9-6.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "JHProgressHUDVC.h"
#import "JHProgressHUD.h"

@interface JHProgressHUDVC ()

@end

@implementation JHProgressHUDVC

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
    
    //self.view.backgroundColor = [UIColor colorWithRed:10/255.0 green:124/255.0 blue:151/255.0 alpha:1];
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showBtn.frame = CGRectMake(10, 10, 130, 35);
    [showBtn setTitle:@"showBtn" forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showBtnTaped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeBtn.frame = CGRectMake(165, 10, 130, 35);
    [closeBtn setTitle:@"closeBtn" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnTaped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    
    
}

- (void)showBtnTaped
{
    [JHProgressHUD showHUD];
    //[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(closeBtnTaped) userInfo:nil repeats:NO];

}

- (void)closeBtnTaped
{
    [JHProgressHUD showHUDtapedCancel:self callBack:@selector(tapCancel)];
    //[JHProgressHUD closeHUD:self callBack:@selector(tapCancel)];
}

- (void)tapCancel
{
    NSLog(@"line:(%d) class %s",__LINE__,__func__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

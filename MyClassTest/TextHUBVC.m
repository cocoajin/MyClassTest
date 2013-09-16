//
//  TextHUBVC.m
//  MyClassTest
//
//  Created by cocoa on 13-9-6.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "TextHUBVC.h"
#import "KKTextHUB.h"

@interface TextHUBVC ()

@end

@implementation TextHUBVC

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
	// Do any additional setup after loading the view.
    UIButton *showBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    showBtn.frame = CGRectMake(10, 10, 130, 35);
    [showBtn setTitle:@"show" forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showBtnTaped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:showBtn];
    
}

- (void)showBtnTaped
{
    [KKTextHUB showWithText:@"数据加载完成！"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

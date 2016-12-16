//
//  ViewController.m
//  KKLogView
//
//  Created by cocoajin on 14-4-19.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "KKLogView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    KKLogView *logView = [[KKLogView alloc]initWithController:self];
    logView.tag = 110;
    [logView printLog:@"hello everyone this is xcode project kklogview test"];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(doPrint) userInfo:nil repeats:YES];
    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
    
    
}

- (void)doPrint
{
    KKLogView *logView = (KKLogView *)[self.view viewWithTag:110];

    static int count = 0;
    count +=1;
    
    if (count>5) {
        return;
    }
    if (count==5) {
        [logView writeLogToFile:@"/Users/user/Desktop"];
    }
    
    [logView printLog:@"在美国西雅图和中国上海，腾讯科技两度与陆奇进行了深入接触，作为微软全球执行副总裁、应用和服务工程部负责人，陆奇现在管理着微软最重要的四大部门之一，直接负责Office、Bing、Skype及在线广告等多项业务的发展。用微软其他员工的话说，陆奇就是那个在微软拥有最大权势的华人。"];
    
    // [logView removeLogView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

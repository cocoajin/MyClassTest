//
//  RootViewController.m
//  KKImageShowCase
//
//  Created by cocoajin on 14-5-9.
//  Copyright (c) 2014年 www.zhgu.net. All rights reserved.
//

#import "RootViewController.h"
#import "KKShowImage.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
    imageV.image = [UIImage imageNamed:@"test2.png"];
    [self.view addSubview:imageV];
    
    imageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showIMAGESSS)];
    [imageV addGestureRecognizer:tap];
    
    
//    KKShowImage *show = [KKShowImage new];
//    show.image = [UIImage imageNamed:@"test2.png"];
//    [self.view addSubview:show];
}

//查看图片Action
- (void)showIMAGESSS
{
    [KKShowImage showImage:[UIImage imageNamed:@"test2.png"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  KKHttpTestVC.m
//  MyClassTest
//
//  Created by cocoa on 13-9-5.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "KKHttpTestVC.h"
#import "KKHttpRequest.h"

@interface KKHttpTestVC ()

@end

@implementation KKHttpTestVC

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
    
    NSString *aURL = @"http://api.map.baidu.com/place/search?&query=%E9%93%B6%E8%A1%8C&bounds=39.915,116.404,39.975,116.414&output=json&key=37492c0ee6f924cb5e934fa08c6b1676";
    
    NSString *bURL = @"http://192.168.1.136:8080/dishesorder/dishes/dishesbycid?categoryid=1";
    
    [KKHttpRequest requestWithURL:aURL completeBlock:^(id data) {
        NSLog(@"line:(%d) class %s",__LINE__,__func__);
        NSLog(@"%@",data);
    }];
    
    [KKHttpRequest requestWithURL:bURL completeTarget:self callBack:@selector(downData:)];
 
}

- (void)downData:(id)obj
{
    NSLog(@"line:(%d) class %s",__LINE__,__func__);
    NSLog(@"%@",obj);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

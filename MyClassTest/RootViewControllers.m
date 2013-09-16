//
//  RootViewController.m
//  MyClassTest
//
//  Created by cocoa on 13-9-3.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "RootViewControllers.h"
#import "KKHttpRequest.h"
#import "DimView.h"

@interface RootViewControllers ()

@end

@implementation RootViewControllers

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
    
    //__block id obj;
    
    //NSString *aURL = @"http://api.map.baidu.com/place/search?&query=%E9%93%B6%E8%A1%8C&bounds=39.915,116.404,39.975,116.414&output=json&key=37492c0ee6f924cb5e934fa08c6b1676";
//    [KKHttpRequest requestWithURL:aURL completeBlock:^(id data) {
//        //NSLog(@"%@",data);
//    }];
//    
//    NSString *bURL = @"http://192.168.1.136:8080/dishesorder/dishes/dishesbycid?categoryid=1";
//    [KKHttpRequest requestWithURL:bURL completeBlock:^(id data) {
//        //NSLog(@"%@",data);
//        obj = data;
//        //NSLog(@"%@",obj);
//        [self theData:data];
//
//        
//    }];
    
    //[KKHttpRequest requestWithURL:aURL completeTarget:self callBack:@selector(doData:)];

    
//    DimView *dimView = [[DimView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:dimView];
    
    UIView *aView  =[[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    aView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    [self.view addSubview:aView];
    


    
}

- (void)doData:(id)data
{
    NSLog(@"%@",data);
}

- (void)theData:(id)data
{
    UIAlertView *alertDate = [[UIAlertView alloc]initWithTitle:@"下载的数据" message:[self replaceUnicode:[NSString stringWithFormat:@"%@",data]] delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertDate show];
    [alertDate release];
}

- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

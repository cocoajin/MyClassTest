//
//  ViewController.m
//  NSURLSectionTask
//
//  Created by cocoajin on 14-5-5.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import "ViewController.h"

#import "NSURLSession+KKAddition.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //NSURLSession BASE
    
//    NSURL *url = [NSURL URLWithString:@"http://httpbin.org/get"];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
//        
//    }];
//    
//    //任务创建后，不会立即执行，调用resume 立即执行;
//    [dataTask resume];
    
    
//    NSURL *url = [NSURL URLWithString:@"http://dl.360safe.com/360zip_setup_3.1.0.2061.exe"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionDownloadTask *downTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        
//        //文件下载会被先写入到一个 临时路径 location,我们需要将下载的文件移动到我们需要地方保存
//        NSURL *savePath = [NSURL fileURLWithPath:@"/Users/user/Desktop/360zip.exe"];
//        [[NSFileManager defaultManager] moveItemAtURL:location toURL:savePath error:nil];
//        
//    }];
//    
//    [downTask resume];
    
    /**
     request.HTTPMethod = @"POST";
     NSString *items = @"method=user.item.get&appKey=43db911a75b88c11&format=json&user=ttr2008&pageNo=1&pageSize=10";
     request.HTTPBody = [items dataUsingEncoding:NSUTF8StringEncoding];
     
     */
    
    //NSURLSession+KKAddition 分类 
    //GET
//    [NSURLSession GET:@"http://httpbin.org/get" pararms:@{@"name": @"jkk",@"age":@"24"} completed:^(NSData *data) {
//        
//        //NSLog(@"%@",data);
//        [NSURLSession printDataToString:data];
//        
//    } failed:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
    
    //POST
//    [NSURLSession POST:@"http://httpbin.org/post" pararms:@{@"key": @"value",@"name":@"jkk"} completed:^(NSData *data) {
//        
//        [NSURLSession printDataToString:data];
//        
//    } failed:^(NSError *error) {
//        
//        NSLog(@"%@",error);
//        
//    }];
    
    
    
    //文件下载
    NSString *file = @"http://dl.360safe.com/360zip_setup_3.1.0.2061.exe";
    NSString *savePath = @"/Users/user/Desktop/";
    [NSURLSession Download:file saveTo:savePath progress:^(CGFloat progress) {
        
        NSLog(@"---- %f ",progress);
        
    } completed:^() {
        
        NSLog(@"下载完成");
        
    } failed:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
    
    //json
    [NSURLSession GET:@"http://httpbin.org/post" pararms:nil completed:^(NSData *data) {
        
        NSLog(@"%@",[NSURLSession parseJSONData:data]);
        
    } failed:^(NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

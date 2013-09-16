//
//  KKHttpRequest.h
//  MyClassTest
//
//  Created by cocoa on 13-9-3.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKHttpRequest : NSObject


typedef void (^KKHttpRequestCompletionBlock)(id data);

//block回调
+ (void)requestWithURL:(NSString *)strUrl completeBlock:(KKHttpRequestCompletionBlock)completeBlock;

//target 回调
+ (void)requestWithURL:(NSString *)strUrl completeTarget:(id)target callBack:(SEL)action;


@end

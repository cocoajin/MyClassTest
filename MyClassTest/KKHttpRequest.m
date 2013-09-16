//
//  KKHttpRequest.m
//  MyClassTest
//
//  Created by cocoa on 13-9-3.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "KKHttpRequest.h"

@interface KKHttpRequest ()

@property(nonatomic,copy)KKHttpRequestCompletionBlock completionBlock;
@property(nonatomic,retain)id theTarget;
@property(nonatomic,assign)SEL theAction;

@end

@implementation KKHttpRequest

{
    NSMutableData *downloadData;
    
}

@synthesize completionBlock,theTarget,theAction;

- (id)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSURLConnection *connection= [NSURLConnection connectionWithRequest:request delegate:self];
        [connection retain];
        [connection release];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        request = nil;
        connection  =nil;
    }
    return self;
}


+ (void)requestWithURL:(NSString *)strUrl completeBlock:(KKHttpRequestCompletionBlock)completeBlock
{
    KKHttpRequest *theRequest = [[KKHttpRequest alloc]initWithUrl:strUrl];
    theRequest.completionBlock = completeBlock;
    Block_release(completeBlock);
    completeBlock = nil;
    [theRequest autorelease];
}

+ (void)requestWithURL:(NSString *)strUrl completeTarget:(id)target callBack:(SEL)action
{
    KKHttpRequest *theRequest = [[KKHttpRequest alloc]initWithUrl:strUrl];
    theRequest.theTarget = target;
    theRequest.theAction = action;
    [theRequest autorelease];
}



#pragma mark ------------  delegate  --------------------------

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    downloadData = [[NSMutableData alloc]initWithCapacity:10];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [downloadData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    id theData = [NSJSONSerialization JSONObjectWithData:downloadData options:0 error:nil];
    if (completionBlock!=nil) {
        completionBlock(theData);
    }
    else if (theTarget!=nil)
    {
        [theTarget performSelector:theAction withObject:theData];
    }
    theData = nil;
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"line:(%d) class %s",__LINE__,__func__);
    NSLog(@"网络加载出错");
}

#pragma mark ------------  lifeCyle  --------------------------

- (void)dealloc
{
    [downloadData release];
    downloadData = NULL;
    Block_release(completionBlock);
    completionBlock = NULL;
    theTarget = nil;
    theAction = nil;
    [super dealloc];
    //NSLog(@"line:(%d) class %s",__LINE__,__func__);

}


@end

//
//  NSURLSession+KKAddition.m
//  NSURLSectionTask
//
//  Created by cocoajin on 14-5-5.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import "NSURLSession+KKAddition.h"


#pragma mark private file Downloader

@interface DownloadFileOP : NSObject<NSURLSessionDelegate>

@property (nonatomic,copy)KKProgressBlock progress;
@property (nonatomic,copy)KKFileBlock complete;
@property (nonatomic,copy)KKFailedBlock failed;
@property (nonatomic,strong)NSString *filePath;
@property (nonatomic,strong)NSString *savePath;

@end

@implementation DownloadFileOP

- (NSOperation *)Download:(NSString *)file
                   saveTo:(NSString *)path
                 progress:(KKProgressBlock )progressBlock
                completed:(KKFileBlock )compleBlock
                   failed:(KKFailedBlock )failBlock
{
    self.progress = progressBlock;
    self.complete = compleBlock;
    self.failed = failBlock;
    self.filePath = file;
    self.savePath = path;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    
    NSBlockOperation *downFileOP = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:file]];
        
        [downloadTask resume];
        
    }];
    
    [downFileOP start];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    return downFileOP;
    
}

//下载文件代理

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    NSString *savePath = [NSString stringWithFormat:@"%@%@",self.savePath,[self.filePath lastPathComponent]];
    NSError *moveError;
    if ([[NSFileManager defaultManager] fileExistsAtPath:savePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:savePath error:nil];
    }
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:savePath] error:&moveError];
    if (moveError) {
        NSLog(@" ** 文件下载完成，文件移动失败！%@",moveError);
    }
    else
    {
        self.complete();
    }
    
}

//下载文件进度条
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    self.progress(progress);
}

//错误
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.failed(error);
}


@end




#pragma public Category

@implementation NSURLSession (KKAddition)

+ (NSOperation *)GET:(NSString *)path
             pararms:(NSDictionary *)parms
           completed:(KKCompletedBlock )compleBlock
              failed:(KKFailedBlock )failBlock
{
    
    NSString *urlPath = path;
    if ([parms count] > 0) {
         urlPath = [NSString stringWithFormat:@"%@?%@",path,[self getParmsURL:parms]];
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlPath]];
    request.HTTPMethod = @"GET";
    
    NSBlockOperation *getOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSLog(@"---> GET: %@",urlPath);
            
            if (error) {
                failBlock(error);
                return ;
            }
            else
            {
                compleBlock(data);
            }
            
        }];
        
        [dataTask resume];
        
    }];
    
    [getOperation start];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    
    return getOperation;
}


+ (NSOperation *)POST:(NSString *)path
              pararms:(NSDictionary *)parms
            completed:(KKCompletedBlock )compleBlock
               failed:(KKFailedBlock )failBlock
{
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
    request.HTTPMethod = @"POST";
    NSString *body = [self getParmsURL:parms];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    

    NSBlockOperation *postOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSLog(@"---> POST: %@ 参数: %@",path,parms);
            
            if (error) {
                failBlock(error);
                return ;
            }
            else
            {
                compleBlock(data);
            }
            
        }];
        
        [postDataTask resume];
        
    }];
    
    [postOperation start];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
    return postOperation;
}


+ (NSOperation *)Download:(NSString *)file
                   saveTo:(NSString *)path
                 progress:(KKProgressBlock )progressBlock
                completed:(KKFileBlock )compleBlock
                   failed:(KKFailedBlock )failBlock
{
    return [[DownloadFileOP new] Download:file saveTo:path progress:progressBlock completed:compleBlock failed:failBlock];
}



+ (void)printDataToString:(NSData *)data
{
    NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
}

//解析json
+ (id)parseJSONData:(NSData *)data
{
    
    NSError *jsonError = nil;

    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    if (jsonError) {
        NSLog(@"** 解析json数据错误 ：\n%@",jsonError);
        NSLog(@"** 原字符串数据 **");
        [self printDataToString:data];
        return @{@"error": @"解析json数据错误"};
    }
    
    return json;
}

#pragma mark private

+ (NSString *)getParmsURL:(NSDictionary *)parms
{
    NSMutableString *parmsURL = [NSMutableString new];
    if ([parms count]>0) {
        [parms enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (!obj) return ;
            [parmsURL appendFormat:@"%@=%@&",key,obj];
        }];
        [parmsURL deleteCharactersInRange:NSMakeRange(parmsURL.length-1, 1)];
        
    }
    
    return [parmsURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}




@end


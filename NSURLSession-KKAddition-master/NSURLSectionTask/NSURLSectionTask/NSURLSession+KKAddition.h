//
//  NSURLSession+KKAddition.h
//  NSURLSectionTask
//
//  Created by cocoajin on 14-5-5.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^KKCompletedBlock)(NSData *data);
typedef void (^KKFailedBlock)(NSError *error);
typedef void (^KKProgressBlock)(CGFloat progress);
typedef void (^KKFileBlock)();



@interface NSURLSession (KKAddition)

//GET 请求
+ (NSOperation *)GET:(NSString *)path
             pararms:(NSDictionary *)parms
           completed:(KKCompletedBlock )compleBlock
              failed:(KKFailedBlock )failBlock;

//POST 请求
+ (NSOperation *)POST:(NSString *)path
             pararms:(NSDictionary *)parms
           completed:(KKCompletedBlock )compleBlock
              failed:(KKFailedBlock )failBlock;

//下载文件
//Path 不需要添加文件名：如 ~/Desktop/
+ (NSOperation *)Download:(NSString *)file
                   saveTo:(NSString *)path
                 progress:(KKProgressBlock )progressBlock
                completed:(KKFileBlock )compleBlock
                   failed:(KKFailedBlock )failBlock;

//打印字符
+ (void)printDataToString:(NSData *)data;

//解析json
+ (id)parseJSONData:(NSData *)data;


@end

//
//  KKLogView.h
//  KKLogView
//
//  Created by cocoajin on 14-4-19.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KKLogView : UIView

/**
 *  日志显示TextView
 */
@property (nonatomic,strong,readonly)UITextView *theTextView;

/**
 *  日志信息
 */
@property (nonatomic,strong,readonly)NSMutableString *logMessage;

/**
 *  设置logView的高度 默认的高度是 屏幕显示的高度
 */
@property (nonatomic,assign)CGFloat height;

/**
 *  加载logView到指定视图
 *
 *  @param aController 指定视图控制器
 *
 *  @return 返回logView对象
 */
- (id)initWithController:(UIViewController *)aController;

/**
 *  添加一条打印日志
 *
 *  @param logStr log日志
 */
- (void)printLog:(NSString *)logStr;

/**
 *  日志写入到文件
 *
 *  @param filePath 日志写入路径加文件名：比如：//Users/user,不加最后一个 / 文件名也不加，默认是 日期加.txt 例如：2014_04_19-14_25_49.txt
 */
- (void)writeLogToFile:(NSString *)filePath;

/**
 *  删除logView;
 */
- (void)removeLogView;

@end

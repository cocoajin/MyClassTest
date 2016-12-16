//
//  KKLogView.m
//  KKLogView
//
//  Created by cocoajin on 14-4-19.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import "KKLogView.h"

@interface KKLogView ()
{
    NSInteger lineNums;
}

@end

@implementation KKLogView
@synthesize theTextView = _theTextView,logMessage = _logMessage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        lineNums = 0;
    }
    return self;
}

- (UITextView *)theTextView
{
    if (!_theTextView) {
        _theTextView = [[UITextView alloc]initWithFrame:self.bounds];
        _theTextView.editable = NO;
        _theTextView.backgroundColor = [UIColor darkGrayColor];
        _theTextView.textColor = [UIColor lightTextColor];
        _theTextView.font = [UIFont boldSystemFontOfSize:15];
        
    }
    return _theTextView;
}

- (NSMutableString *)logMessage
{
    if (!_logMessage) {
        _logMessage = [[NSMutableString alloc]initWithCapacity:2];
    }
    return _logMessage;
}

- (void)setHeight:(CGFloat)height
{
    CGRect theFrame = self.frame;
    self.frame = CGRectMake(0, theFrame.origin.y, theFrame.size.width, height);
    _theTextView.frame = self.bounds;
    _height = height;
}

- (id)initWithController:(UIViewController *)aController
{
    CGRect frame = CGRectZero;
    if ([self hasNavagation:aController]) {
        frame = CGRectMake(0, 20, aController.view.bounds.size.width, aController.view.bounds.size.height-20-44);
    }
    else
    {
        frame = CGRectMake(0, 20, aController.view.bounds.size.width, aController.view.bounds.size.height-20);
    }
    self = [self initWithFrame:frame];
    [self addSubview:self.theTextView];
    _logMessage = [self logMessage];
    [aController.view addSubview:self];
    return self;
}

- (void)printLog:(NSString *)logStr
{
    lineNums +=1 ;
    [_logMessage appendFormat:@"LOG(%d)：%@\n",lineNums,logStr];
    [self setLogMessageToTestView];
}

- (void)writeLogToFile:(NSString *)filePath
{
    NSError *writeError = nil;
    [_logMessage insertString:[self getNowDateString] atIndex:0];
    
    filePath = [NSString stringWithFormat:@"%@/%@",filePath,[self witeFileName]];
    
    BOOL resu = [_logMessage writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&writeError];
    if (writeError&&(resu==NO)) {
        NSLog(@"--日志写入到文件错误：%@",writeError);
    }
    return;
}

- (NSString *)getNowDateString
{
    NSString *theDateString = nil;
    NSDateFormatter *forMatter = [[NSDateFormatter alloc]init];
    [forMatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    theDateString = [NSString stringWithFormat:@"日志文件：%@\n\n",[forMatter stringFromDate:[NSDate date]]];
    return theDateString;
}

- (NSString *)witeFileName
{
    NSDateFormatter *forMatter = [[NSDateFormatter alloc]init];
    [forMatter setDateFormat:@"yyyy_MM_dd-HH_mm_ss"];
    NSString *theName = [forMatter stringFromDate:[NSDate date]];
    
    return [NSString stringWithFormat:@"%@.txt",theName];
}

- (void)removeLogView
{
    [self removeFromSuperview];
}

- (void)setLogMessageToTestView
{
    _theTextView.text = _logMessage;
    [_theTextView scrollRangeToVisible:NSMakeRange(_logMessage.length, 0)];
}

- (BOOL)hasNavagation:(UIViewController *)controller
{
    return controller.navigationController==nil?NO:YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

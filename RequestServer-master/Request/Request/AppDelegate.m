//
//  AppDelegate.m
//  Request
//
//  Created by cocoajin on 14-4-23.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import "AppDelegate.h"



@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    //NSDate *nowsData = [NSDate date];
    
    
    pararmsDic = [[NSMutableDictionary alloc]initWithCapacity:2];
    NSSize contentSize = [urlParms contentSize];
    urlTextView = [[NSTextView alloc]initWithFrame:NSMakeRect(0, 0, contentSize.width, contentSize.width)];
    [urlParms setDocumentView:urlTextView];
    
    contentSize = [results contentSize];
    resultsTextView = [[NSTextView alloc]initWithFrame:NSMakeRect(0, 0, contentSize.width, contentSize.width)];
    [results setDocumentView:resultsTextView];
    
    [path setStringValue:@"http://httpbin.org/"];
    [api setStringValue:@"ip"];
    
    
    //set icon
    //http://stackoverflow.com/questions/6337787/how-can-i-set-the-icon-for-a-mac-application-in-xcode
    //http://www.img2icnsapp.com/


    



    
}

- (IBAction)addPararms:(id)sender
{
    if ([parmKey stringValue].length <=0) {
        [self alertWithMessage:@"添加参数的 key 不能为空"];
    }
    else if ([parmValue stringValue].length <=0)
    {
        [self alertWithMessage:@"添加参数的 value 不能为空"];
    }
    
    else
    {
        NSArray *keyArray = [pararmsDic allKeys];
        if (![keyArray containsObject:parmKey.stringValue]) {
            [pararmsDic setValue:parmValue.stringValue forKey:parmKey.stringValue];
        }
        else
        {
            //NSLog(@"has add");
        }
        
    }
    
    
}

- (IBAction)requestTheServer:(id)sender
{
    NSSegmentedControl *segment = (NSSegmentedControl *)sender;
    
    if ([self checkTheFiledIsNil]) {
        
        if (httpRequest) {
            [httpRequest cancel];
            [progress stopAnimation:nil];

        }
        
        [progress startAnimation:nil];
        [resultsTextView setString:@"loading ..."];
        
        if (segment.selectedSegment==0) {
            [self getServerApiInfo];
        }
        else if (segment.selectedSegment==1)
        {
            [self postServerApiInfo];
        }
        
    }
}



- (void)getServerApiInfo
{
    [self showURL_Pararms];
    
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",path.stringValue,api.stringValue];
    
    
    
    httpRequest = [SVHTTPRequest GET:urlString parameters:[NSDictionary dictionary] completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [progress stopAnimation:nil];

        
        if (error) {
            NSLog(@"%@",error);
            
            [self showResults:[error localizedDescription]];
        }
        else
        {
            //NSLog(@" ------- %@",response);
            NSLog(@"%@",urlResponse.MIMEType);
            if ([urlResponse.MIMEType isEqualTo:@"text/html"]) {
                NSString *theHtmlStr = [[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
                [self showResults:theHtmlStr];

            }
            else
            {
                [self showResults:response];

            }

        }
        
    }];
    
}

- (void)postServerApiInfo
{
    [self showURL_Pararms];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",path.stringValue,api.stringValue];
    httpRequest = [SVHTTPRequest POST:urlString parameters:pararmsDic completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [progress stopAnimation:nil];
        
        if (error) {
            NSLog(@"%@",error);

            [self showResults:[error localizedDescription]];
        }
        else
        {
            NSLog(@"%@",urlResponse.MIMEType);
            if ([urlResponse.MIMEType isEqualTo:@"text/html"]) {
                NSString *theHtmlStr = [[NSString alloc]initWithData:response encoding:NSUTF8StringEncoding];
                [self showResults:theHtmlStr];
                
            }
            else
            {
                [self showResults:response];
                
            }
        }
        
    }];
}

- (void)showResults:(id)result
{
    
    [resultsTextView setString:[NSString stringWithFormat:@"%@",result]];

}


- (void)showURL_Pararms
{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",path.stringValue,api.stringValue];
    NSString *pararmsStr = [NSString stringWithFormat:@"\nparms: %@",pararmsDic];
    
    [urlTextView setString:[NSString stringWithFormat:@"%@%@",urlString,pararmsStr]];
}

- (BOOL)checkTheFiledIsNil
{
    BOOL isRun = NO;
    
    if ([path stringValue].length <=0) {
        [self alertWithMessage:@"root url path 不能为空！"];
        isRun = NO;
    }
    else if ([api stringValue].length <=0)
    {
        [self alertWithMessage:@"api 不能为空！"];
        isRun = NO;
    }
    
    else
    {
        isRun = YES;
    }
    
    return isRun;
    
}

- (void)alertWithMessage:(NSString *)message
{
    NSAlert *alertME = [NSAlert alertWithMessageText:message defaultButton:@"确定" alternateButton:nil otherButton:nil informativeTextWithFormat:@"请输入："];
    
    [[NSRunningApplication currentApplication] activateWithOptions:NSApplicationActivateIgnoringOtherApps];
    [alertME runModal];
    
}

@end

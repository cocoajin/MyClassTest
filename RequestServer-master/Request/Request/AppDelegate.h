//
//  AppDelegate.h
//  Request
//
//  Created by cocoajin on 14-4-23.
//  Copyright (c) 2014年 dev.keke@gmail.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SVHTTPRequest.h"


@interface AppDelegate : NSObject <NSApplicationDelegate>

{
    IBOutlet NSTextField *path;
    IBOutlet NSTextField *api;
    IBOutlet NSSegmentedControl *requestWidhMethod;
    
    IBOutlet NSTextField *parmKey;
    IBOutlet NSTextField *parmValue;
    IBOutlet NSButton *parmAdd;
    
    IBOutlet NSScrollView *urlParms;
    IBOutlet NSScrollView *results;
    NSTextView *urlTextView;
    NSTextView *resultsTextView;
    
    NSMutableDictionary *pararmsDic;
    
    SVHTTPRequest *httpRequest;
    
    IBOutlet NSProgressIndicator *progress;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)addPararms:(id)sender;

- (IBAction)requestTheServer:(id)sender;

@end

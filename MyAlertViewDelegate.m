//
//  MyAlertViewDelegate.m
//  TELUS Spark
//
//  Created by Brett Nishikawa on 2014-04-30.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "MyAlertViewDelegate.h"

@implementation MyAlertViewDelegate
@synthesize callback;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    callback(buttonIndex);
}

+ (void)showAlertView:(UIAlertView *)alertView
         withCallback:(AlertViewCompletionBlock)callback {
    __block MyAlertViewDelegate *delegate = [[MyAlertViewDelegate alloc] init];
    alertView.delegate = delegate;
    delegate.callback = ^(NSInteger buttonIndex) {
        callback(buttonIndex);
        alertView.delegate = nil;
        delegate = nil;
    };
    [alertView show];
}

@end

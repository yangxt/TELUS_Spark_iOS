//
//  MyAlertViewDelegate.h
//  TELUS Spark
//
//  Created by Brett Nishikawa on 2014-04-30.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAlertViewDelegate : NSObject<UIAlertViewDelegate>

typedef void (^AlertViewCompletionBlock)(NSInteger buttonIndex);
@property (strong,nonatomic) AlertViewCompletionBlock callback;

+ (void)showAlertView:(UIAlertView *)alertView withCallback:(AlertViewCompletionBlock)callback;

@end

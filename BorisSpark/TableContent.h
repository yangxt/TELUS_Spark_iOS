//
//  TableContent.h
//  BorisSpark
//
//  Created by Gellert on 2014-04-08.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableContent : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (assign, nonatomic) NSInteger index;
-(void) initView;

@end

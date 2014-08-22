//
//  ExhibitTableViewController.h
//  BorisSpark
//
//  Created by ASE Lab on 3/22/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExhibitTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property NSString* galleryName;
@property (assign, nonatomic) NSInteger index;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

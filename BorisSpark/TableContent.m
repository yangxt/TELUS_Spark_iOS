//
//  TableContent.m
//  BorisSpark
//
//  Created by Gellert on 2014-04-08.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "TableContent.h"
#import "Model.h"
#import "Exhibit.h"
#import "Gallery.h"

@interface TableContent ()

@end

@implementation TableContent
{
    NSMutableArray * exhibits;
    Model *sharedModel;
    NSString *galleryName;
}



- (void)initView {
    galleryName = @"Earth and Sky";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //exhibits = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    
    
    exhibits = [[NSMutableArray alloc] init];
    sharedModel = [Model sharedModel];
    for (int i = 0; i < [[sharedModel galleryList] count]; i++)
    {
        if ([[[[sharedModel galleryList] objectAtIndex:i] name] isEqualToString:galleryName])
        {
            for (id object in [[[sharedModel galleryList] objectAtIndex:i] exhibitList])
            {
                [exhibits addObject:object];
            }
        }
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [exhibits count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[exhibits objectAtIndex:indexPath.row] name];
    return cell;
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end


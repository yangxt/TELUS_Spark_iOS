//
//  ExhibitTableViewController.m
//  BorisSpark
//
//  Created by ASE Lab on 3/22/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "ExhibitTableViewController.h"
#import "GlassViewController.h"
#import "Model.h"
#import "Exhibit.h"
#import "Gallery.h"

@interface ExhibitTableViewController ()

@end

@implementation ExhibitTableViewController
{
    NSMutableArray *exhibits;
    Model *sharedModel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _tableView.opaque = NO;

    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
	// Do any additional setup after loading the view.
    exhibits = [[NSMutableArray alloc] init];
    sharedModel = [Model sharedModel];
    for (int i = 0; i < [[sharedModel galleryList] count]; i++)
    {
        if ([[[[sharedModel galleryList] objectAtIndex:i] name] isEqualToString:_galleryName])
        {
            for (id object in [[[sharedModel galleryList] objectAtIndex:i] exhibitList])
            {
                [exhibits addObject:object];
            }
        }
    }
    self.view.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorColor:[UIColor clearColor]];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [exhibits count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];

    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[[exhibits objectAtIndex:indexPath.row] background]];
    cell.backgroundView.clipsToBounds = YES;
    cell.backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,26,280,30)];
    label.textColor = [UIColor whiteColor];
    label.text = [[exhibits objectAtIndex:indexPath.row] name];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22];
    label.shadowColor = [UIColor blackColor];
    label.shadowOffset = CGSizeMake(1, -1);
    [cell.contentView addSubview:label];
    
    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:1
                                                      green:1
                                                       blue:1
                                                      alpha:0.7];
    cell.selectedBackgroundView =  customColorView;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GlassViewController *view = [[GlassViewController alloc] init];
    view.selectedGallery = _galleryName;
    view.selectedExhibit = [[exhibits objectAtIndex:indexPath.row] name];
    [view forceClear];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:view animated:YES];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.backgroundColor = [UIColor redColor]; //must do here in willDisplayCell
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

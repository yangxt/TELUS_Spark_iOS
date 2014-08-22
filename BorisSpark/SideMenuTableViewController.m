//
//  SideMenuTableViewController.m
//  BorisSpark
//
//  Created by Brett Nishikawa on 2014-04-03.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "SideMenuTableViewController.h"
#import "Model.h"
#import "Gallery.h"
#import "Exhibit.h"
#import "SWRevealViewController.h"
#import "CustomColoredAccessory.h"
#import "GlassViewController.h"
#import "AppDelegate.h"

@interface SideMenuTableViewController ()
{
    NSMutableSet *collapsedSections_;
    Model *sharedModel;
}

@end

@implementation SideMenuTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    sharedModel = [Model sharedModel];
    collapsedSections_ = [NSMutableSet new];
    self.view.backgroundColor = [UIColor darkGrayColor];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated
{
    NSLog(@"gallery = %@\nexhibit = %@", _selectedGallery, _selectedExhibit);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.

    return [[sharedModel galleryList] count];
    //return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int result = -1;
    
    result = [collapsedSections_ containsObject:@(section)] ? 0 : [[[[sharedModel galleryList] objectAtIndex:section] exhibitList] count];
    
    return result;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Gallery Name = %@", [[[sharedModel galleryList] objectAtIndex:indexPath.section] name]);
    NSLog(@"Exhibit Name = %@", [[[[[sharedModel galleryList] objectAtIndex:indexPath.section] exhibitList] objectAtIndex:indexPath.row] name]);
    NSString *gal = [[[sharedModel galleryList] objectAtIndex:indexPath.section] name];
    NSString *exh = [[[[[sharedModel galleryList] objectAtIndex:indexPath.section] exhibitList] objectAtIndex:indexPath.row] name];
    NSLog(@"double check\nGallery Name = %@", gal);
    NSLog(@"double check\nExhibit Name = %@", exh);

    
//    [(GlassViewController*)([self.revealViewController.frontViewController.navigationController.viewControllers lastObject]) setSelectedGallery:gal];
//    [(GlassViewController*)([self.revealViewController.frontViewController.navigationController.viewControllers lastObject]) setSelectedExhibit:exh];
//    [(GlassViewController*)([self.revealViewController.frontViewController.navigationController.viewControllers lastObject]) forceRedraw];
    //[[(GlassViewController*)([self.revealViewController.frontViewController.navigationController.viewControllers lastObject]) view] setNeedsDisplay];
//    [(GlassViewController*)self.revealViewController.frontViewController setSelectedGallery:[[[sharedModel galleryList] objectAtIndex:indexPath.section] name]];
//    [(GlassViewController*)self.revealViewController.frontViewController setSelectedExhibit:[[[[[sharedModel galleryList] objectAtIndex:indexPath.section] exhibitList] objectAtIndex:indexPath.row] name]];
//    [[(GlassViewController*)self.revealViewController.frontViewController view] setNeedsDisplay];
    
    
    GlassViewController *view = [[GlassViewController alloc] init];
    view.selectedGallery = gal;
    view.selectedExhibit = exh;
    
    [[sharedModel controller] popViewControllerAnimated:NO];
    [[sharedModel controller] pushViewController:view animated:YES];
    [self.revealViewController rightRevealToggle:Nil];
//    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [del.navigationController pushViewController:view animated:YES];
    //UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:view];
    //[self.revealViewController pushFrontViewController:nc animated:YES];
//    [self.revealViewController.frontViewController.navigationController pushViewController:view animated:YES];
    //NSLog(@"count = %i", [[[(HomePageViewController*)(self.revealViewController.frontViewController) navigationController] viewControllers] count]);
}

-(NSArray*) indexPathsForSection:(int)section withNumberOfRows:(int)numberOfRows
{
    NSMutableArray* indexPaths = [NSMutableArray new];
    for (int i = 0; i < numberOfRows; i++) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:section];
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.origin.x+90, cell.frame.origin.y+5, cell.frame.size.width-90, cell.frame.size.height-5)];
       
    label.text = [[[[[sharedModel galleryList] objectAtIndex:indexPath.section] exhibitList] objectAtIndex:indexPath.row] name];
    
    label.textAlignment = NSTextAlignmentLeft;
    
    label.numberOfLines = 0;
    [label sizeToFit];
    
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    
    if ([label.text caseInsensitiveCompare:_selectedExhibit] == NSOrderedSame)
    {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [cell setTintColor:[UIColor greenColor]];
    }
    else
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    
    [[cell.contentView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [label setTextColor:[UIColor whiteColor]];
    
    [cell setBackgroundColor:[UIColor grayColor]];
    

    
    [cell.contentView addSubview:label];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(90, 0, tableView.frame.size.width-90, 40)];
    
    label.text = [[[sharedModel galleryList] objectAtIndex:section] name];
    
    label.textAlignment = NSTextAlignmentLeft;
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
    [label setTextColor:[UIColor whiteColor]];
    [sectionHeader addSubview:label];
    [sectionHeader setBackgroundColor:[UIColor darkGrayColor]];
	
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button addTarget:self
//               action:@selector(aMethod:)
//     forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"Show View" forState:UIControlStateNormal];
//    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
//    [view addSubview:button];
    
    UIButton * collapseButton = [[UIButton alloc] initWithFrame:CGRectMake(68, 12, 292, 40)];
    [collapseButton addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    collapseButton.tag = section;

    
    
    CustomColoredAccessory * cca = [CustomColoredAccessory accessoryWithColor:[UIColor whiteColor] type:CustomColoredAccessoryTypeDown];
    //[cca addTarget:self action:@selector(sectionButtonTouchUpInside0:) forControlEvents:UIControlEventTouchUpInside];

    if ([[[[sharedModel galleryList] objectAtIndex:section] exhibitList] count] > 0)
        [cca setType:CustomColoredAccessoryTypeDown];
    else
        [cca setType:CustomColoredAccessoryTypeRight];
    
    [cca setUserInteractionEnabled:NO];
    
    [collapseButton addSubview:cca];
    
    [sectionHeader addSubview:collapseButton];
    

    
//cell.accessoryView =  [DTCustomColoredAccessory accessoryWithColor:[UIColor grayColor] type:DTCustomColoredAccessoryTypeUp];
    
//    UIButton* result = [[UIButton alloc] initWithFrame:CGRectMake(80, 5, 10, 10)];
//    [result addTarget:self action:@selector(sectionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
//    result.backgroundColor = [UIColor blueColor];
//    result.tag = section;
//    [sectionHeader addSubview:result];
    
    return sectionHeader;
}

-(void)sectionButtonTouchUpInside:(UIButton*)sender {
    
    if ([(CustomColoredAccessory*)[sender.subviews objectAtIndex:0] type] == CustomColoredAccessoryTypeRight)
        [(CustomColoredAccessory*)[sender.subviews objectAtIndex:0] setType:CustomColoredAccessoryTypeDown];
    else
        [(CustomColoredAccessory*)[sender.subviews objectAtIndex:0] setType:CustomColoredAccessoryTypeRight];
    
    [(CustomColoredAccessory*)[sender.subviews objectAtIndex:0] setNeedsDisplay];
    
    [self.tableView beginUpdates];
    int section = [(UIButton*)sender tag];
    bool shouldCollapse = ![collapsedSections_ containsObject:@(section)];
    if (shouldCollapse) {
        int numOfRows = [self.tableView numberOfRowsInSection:section];
        NSArray* indexPaths = [self indexPathsForSection:section withNumberOfRows:numOfRows];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [collapsedSections_ addObject:@(section)];
    }
    else
    {
        int numOfRows = [[[[sharedModel galleryList] objectAtIndex:section] exhibitList] count];
        NSArray * indexPaths = [self indexPathsForSection:section withNumberOfRows:numOfRows];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
        [collapsedSections_ removeObject:@(section)];
    }
    [self.tableView endUpdates];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

@end

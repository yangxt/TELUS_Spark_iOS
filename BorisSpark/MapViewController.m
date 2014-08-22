//
//  mapViewController.m
//  TELUS Spark
//
//  Created by Brett Nishikawa on 2014-04-30.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "MapViewController.h"
#import "GlassViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GlassViewController *controller = (GlassViewController *)segue.destinationViewController;
    if ([[segue identifier] isEqualToString:@"earth"])
        [controller setSelectedGallery:@"Earth and Sky"];
    else if ([[segue identifier] isEqualToString:@"energy"])
        [controller setSelectedGallery:@"Energy and Innovation"];
    else if ([[segue identifier] isEqualToString:@"feature"])
        [controller setSelectedGallery:@"Feature"];
    else if ([[segue identifier] isEqualToString:@"creative"])
        [controller setSelectedGallery:@"Creative Kids Museum"];
    else if ([[segue identifier] isEqualToString:@"open"])
        [controller setSelectedGallery:@"Open Studio"];
    else if ([[segue identifier] isEqualToString:@"human"])
        [controller setSelectedGallery:@"Being Human"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

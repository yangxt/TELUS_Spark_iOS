//
//  HomeViewController.m
//  BorisSpark
//
//  Created by Gellert on 2014-04-08.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "HomeViewController.h"
#import "ExhibitTableViewController.h"
#import "Model.h"
#import "MapViewController.h"
#import "PhotoCollageViewController.h"

@interface HomeViewController ()


@end

@implementation HomeViewController

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
    [self setTitle:@"Home"];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    Model * sharedModel = [Model sharedModel];
    [sharedModel setController:self.navigationController];
    [_galleryLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.hidden=NO;
    _container1.backgroundColor = [UIColor clearColor];

//    [_generateCollageButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
//    //[_generateCollageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_generateCollageButton setTitle:@"Generate Collage" forState:UIControlStateNormal];
//    [_generateCollageButton setTitle:@"Generate Collage" forState:UIControlStateSelected];
//    [_generateCollageButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:22]];
//    [_generateCollageButton.layer setCornerRadius:3];
//    [_generateCollageButton setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
    
    UIBarButtonItem *generateCollage = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"collageIcon"] style:UIBarButtonItemStyleBordered target:self action:@selector(createCollage:)];
    
    
    UIBarButtonItem *viewMap = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mapIcon"] style:UIBarButtonItemStyleBordered target:self action:@selector(segueToMap:)];
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];


    _origToolbar = [NSArray arrayWithObjects:spacer, generateCollage, spacer, viewMap, spacer, nil];
    [_toolbar setItems:_origToolbar];
    [_toolbar setTintColor:[UIColor whiteColor]];
	// Do any additional setup after loading the view.
}

-(void)createCollage:(id)sender
{
    [self performSegueWithIdentifier:@"collage" sender:self];

}

-(void)segueToMap:(id)sender
{
    [self performSegueWithIdentifier:@"map" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewGalleriesForExhibit:(id)sender {
    
    ExhibitTableViewController *tView = [[ExhibitTableViewController alloc] init];
    tView.galleryName = @"Earth and Sky";
    [self.navigationController pushViewController:tView animated:YES];
}

- (IBAction)tester:(id)sender {
}
@end

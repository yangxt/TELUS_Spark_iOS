//
//  ViewController.m
//  BTGlassScrollViewExample
//
//  Created by Byte on 10/18/13.
//  Copyright (c) 2013 Byte. All rights reserved.
//

#import "GlassViewController.h"
#import "Model.h"
#import "Gallery.h"
#import "Exhibit.h"
#import "SWRevealViewController.h"
#import "SideMenuTableViewController.h"
#import "UIViewController+BackButtonHandler.h"
#import "UIImage+ImageEffects.h"


@interface GlassViewController ()

@end

@implementation GlassViewController
{
    UIScrollView *_viewScroll;
    int _page;
    int _pageIndex;
    Model *sharedModel;
    NSMutableArray *_glassScrollArray;
    int galleryIndex;
    int counter;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _page = 0;
        _pageIndex = 0;
        counter = 0;
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:_selectedGallery];
    [(SideMenuTableViewController*)(self.revealViewController.rightViewController) setSelectedExhibit:_selectedExhibit];
    [(SideMenuTableViewController*)(self.revealViewController.rightViewController) setSelectedGallery:_selectedGallery];
    [[(SideMenuTableViewController*)(self.revealViewController.rightViewController) tableView] reloadData];
    
    
    sharedModel = [Model sharedModel];
    for (int i = 0; i < [[sharedModel galleryList] count]; i++)
    {
        if ([[[[sharedModel galleryList] objectAtIndex:i] name] caseInsensitiveCompare:_selectedGallery] == NSOrderedSame)
            galleryIndex = i;
    }
    
    
    for (int i = 0; i < [[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] count]; i++)
    {
        if ([[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:i] name] caseInsensitiveCompare:_selectedExhibit] == NSOrderedSame)
            _pageIndex = i;
    }
    
    
    
    _glassScrollArray = [[NSMutableArray alloc] init];
    
    
    //showing white status
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //preventing weird inset
    [self setAutomaticallyAdjustsScrollViewInsets: NO];
    
    //navigation bar work
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(1, 1)];
    [shadow setShadowColor:[UIColor blackColor]];
    [shadow setShadowBlurRadius:1];
    
    
    
    
    //background
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat blackSideBarWidth = 2;
    
    //    _viewScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
    //    [_viewScroller setPagingEnabled:YES];
    //    [_viewScroller setDelegate:self];
    //    [_viewScroller setShowsHorizontalScrollIndicator:NO];
    //    [self.view addSubview:_viewScroller];
    
    
    _viewScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
    [_viewScroll setPagingEnabled:YES];
    [_viewScroll setDelegate:self];
    [_viewScroll setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:_viewScroll];
    
    for (int i = 0; i < [[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] count]; i++)
    {
        BTGlassScrollView *glassView = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
                                                                BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:i] background]
                                                                   blurredImage:nil
                                                         viewDistanceFromBottom:120
                                                                 foregroundView:[self customView]];
        
        
        [_glassScrollArray addObject:glassView];
        [_viewScroll addSubview:glassView];
    }
    
    
    //    _glassScrollView1 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
    //                                                 BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:0] background]
    //                                                    blurredImage:nil
    //                                          viewDistanceFromBottom:120
    //                                                  foregroundView:[self customView]];
    //
    //    _glassScrollView2 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
    //                                                 BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:1] background]
    //                                                    blurredImage:nil
    //                                          viewDistanceFromBottom:120
    //                                                  foregroundView:[self customView]];
    //
    //    _glassScrollView3 = [[BTGlassScrollView alloc] initWithFrame:self.view.frame
    //                                                 BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:2] background]
    //                                                    blurredImage:nil
    //                                          viewDistanceFromBottom:120
    //                                                  foregroundView:[self customView]];
    //
    //
    //    [_viewScroller addSubview:_glassScrollView1];
    //    [_viewScroller addSubview:_glassScrollView2];
    //    [_viewScroller addSubview:_glassScrollView3];
    
    
    
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [(SideMenuTableViewController*)(self.revealViewController.rightViewController) setSelectedExhibit:_selectedExhibit];
//    [(SideMenuTableViewController*)(self.revealViewController.rightViewController) setSelectedGallery:_selectedGallery];
//    [[(SideMenuTableViewController*)(self.revealViewController.rightViewController) tableView] reloadData];
//
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
//
//    sharedModel = [Model sharedModel];
//    for (int i = 0; i < [[sharedModel galleryList] count]; i++)
//    {
//        if ([[[[sharedModel galleryList] objectAtIndex:i] name] caseInsensitiveCompare:_selectedGallery] == NSOrderedSame)
//            galleryIndex = i;
//    }
//
//
//    for (int i = 0; i < [[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] count]; i++)
//    {
//        if ([[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:i] name] caseInsensitiveCompare:_selectedExhibit] == NSOrderedSame)
//            _pageIndex = i;
//    }
//
//    _glassScrollArray = [[NSMutableArray alloc] init];
//
//
//    //showing white status
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//
//    //preventing weird inset
//    [self setAutomaticallyAdjustsScrollViewInsets: NO];
//
//    //navigation bar work
//    NSShadow *shadow = [[NSShadow alloc] init];
//    [shadow setShadowOffset:CGSizeMake(1, 1)];
//    [shadow setShadowColor:[UIColor blackColor]];
//    //[shadow setShadowBlurRadius:1];
//
//    //background
//    self.view.backgroundColor = [UIColor blackColor];
//
//    CGFloat blackSideBarWidth = 2;
//
//    _viewScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
//    [_viewScroll setPagingEnabled:YES];
//    [_viewScroll setDelegate:self];
//    [_viewScroll setShowsHorizontalScrollIndicator:NO];
//    [self.view addSubview:_viewScroll];
//
//
////    for (int i = 0; i < [[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] count]; i++)
////    {
////        BTGlassScrollView *glassView = [[BTGlassScrollView alloc]
////                                        initWithFrame:self.view.frame
////                                        BackgroundImage:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:i] background]
////                                        blurredImage:nil
////                                        viewDistanceFromBottom:120
////                                        foregroundView:[self customView]];
////
////        [_glassScrollArray addObject:glassView];
////        [_viewScroll addSubview:glassView];
////    }
//}

-(void)forceClear
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    NSLog(@"hit");
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    if(position == FrontViewPositionLeft) {
        self.view.userInteractionEnabled = YES;
    }
    else {
        self.view.userInteractionEnabled = NO;
    }
}

-(void)forceRedraw
{
    [self.view setNeedsDisplay];
}


- (void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu.png"] style:UIBarButtonItemStylePlain target:self action:@selector(rightRevealToggle:)];
    
    self.revealViewController.delegate = self;
    
    // Change button color
    button.tintColor = [UIColor whiteColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    button.target = self.revealViewController;
    
    // Set the gesture
    //    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.revealViewController panGestureRecognizer];
    
    self.navigationItem.rightBarButtonItem = button;
    //    int page = _page; // resize scrollview can cause setContentOffset off for no reason and screw things up
    int pageIndex = _pageIndex;
    
    CGFloat blackSideBarWidth = 2;
    //    [_viewScroller setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
    //    [_viewScroller setContentSize:CGSizeMake(3*_viewScroller.frame.size.width, self.view.frame.size.height)];
    
    [_viewScroll setFrame:CGRectMake(0, 0, self.view.frame.size.width + 2*blackSideBarWidth, self.view.frame.size.height)];
    [_viewScroll setContentSize:CGSizeMake([[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] count]*_viewScroll.frame.size.width, self.view.frame.size.height)];
    
    for (int i = 0; i < [_glassScrollArray count]; i++)
    {
        [[_glassScrollArray objectAtIndex:i] setFrame:self.view.frame];
    }
    
    int a = 1;
    for (int i = 1; i < [_glassScrollArray count]; i++)
    {
        [[_glassScrollArray objectAtIndex:i] setFrame:CGRectOffset([[_glassScrollArray objectAtIndex:i] bounds], a*_viewScroll.frame.size.width, 0)];
        a++;
    }
    
    [_viewScroll setContentOffset:CGPointMake(pageIndex * _viewScroll.frame.size.width, _viewScroll.contentOffset.y)];
    _pageIndex = pageIndex;
    
    //    [_glassScrollView1 setFrame:self.view.frame];
    //    [_glassScrollView2 setFrame:self.view.frame];
    //    [_glassScrollView3 setFrame:self.view.frame];
    //
    //    [_glassScrollView2 setFrame:CGRectOffset(_glassScrollView2.bounds, _viewScroller.frame.size.width, 0)];
    //    [_glassScrollView3 setFrame:CGRectOffset(_glassScrollView3.bounds, 2*_viewScroller.frame.size.width, 0)];
    //
    //    [_viewScroller setContentOffset:CGPointMake(page * _viewScroller.frame.size.width, _viewScroller.contentOffset.y)];
    //    _page = page;
    
    //show animation trick
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // [_glassScrollView1 setBackgroundImage:[UIImage imageNamed:@"background"] overWriteBlur:YES animated:YES duration:1];
    });
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];}

- (void)viewWillLayoutSubviews
{
    for (int i = 0; i < [_glassScrollArray count]; i++)
    {
        [[_glassScrollArray objectAtIndex:i] setTopLayoutGuideLength:[self.topLayoutGuide length]];
    }
}

- (UIView *)customView
{
    NSString *questionString = @"";
    for (int i = 0; i < [[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] questions] count]; i++)
    {
        questionString = [questionString stringByAppendingString:[[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] questions] objectAtIndex:i]];
        questionString = [questionString stringByAppendingString:@"\n\n"];
    }
    
    CGSize size = [[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] name]
                   sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60]
                   constrainedToSize:CGSizeMake(310, 200)
                   lineBreakMode:UILineBreakModeWordWrap];
    CGSize size1 = [[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] description]
                    sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]
                    constrainedToSize:CGSizeMake(310, 500)
                    lineBreakMode:UILineBreakModeWordWrap];
    CGSize size2 = [questionString
                    sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]
                    constrainedToSize:CGSizeMake(310, 500)
                    lineBreakMode:UILineBreakModeWordWrap];
    
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, window.frame.size.height+size.height)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 35, 310, size.height)];
    [label setText:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] name]];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-UltraLight" size:60]];
    [label setShadowColor:[UIColor blackColor]];
    [label setShadowOffset:CGSizeMake(1, 1)];
    [label setNumberOfLines:0];
    [view addSubview:label];
    
    
    UIView *box1 = [[UIView alloc] initWithFrame:CGRectMake(5, 140, 310, size1.height)];
    box1.layer.cornerRadius = 3;
    box1.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 140, 310, size1.height)];
    [label1 setText:[[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:counter] description]];
    [label1 setTextColor:[UIColor whiteColor]];
    [label1 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [label1 setShadowColor:[UIColor blackColor]];
    [label1 setShadowOffset:CGSizeMake(1, 1)];
    [label1 setNumberOfLines:0];
    [view addSubview:box1];
    [view addSubview:label1];
    
    UIView *box2 = [[UIView alloc] initWithFrame:CGRectMake(5, 140+size1.height+10, 310, size2.height)];
    box2.layer.cornerRadius = 3;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 140+size1.height+10, 310, size2.height)];
    
    [label2 setText:questionString];
    [label2 setTextColor:[UIColor whiteColor]];
    [label2 setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:14]];
    [label2 setShadowColor:[UIColor blackColor]];
    [label2 setShadowOffset:CGSizeMake(1, 1)];
    [label2 setNumberOfLines:0];
    box2.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    [view addSubview:label2];
    [view addSubview:box2];
    
    UIView *box3 = [[UIView alloc] initWithFrame:CGRectMake(5, 140+size1.height+10+size2.height+10, 310, size2.height)];
    box3.layer.cornerRadius = 3;
    box3.backgroundColor = [UIColor colorWithWhite:0 alpha:.15];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera"]];
    imageView.frame = CGRectMake(5, 140+size1.height+10+size2.height+10, 310, size2.height);
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIButton *collage = [UIButton buttonWithType:UIButtonTypeCustom];
    collage.frame = CGRectMake(5, 140+size1.height+10+size2.height+10, 310, size2.height);
    [collage addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
    [collage setEnabled:YES];
    [[collage titleLabel] setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:20]];
    [collage setBackgroundColor:[UIColor clearColor]];
    
    [view addSubview:box3];
    [view addSubview:imageView];
    [view addSubview:collage];
    
    counter++;
    return view;
}

-(void)myAction:(id)sender {
    
	UIImagePickerController *myImagePicker = [[UIImagePickerController alloc] init];
	myImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
	myImagePicker.delegate = self;
	myImagePicker.allowsEditing = NO;
	
	[self presentViewController:myImagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (CGSize)sizeForLabel:(UILabel *)label {
    CGSize constrain = CGSizeMake(label.bounds.size.width, FLT_MAX);
    CGSize size = [label.text sizeWithFont:label.font constrainedToSize:constrain lineBreakMode:UILineBreakModeWordWrap];
    
    return size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentRatio = scrollView.contentOffset.x/scrollView.frame.size.width;
    int temp = (int)floor(currentRatio);
    if (_pageIndex != temp && temp > -1)
    {
        _pageIndex = temp;
        NSString * newExhibit = [[NSString alloc] init];
        newExhibit = [[[[[sharedModel galleryList] objectAtIndex:galleryIndex] exhibitList] objectAtIndex:_pageIndex] name];
        [(SideMenuTableViewController*)(self.revealViewController.rightViewController) setSelectedExhibit:newExhibit];
        [[(SideMenuTableViewController*)(self.revealViewController.rightViewController) tableView] reloadData];
    }
    
    int lowerBound = -1;
    int upperBound = 1;
    for (int i = 0; i < [_glassScrollArray count]; i++)
    {
        if (currentRatio > lowerBound && currentRatio < upperBound)
            [[_glassScrollArray objectAtIndex:i] scrollHorizontalRatio:-currentRatio + upperBound - 1];
        
        lowerBound++;
        upperBound++;
    }
}


-(BOOL) navigationShouldPopOnBackButton {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
    return NO; // Ignore 'Back' button this time
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    BTGlassScrollView *glass = [self currentGlass];
    for (int i = 0; i < [_glassScrollArray count]; i++)
    {
        [[_glassScrollArray objectAtIndex:i] scrollVerticallyToOffset:glass.foregroundScrollView.contentOffset.y];
    }
}

- (BTGlassScrollView *)currentGlass
{
    BTGlassScrollView *currentGlass;
    for (int i = 0; i < [_glassScrollArray count]; i++)
    {
        if (i == _pageIndex)
            currentGlass = [_glassScrollArray objectAtIndex:_pageIndex];
    }
    return currentGlass;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self viewWillAppear:YES];
}

@end



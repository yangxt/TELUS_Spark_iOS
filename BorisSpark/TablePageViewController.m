//
//  TablePageViewController.m
//  BorisSpark
//
//  Created by Gellert on 2014-04-08.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "TablePageViewController.h"
#import "TableContent.h"
#import "ExhibitTableViewController.h"
#import "HomeViewController.h"
#import "Model.h"

@interface TablePageViewController ()
{
    int currentPage_;
    Model *sharedModel;
}

@end

@implementation TablePageViewController

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
    //UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    //[view setBackgroundColor:[UIColor greenColor]];
    currentPage_ = 0;
    sharedModel = [Model sharedModel];
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    _currentStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    NSNumber *aNum = [[NSNumber alloc] initWithInt:0];
    
    ExhibitTableViewController * first = [_currentStoryboard instantiateViewControllerWithIdentifier:@"TableContentID"];
    [first setGalleryName:@"Earth and Sky"];
    [first setIndex:[aNum integerValue]];

    aNum = @([aNum intValue] + 1);

    ExhibitTableViewController * second = [_currentStoryboard instantiateViewControllerWithIdentifier:@"TableContentID"];
    [second setGalleryName:@"Energy and Innovation"];
    [second setIndex:[aNum integerValue]];
    
    aNum = @([aNum intValue] + 1);
    
    ExhibitTableViewController * third = [_currentStoryboard instantiateViewControllerWithIdentifier:@"TableContentID"];
    [third setGalleryName:@"Feature"];
    [third setIndex:[aNum integerValue]];
    
    aNum = @([aNum intValue] + 1);
    
    ExhibitTableViewController * fourth = [_currentStoryboard instantiateViewControllerWithIdentifier:@"TableContentID"];
    [fourth setGalleryName:@"Creative Kids Museum"];
    [fourth setIndex:[aNum integerValue]];
    
    aNum = @([aNum intValue] + 1);
    
    ExhibitTableViewController * fifth = [_currentStoryboard instantiateViewControllerWithIdentifier:@"TableContentID"];
    [fifth setGalleryName:@"Open Studio"];
    [fifth setIndex:[aNum integerValue]];
    
    aNum = @([aNum intValue] + 1);
    
    ExhibitTableViewController * sixth = [_currentStoryboard instantiateViewControllerWithIdentifier:@"TableContentID"];
    [sixth setGalleryName:@"Being Human"];
    [sixth setIndex:[aNum integerValue]];
    
    _pages = [[NSArray alloc] initWithObjects:first, second, third, fourth, fifth, sixth, nil];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.delegate = self;
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:first, nil];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
}


- (ExhibitTableViewController *)viewControllerAtIndex:(NSUInteger)index {
    NSNumber* requestedPage = [NSNumber numberWithInt:(long)index % [_pages count]];
    return _pages[[requestedPage intValue]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger currentViewControllerIndex = [(ExhibitTableViewController *)viewController index];
    currentViewControllerIndex++;
    return [self viewControllerAtIndex:currentViewControllerIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger currentViewControllerIndex = [(ExhibitTableViewController *)viewController index];
    currentViewControllerIndex--;
    return [self viewControllerAtIndex:currentViewControllerIndex];
    
}

-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    NSString *newGallery = @"Gallery: ";
    newGallery = [newGallery stringByAppendingString:[[pendingViewControllers objectAtIndex:0] galleryName]];
    [[(HomeViewController*)([self.navigationController.viewControllers objectAtIndex:0]) galleryLabel] setText:newGallery];
        [[(HomeViewController*)([self.navigationController.viewControllers objectAtIndex:0]) galleryLabel] setShadowOffset:CGSizeMake(1, -1)];
    [[(HomeViewController*)([self.navigationController.viewControllers objectAtIndex:0]) galleryLabel] setShadowColor:[UIColor blackColor]];
}

-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{

    int currentIndex = [[self.pageController.viewControllers lastObject] index];
    currentPage_ = currentIndex;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
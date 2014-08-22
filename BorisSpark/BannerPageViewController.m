//
//  BannerPageViewController.m
//  BorisSpark
//
//  Created by Gellert on 2014-04-08.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "BannerPageViewController.h"
#import "BannerContent.h"
#include <stdlib.h>

@interface BannerPageViewController ()
{
    NSArray *firstArray;
    NSArray *secondArray;
    NSArray *thirdArray;
    NSArray *fourthArray;
    NSArray *fifthArray;
    int previousNumber;
    
    int currentPage;
}

@end

@implementation BannerPageViewController

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
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [view setBackgroundColor:[UIColor greenColor]];
    
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    _currentStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];

    NSNumber *aNum = [[NSNumber alloc] initWithInt:0];
    BannerContent *first = [_currentStoryboard instantiateViewControllerWithIdentifier:@"BannerContentID"];
    first.index = aNum.integerValue;
    
    BannerContent *second = [_currentStoryboard instantiateViewControllerWithIdentifier:@"BannerContentID"];
    second.index = [[NSNumber numberWithInt:[aNum intValue] + 1] integerValue];
    
    BannerContent *third = [_currentStoryboard instantiateViewControllerWithIdentifier:@"BannerContentID"];
    third.index = [[NSNumber numberWithInt:[aNum intValue] + 2] integerValue];
    
    BannerContent *fourth = [_currentStoryboard instantiateViewControllerWithIdentifier:@"BannerContentID"];
    fourth.index = [[NSNumber numberWithInt:[aNum intValue] + 3] integerValue];
    
    BannerContent *fifth = [_currentStoryboard instantiateViewControllerWithIdentifier:@"BannerContentID"];
    fifth.index = [[NSNumber numberWithInt:[aNum intValue] + 4] integerValue];
    
    _pages = [[NSArray alloc] initWithObjects:first, second, third, fourth, fifth, nil];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:first, nil];
    
    firstArray = [[NSArray alloc] initWithObjects:first, nil];
    secondArray = [[NSArray alloc] initWithObjects:second, nil];
    thirdArray = [[NSArray alloc] initWithObjects:third, nil];
    fourthArray = [[NSArray alloc] initWithObjects:fourth, nil];
    fifthArray = [[NSArray alloc] initWithObjects:fifth, nil];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    previousNumber = -1;
    currentPage = 0;
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollPage) userInfo:nil repeats:YES];
}

- (void)scrollPage
{
    int randomNumber = previousNumber;
    while (randomNumber == previousNumber)
    {
        randomNumber = arc4random_uniform(5);
    }

    if (randomNumber > previousNumber)
    {
        switch (randomNumber)
        {
            case 1:
                [self.pageController setViewControllers:secondArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
                break;
            case 2:
                [self.pageController setViewControllers:thirdArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
                break;
            case 3:
                [self.pageController setViewControllers:fourthArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
                break;
            case 4:
                [self.pageController setViewControllers:fifthArray direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
                break;
            default:
                break;
        }
    }
    else
    {
        switch (randomNumber)
        {
            case 0:
                [self.pageController setViewControllers:firstArray direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
                break;
            case 1:
                [self.pageController setViewControllers:secondArray direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
                break;
            case 2:
                [self.pageController setViewControllers:thirdArray direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
                break;
            case 3:
                [self.pageController setViewControllers:fourthArray direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
                break;
            default:
                break;
        }
    }
    
    previousNumber = randomNumber;
}



- (BannerContent *)viewControllerAtIndex:(NSUInteger)index {
    NSNumber* requestedPage = [NSNumber numberWithInt:(long)index % [_pages count]];
    return _pages[[requestedPage intValue]];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger currentViewControllerIndex = [(BannerContent *)viewController index];
    currentViewControllerIndex++;
    return [self viewControllerAtIndex:currentViewControllerIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger currentViewControllerIndex = [(BannerContent *)viewController index];
    currentViewControllerIndex--;
    return [self viewControllerAtIndex:currentViewControllerIndex];
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




















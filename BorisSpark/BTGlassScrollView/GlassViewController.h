//
//  ViewController.h
//  BTGlassScrollViewExample
//
//  Created by Byte on 10/18/13.
//  Copyright (c) 2013 Byte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTGlassScrollView.h"
#import "SWRevealViewController.h"

@interface GlassViewController : UIViewController <UIScrollViewAccessibilityDelegate, SWRevealViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property NSString *selectedGallery;
@property NSString *selectedExhibit;
@property NSString *test;

-(void)forceRedraw;
-(void)forceClear;

@end

@interface UIImage(Overlay)
@end

@implementation UIImage(Overlay)
- (UIImage *)imageWithColor:(UIColor *)color1
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color1 setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
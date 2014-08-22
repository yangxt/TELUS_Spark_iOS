//
//  Exhibit.m
//  BorisSpark
//
//  Created by Gellert on 2/18/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "Exhibit.h"

@implementation Exhibit

- (id) initWithDescription:(NSString*)description Questions:(NSArray*)questions Name:(NSString*)name Background:(NSString*)imageName
{

    _description = [[NSString alloc] initWithString:description];
    _questions = [[NSArray alloc] initWithArray:questions];
    _background = [[UIImage alloc] init];
    _background = [UIImage imageNamed:imageName];
    _name = name;
    [self cropBackground];
    return self;
}

- (void) cropBackground
{
    CIImage *temp = [[CIImage alloc] initWithImage:[_background copy]];
    _backgroundPrview = [UIImage imageWithCIImage:temp scale:0.2 orientation:UIImageOrientationRightMirrored];

   // UIImage *croppedImg = nil;
   // CGRect cropRect = CGRectMake(AS YOu Need); // set frame as you need
   // croppedImg = [self croppIngimageByImageName:self.imageView.image toRect:cropRect];
    
    
}

- (UIImage *)croppIngimageByImageName:(UIImage *)imageToCrop toRect:(CGRect)rect
{
    //CGRect CropRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height+15);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

@end


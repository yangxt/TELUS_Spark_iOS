//
//  collageViewController.h
//  collage
//
//  Created by Shannon Appelcline on 9/16/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PhotoCollageView.h"
#import "TemporaryImageView.h"

@interface PhotoCollageViewController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    PhotoCollageView *myCollageView;
    __weak IBOutlet UIToolbar *myTools;
    __weak IBOutlet PhotoCollageView *myView;

	TemporaryImageView *myImageView;
	UISlider *mySlider;
	CGSize startingSize;
	
	NSArray *origToolbar;
}

-(void)choosePic:(id)sender;
-(void)takePic:(id)sender;
-(void)finishPic:(id)sender;
-(void)savePic:(id)sender;

-(float)scaleImage:(UIImage *)image;

@end


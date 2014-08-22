//
//  collageAppDelegate.m
//  collage
//
//  Created by Shannon Appelcline on 9/16/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "PhotoCollageViewController.h"
#import "UIViewController+BackButtonHandler.h"
#import "PhotoCollageView.h"
#import "MyAlertViewDelegate.h"

@implementation PhotoCollageViewController
{
    int numImages;
    bool hasSaved;
}

- (void)viewDidLoad {

    myCollageView = [[PhotoCollageView alloc] init];

	UIBarButtonItem *picButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(choosePic:)];
	UIBarButtonItem *camButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePic:)];
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePic:)];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];

	picButton.style = UIBarButtonItemStyleBordered;
	camButton.style = UIBarButtonItemStyleBordered;
	
    origToolbar = [[NSArray alloc] initWithObjects:spacer, picButton, spacer, camButton, spacer, saveButton, spacer,nil];

	[myTools setItems:origToolbar animated:NO];
    [myTools setTintColor:[UIColor whiteColor]];
    [[[myTools items] objectAtIndex:5] setEnabled:NO];

    numImages = 0;
    hasSaved = false;
    
	[super viewDidLoad];
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}


-(IBAction)choosePic:(id)sender {
		
	UIImagePickerController *myImagePicker = [[UIImagePickerController alloc] init];
	myImagePicker.delegate = self;
	myImagePicker.allowsEditing = YES;

	// Updated for ipad
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
//	UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:myImagePicker];
//	[popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//#else
	[self presentViewController:myImagePicker animated:YES completion:nil];
//#endif
	
}

-(IBAction)takePic:(id)sender {
	
	UIImagePickerController *myImagePicker = [[UIImagePickerController alloc] init];
	myImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
	myImagePicker.delegate = self;
	myImagePicker.allowsEditing = NO;
	
	[self presentViewController:myImagePicker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{

	[self dismissModalViewControllerAnimated:YES];

	float percentage = [self scaleImage:image] / 2;	
	startingSize = CGSizeMake(image.size.width*percentage,image.size.height*percentage);
	
	myImageView = [[TemporaryImageView alloc] 
				   initWithFrame:CGRectMake(80,115,
											startingSize.width,
											startingSize.height)];
	myImageView.image = image;
	myImageView.userInteractionEnabled = YES;
	
	[self.view addSubview:myImageView];
	
	[myTools setItems:[NSArray arrayWithObject:
					   [[UIBarButtonItem alloc]
						initWithBarButtonSystemItem:UIBarButtonSystemItemDone
						target:self action:@selector(finishPic:)]] animated:YES];	

	// Update for ipad
	//mySlider = [[UISlider alloc] initWithFrame:CGRectMake(90,415,210,44)];
	//[self.view addSubview:mySlider];
	
	mySlider = [[UISlider alloc] initWithFrame:CGRectMake(90,0,210,44)];
	[myTools addSubview:mySlider];
	
	mySlider.value = .5;
	[mySlider addTarget:self action:@selector(rescalePic:) forControlEvents:UIControlEventValueChanged];
    numImages++;
	
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

-(void)rescalePic:(id)sender {

	myImageView.frame = CGRectMake(myImageView.frame.origin.x,
								   myImageView.frame.origin.y,
								   startingSize.width * mySlider.value * 2,
								   startingSize.height * mySlider.value * 2);


	
}

-(void)finishPic:(id)sender {

	//[(collageView *) self.view addPic:myImageView.image at:myImageView.frame];
    //[(collageView*)self.view test];
    //collageView * tempView = [[collageView alloc] init];
    [myView addPic:myImageView.image at:myImageView.frame];


//    [(collageView*)self.view addPic:myImageView.image at:myImageView.frame];
	[myImageView removeFromSuperview];
	[mySlider removeFromSuperview];
	[myTools setItems:origToolbar animated:YES];
    [[[myTools items] objectAtIndex:5] setEnabled:YES];


}

-(float)scaleImage:(UIImage *)image {

	float toSize = 1.0;
	
	// Updated for ipad
	CGRect scRect = [[UIScreen mainScreen] applicationFrame];
	
	if (image.size.width * toSize > scRect.size.width) {
		toSize = scRect.size.width / image.size.width;
	}
	if (image.size.height * toSize > (scRect.size.height - 20)) {
		toSize = (scRect.size.height - 20) / image.size.height;
	}

	return toSize;
}

-(void)savePic:(id)sender {
	UIGraphicsBeginImageContext(self.view.bounds.size);
	[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
	myTools.hidden = YES;
	UIImage *collageImage = UIGraphicsGetImageFromCurrentImageContext();
	myTools.hidden = NO;
	UIGraphicsEndImageContext();
	
	UIImageWriteToSavedPhotosAlbum(collageImage,nil,nil,nil);
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Success"
                                                      message:@"Image has been saved to camera library"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
    hasSaved = true;
    
}

-(BOOL) navigationShouldPopOnBackButton {
    if (numImages > 0 && hasSaved == false)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Leave without saving?" message:@"Yes or No?" delegate:self cancelButtonTitle:@"Yes"    otherButtonTitles:@"No", nil];
        [MyAlertViewDelegate showAlertView:alert withCallback:^(NSInteger buttonIndex) {
            if (buttonIndex == 0)
                [self.navigationController popViewControllerAnimated:YES];
        }];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
    
    
    return NO; // Ignore 'Back' button this time
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


@end

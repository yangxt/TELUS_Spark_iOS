//
//  HomeViewController.h
//  BorisSpark
//
//  Created by Gellert on 2014-04-08.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCollageView.h"
#import "TemporaryImageView.h"

@interface HomeViewController : UIViewController


@property (weak, nonatomic) NSArray *origToolbar;
@property (weak, nonatomic) IBOutlet UIView *galleryView;
@property (weak, nonatomic) IBOutlet UILabel *galleryLabel;
@property (weak, nonatomic) IBOutlet UIView *container1;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)viewGalleriesForExhibit:(id)sender;


@end

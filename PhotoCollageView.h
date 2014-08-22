//
//  collageView.h
//  collage
//
//  Created by Shannon Appelcline on 9/16/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoCollageView : UIView {

	NSMutableArray *myPics;
}

-(void)addPic:(UIImage *)newPic at:(CGRect)newLoc;
-(void)test;

@end

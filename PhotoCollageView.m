//
//  collageView.m
//  collage
//
//  Created by Shannon Appelcline on 9/16/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "PhotoCollageView.h"


@implementation PhotoCollageView

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
	}
	return self;
}


- (void)drawRect:(CGRect)rect {

	if (myPics) {
		for (int i = 0 ; i < myPics.count ; i++) {

			UIImage *thisPic = [[myPics objectAtIndex:i] objectForKey:@"picture"];
            float xpoint = [[[myPics objectAtIndex:i] objectForKey:@"xpoint"] floatValue];
            float ypoint = [[[myPics objectAtIndex:i] objectForKey:@"ypoint"] floatValue];
            float height = [[[myPics objectAtIndex:i] objectForKey:@"height"] floatValue];
            float width  = [[[myPics objectAtIndex:i] objectForKey:@"width"] floatValue];
	
			[thisPic drawInRect:CGRectMake(xpoint,ypoint,width,height)];
		}

	}
}

-(void)test
{
    NSLog(@"ASD");
}

-(void)addPic:(UIImage *)newPic at:(CGRect)newLoc {

	if (! myPics) {
		myPics = [[NSMutableArray alloc] initWithCapacity:0];

	}
	
	[myPics addObject:[NSDictionary dictionaryWithObjectsAndKeys:
					   newPic,@"picture",
					   [NSNumber numberWithFloat:newLoc.origin.x],@"xpoint",
					   [NSNumber numberWithFloat:newLoc.origin.y],@"ypoint",
					   [NSNumber numberWithFloat:newLoc.size.width],@"width",
					   [NSNumber numberWithFloat:newLoc.size.height],@"height",
					   nil]];
		
	[self setNeedsDisplay];
}


@end

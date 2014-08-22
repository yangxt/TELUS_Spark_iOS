//
//  tempImageView.m
//  collage
//
//  Created by Shannon Appelcline on 9/16/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "TemporaryImageView.h"


@implementation TemporaryImageView

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

//	self.center = [[touches anyObject] locationInView:self];

}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

//	self.center = [[touches anyObject] locationInView:self];
}

// asdasdasdasdasddd11asdasdasdasdasddd11asdasdasdasdasddd11asdasdasdasdasddd11asdasdasdasd
// asdasd aaafn eqwn iuf aisun iuasd iuansd aniun aisu diuas ˆ¨ asndiuas ndu nasiud aisun diuas ndiu asiud niuasn diuans diuansiudn aisudniuas duas dnas d
// 

/**
 *  aasssddqdwdqwdqwd  *  aasssddqdwdqwdqwd *  aasssddqdwdqwdqwd *  aasssddqdwdqwdqwd *  aasssddqdwdqwdqwd *  aasssddqdwdqwdqwdsdads
 *
 *  @param touches asd
 *  @param event   asd
 */
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    NSLog(@"movement");
	UITouch *thisTouch = [touches anyObject];
	CGPoint thisPoint = [thisTouch locationInView:self];
	
	float newX = thisPoint.x+self.frame.origin.x;
	float newY = thisPoint.y+self.frame.origin.y;


    
	if (newX - self.frame.size.width / 2 < 0) {
		newX = self.frame.size.width / 2;
	}
	
	if (newY - self.frame.size.height / 2 < 0) {
		newY = self.frame.size.height / 2;
	}
    
    NSLog(@"newX = %f, newY= %f", newX, newY);
    NSLog(@"frame width = %f, frame height = %f", self.frame.size.width, self.frame.size.height);


	CGRect scRect = [[UIScreen mainScreen] bounds];
    NSLog(@"screen width = %f, screen height = %f", scRect.size.width, scRect.size.height - 44);
    
	if(newX + self.frame.size.width / 2 > scRect.size.width) {
		newX = scRect.size.width - self.frame.size.width / 2;
	}
	if(newY + self.frame.size.height / 2 > scRect.size.height - 44) {
		newY = scRect.size.height - self.frame.size.height / 2 - 44;
	}
	
	if (thisTouch) {
		self.center = CGPointMake(newX,newY);
	}
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	// Drawing code
}



@end

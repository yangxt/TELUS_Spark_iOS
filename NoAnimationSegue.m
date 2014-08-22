//
//  NoAnimationSegue.m
//  TELUS Spark
//
//  Created by Brett Nishikawa on 2014-04-30.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "NoAnimationSegue.h"

@implementation NoAnimationSegue

- (void)perform
{
    [[self sourceViewController] presentModalViewController:[self destinationViewController] animated:NO];
}

@end

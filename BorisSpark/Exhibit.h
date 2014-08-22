//
//  Exhibit.h
//  BorisSpark
//
//  Created by Gellert on 2/18/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exhibit : NSObject

@property NSString *name;
@property NSString *description;
@property NSArray *questions;
@property UIImage *background;
@property UIImage *backgroundPrview;

- (id) initWithDescription:(NSString*)description Questions:(NSArray*)questions Name:(NSString*)name Background:(NSString*)imageName;

@end

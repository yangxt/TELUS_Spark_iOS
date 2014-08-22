//
//  Gallery.h
//  BorisSpark
//
//  Created by Gellert on 2/18/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gallery : NSObject

@property NSMutableArray *exhibitList;
@property NSString *name;

- (id) initWithExhibitList:(NSMutableArray*)list;
- (id) initWithName:(NSString*)name;

@end

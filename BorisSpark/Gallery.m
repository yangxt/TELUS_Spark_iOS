//
//  Gallery.m
//  BorisSpark
//
//  Created by Gellert on 2/18/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "Gallery.h"

@implementation Gallery

- (id) initWithExhibitList:(NSMutableArray*)list
{
    _exhibitList = [[NSMutableArray alloc] initWithArray:list];
    return self;
}

- (id) initWithName:(NSString*)name
{
    _name = name;
    _exhibitList = [[NSMutableArray alloc] init];
    return self;
}

@end

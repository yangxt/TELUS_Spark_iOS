//
//  Model.h
//  BorisSpark
//
//  Created by Gellert on 2/18/2014.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property NSMutableArray *galleryList;
@property UINavigationController *controller;

+ (id) sharedModel;


@end

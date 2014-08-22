//
//  BannerContent.m
//  BorisSpark
//
//  Created by Gellert on 2014-04-08.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import "BannerContent.h"

@interface BannerContent ()

@end

@implementation BannerContent

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    NSString* indexToString = [NSString stringWithFormat:@"%li", (long)self.index];
    NSString* imageName = [NSString stringWithFormat:@"%@.%@", indexToString, @"png"];
    [self loadImage:imageName];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void) loadImage:(NSString *) name {
   id a = [_bannerImageView initWithImage:[UIImage imageNamed:name]];
}

@end

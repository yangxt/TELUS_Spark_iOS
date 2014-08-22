//
//  CustomColoredAccessory.h
//  BorisSpark
//
//  Created by Brett Nishikawa on 2014-04-03.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    CustomColoredAccessoryTypeRight = 0,
    CustomColoredAccessoryTypeUp,
    CustomColoredAccessoryTypeDown
} CustomColoredAccessoryType;

@interface CustomColoredAccessory : UIControl
{
	UIColor *_accessoryColor;
	UIColor *_highlightedColor;
    
    CustomColoredAccessoryType _type;
}

@property (nonatomic, retain) UIColor *accessoryColor;
@property (nonatomic, retain) UIColor *highlightedColor;

@property (nonatomic, assign)  CustomColoredAccessoryType type;

+ (CustomColoredAccessory *)accessoryWithColor:(UIColor *)color type:(CustomColoredAccessoryType)type;

@end

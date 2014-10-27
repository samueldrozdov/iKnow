//
//  IKColor.m
//  iKnow
//
//  Created by Andrew Drozdov on 10/26/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import "IKColor.h"

@implementation IKColor

+ (UIColor*)rgbColorWithRed:(double)r withGreen:(double)g withBlue:(double)b withAlpha:(double)a
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

+ (UIColor*)lightTextColor
{
    return [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
}

@end

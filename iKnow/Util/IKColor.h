//
//  IKColor.h
//  iKnow
//
//  Created by Andrew Drozdov on 10/26/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKColor : NSObject

+ (UIColor*)rgbColorWithRed:(double)r withGreen:(double)g withBlue:(double)b withAlpha:(double)a;
+ (UIColor*)lightTextColor;

@end

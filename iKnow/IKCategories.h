//
//  IKCategories.h
//  iKnow
//
//  Created by Andrew Drozdov on 10/25/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IKCategories : NSObject

+ (instancetype)sharedManager;
- (NSArray*)getCategories;

@end

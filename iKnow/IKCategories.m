//
//  IKCategories.m
//  iKnow
//
//  Created by Andrew Drozdov on 10/25/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import "IKCategories.h"

@implementation IKCategories
{
    NSMutableArray *categories;
}

+ (instancetype)sharedManager
{
    static IKCategories *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (id) init
{
    if (self = [super init])
    {
        categories = [@[
//                        [@{
//                            @"key": @"food",
//                            @"title": @"A Tasty Food",
//                            @"color": [UIColor colorWithRed:46/255.0 green:204/255.0 blue:113/255.0 alpha:1.0f],
//                            @"history": [@[] mutableCopy],
//                            @"index": @0
//                            } mutableCopy],
                        
                        [@{
                           @"key": @"vocab",
                           @"title": @"Word",
                           @"color": [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1.0],
                           @"history": [@[] mutableCopy],
                           @"index": @0
                           } mutableCopy],
                        [@{
                           @"key": @"ph",
                           @"title": @"Product",
                           @"color": [UIColor colorWithRed:218/255.0 green:85/255.0 blue:47/255.0 alpha:1.0],
                           @"history": [@[] mutableCopy],
                           @"index": @0
                           } mutableCopy],
                        [@{
                           @"key": @"song",
                           @"title": @"Song",
                           @"color": [UIColor colorWithRed:155/255.0 green:89/255.0 blue:182/255.0 alpha:1.0],
                           @"history": [@[] mutableCopy],
                           @"index": @0
                           } mutableCopy]
//                        [@{
//                            @"key": @"person",
//                            @"title": @"That Person's Name",
//                            @"color": [UIColor colorWithRed:230/255.0 green:126/255.0 blue:35/255.0 alpha:1.0],
//                            @"history": [@[] mutableCopy],
//                            @"index": @0
//                            } mutableCopy],
                       ] mutableCopy];
    }
    return self;
}

- (NSMutableArray*)getCategories
{
    return categories;
}

@end

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
                        [@{
                            @"key": @"fact",
                            @"title": @"An Interesting Fact",
                            @"color": [UIColor colorWithRed:46/255.0 green:204/255.0 blue:113/255.0 alpha:1.0f],
                            @"history": [@[] mutableCopy],
                            @"index": @0
                            } mutableCopy],
                        [@{
                            @"key": @"quote",
                            @"title": @"A Cool Quote",
                            @"color": [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1.0],
                            @"history": [@[] mutableCopy],
                            @"index": @0
                            } mutableCopy],
                        [@{
                            @"key": @"vocab",
                            @"title": @"A SAT Word",
                            @"color": [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1.0],
                            @"history": [@[] mutableCopy],
                            @"index": @0
                            } mutableCopy],
                        [@{
                            @"key": @"person",
                            @"title": @"That Person's Name",
                            @"color": [UIColor colorWithRed:230/255.0 green:126/255.0 blue:35/255.0 alpha:1.0],
                            @"history": [@[] mutableCopy],
                            @"index": @0
                            } mutableCopy],
                        [@{
                            @"key": @"song",
                            @"title": @"A Nice Song",
                            @"color": [UIColor colorWithRed:155/255.0 green:89/255.0 blue:182/255.0 alpha:1.0],
                            @"history": [@[] mutableCopy],
                            @"index": @0
                            } mutableCopy]
                       ] mutableCopy];
    }
    return self;
}

- (NSMutableArray*)getCategories
{
    return categories;
}

@end

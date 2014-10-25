//
//  DataManager.h
//  iKnow
//
//  Created by Andrew Drozdov on 10/25/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (instancetype)sharedManager;
- (void)postData:(NSDictionary*)data withBlock:(void (^)(NSError *err, NSString *objectId))callback;
- (void)queryPostsWithCategory:(NSString*)category withBlock:(void (^)(NSError *err, NSArray *objects))callback;

@end

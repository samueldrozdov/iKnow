//
//  DataManager.m
//  iKnow
//
//  Created by Andrew Drozdov on 10/25/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import "DataManager.h"
#import "DataConstants.h"

@implementation DataManager

+ (instancetype)sharedManager
{
    static DataManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - Update

// Private

- (PFObject*)parsePostDictionary:(NSDictionary*)data
{
    PFObject *post = [PFObject objectWithClassName:IKPost];
    post[IKPostCategory] = data[IKPostCategory];
    post[IKPostContent] = data[IKPostContent];
    return post;
}

// Public

- (void)postData:(NSDictionary*)data withBlock:(void (^)(NSError *err, NSString *objectId))callback
{
    PFObject *post = [self parsePostDictionary:data];
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            callback(nil, post.objectId);
        } else {
            callback(error, nil);
        }
    }];
}

#pragma mark - Query

- (void)queryPostsWithCategory:(NSString*)category withBlock:(void (^)(NSError *err, NSArray *objects))callback
{
    PFQuery *query = [PFQuery queryWithClassName:IKPost];
    [query whereKey:IKPostCategory equalTo:@"Dan Stemkoski"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objs, NSError *error) {
        if (!error) {
            // The find succeeded.
            callback(nil, objs);
        } else {
            // Log details of the failure
            callback(error, nil);
        }
    }];
}

@end

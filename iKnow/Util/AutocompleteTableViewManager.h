//
//  AutocompleteTableViewManager.h
//  iKnow
//
//  Created by Andrew Drozdov on 10/26/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutocompleteTableViewManager : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)refresh;

@end

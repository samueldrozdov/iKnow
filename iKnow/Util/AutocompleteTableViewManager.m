//
//  AutocompleteTableViewManager.m
//  iKnow
//
//  Created by Andrew Drozdov on 10/26/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import "AutocompleteTableViewManager.h"

@implementation AutocompleteTableViewManager
{
    NSDictionary *category;
    UITableView *tv;
}

- (id) initWithCategory:(NSDictionary*)c andTableView:(UITableView*)tableView
{
    if (self = [super init])
    {
        category = c;
        tv = tableView;
    }
    return self;
}

- (void)refresh
{
    [tv reloadData];
}

#pragma mark - TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = @"WooHoo";
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end

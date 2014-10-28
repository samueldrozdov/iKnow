//
//  TableViewController.m
//  iKnow
//
//  Created by Samuel Drozdov on 10/24/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import "TableViewController.h"
#import "MainCellNib.h"

#import "LoginViewController.h"
#import "AddPostViewController.h"
#import "PostsTableViewController.h"
#import "IKCategories.h"

@interface TableViewController ()

@end

@implementation TableViewController {
    NSArray *categories;
}

- (void)presentLoginView {
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [self presentViewController:lvc animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        
    } else {
        [self presentLoginView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    categories = [[IKCategories sharedManager] getCategories];
    
    [self.tableView setBackgroundColor:[UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1.0f]];
    
    //Register the custom table view cell from its nib file
    UINib *mainCell = [UINib nibWithNibName:@"MainCellNib" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:mainCell forCellReuseIdentifier:@"MainCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categories count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainCellNib *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
//    cell.mainTextLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:30];
    [cell.mainTextLabel setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]];
    [cell.mainTextLabel setTextAlignment:NSTextAlignmentCenter];
    
    //add tags as identifiers of the cells row
    [cell setTag:indexPath.row];
    [cell.mainTextLabel setTag:indexPath.row];

    cell.mainTextLabel.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mainTextLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:40];

    if([categories count] == indexPath.row) {
        cell.mainTextLabel.text = @"Logout";
        
        UIColor *bgColor = [UIColor colorWithRed:241/255.0 green:196/255.0 blue:15/255.0 alpha:0.9];
        [cell setBackgroundColor:bgColor];
        [cell.mainTextLabel setBackgroundColor:bgColor];
    } else {
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipedRight:)];
        [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [cell addGestureRecognizer:swipeRight];
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipedLeft:)];
        [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [cell addGestureRecognizer:swipeLeft];
        
        //Category cell
        [cell setTag:indexPath.row];
        [cell setBackgroundColor:categories[indexPath.row][@"color"]];
        [cell.mainTextLabel setBackgroundColor:categories[indexPath.row][@"color"]];
        cell.mainTextLabel.text = categories[indexPath.row][@"title"];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height/3;
}

-(void)logoutMethod {
    NSLog(@"Logging out");
    [PFUser logOut];
    [self presentLoginView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([categories count] == indexPath.row) {
        [self logoutMethod];
    }
}

-(void)cellSwipedRight:(UIGestureRecognizer*)gesture {
    [self.view endEditing:YES];

    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    NSDictionary *category = categories[swipedIndexPath.row];
    MainCellNib *cell  = (MainCellNib*)[self.tableView cellForRowAtIndexPath:swipedIndexPath];
    [UIView animateWithDuration:0.3 animations:^{
        [cell setFrame:CGRectMake(cell.frame.size.width*5/4, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    } completion:^(BOOL finished){
        if(finished) {
            [UIView animateWithDuration:0 animations:^{
                [cell setFrame:CGRectMake(-cell.frame.size.width*5/4, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
            } completion:^(BOOL finished){
                if(finished) {
                    
                    AddPostViewController *apvc = [[AddPostViewController alloc] initWithCategory:category];
                    [self presentViewController:apvc animated:YES completion:nil];
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        [cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
                    }];
                }
            }];
        }
    }];
}

-(void)cellSwipedLeft:(UIGestureRecognizer*)gesture {
    [self.view endEditing:YES];

    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    NSDictionary *category = categories[swipedIndexPath.row];
    MainCellNib *cell  = (MainCellNib*)[self.tableView cellForRowAtIndexPath:swipedIndexPath];
    
    [UIView animateWithDuration:0.3 animations:^{
        [cell setFrame:CGRectMake(-cell.frame.size.width*5/4, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    } completion:^(BOOL finished){
        if(finished)
            [UIView animateWithDuration:0 animations:^{
                [cell setFrame:CGRectMake(cell.frame.size.width*5/4, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
            } completion:^(BOOL finished){
                if(finished) {
                    
                    PostsTableViewController *ptvc = [[PostsTableViewController alloc] initWithCategory:category];
                    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:ptvc];
                    [self presentViewController:nvc animated:YES completion:nil];
                
                    [UIView animateWithDuration:0.3 animations:^{
                        [cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
                    }];
                }
            }];
    }];
}

@end

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
#import "IKCategories.h"

@interface TableViewController ()

@end

@implementation TableViewController {
    NSArray *categories;
    NSMutableArray *colors;
    bool categorySelected;
    NSInteger selectedCategoryIndex;
    UITapGestureRecognizer *tgr;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        
    } else {
        //[self presentLoginView];
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

- (void)presentLoginView {
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [self presentViewController:lvc animated:YES completion:nil];
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
    cell.mainTextView.font = [UIFont fontWithName:@"Helvetica Bold" size:30];
    [cell.mainTextView setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]];
    [cell.mainTextView setTextAlignment:NSTextAlignmentCenter];
    
    //add tags as identifiers of the cells row
    [cell setTag:indexPath.row];
    [cell.mainTextView setTag:indexPath.row];
    [cell.categoryButton setTag:indexPath.row];
    
    cell.categoryButton.hidden = YES;
    cell.mainTextView.editable = NO;
    cell.mainTextView.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if([categories count] == indexPath.row) {
        cell.mainTextView.text = @"Logout";
        
        UIColor *bgColor = [UIColor colorWithRed:241/255.0 green:196/255.0 blue:15/255.0 alpha:0.9];
        [cell setBackgroundColor:bgColor];
        [cell.mainTextView setBackgroundColor:bgColor];
    } else {
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipedRight:)];
        [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self.view addGestureRecognizer:swipeRight];
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipedLeft:)];
        [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self.view addGestureRecognizer:swipeLeft];
        
        //Category cell
        cell.categoryButton.hidden = NO;
        [cell.categoryButton addTarget:self action:@selector(categoryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell setTag:indexPath.row];
        [cell setBackgroundColor:categories[indexPath.row][@"color"]];
        [cell.mainTextView setBackgroundColor:categories[indexPath.row][@"color"]];
        cell.mainTextView.text = categories[indexPath.row][@"title"];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Return the height of the row
    return self.view.frame.size.height/5;
}

-(void)logoutMethod {
    NSLog(@"Logging out");
    [PFUser logOut];
    [self presentLoginView];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([categories count] + 1 == indexPath.row) {
        [self logoutMethod];
    }
}

-(void)categoryButtonClicked:(UIButton*)sender {
    NSString *categoryName = categories[sender tag][@"title"]];
    
}

-(void)cellSwipedRight:(UIGestureRecognizer*)gesture {
    [self.view endEditing:YES];
    
    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    MainCellNib *cell  = (MainCellNib*)[self.tableView cellForRowAtIndexPath:swipedIndexPath];
    [UIView animateWithDuration:0.3 animations:^{
        [cell setFrame:CGRectMake(cell.frame.size.width*5/4, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    } completion:^(BOOL finished){
        if(finished) {
            [UIView animateWithDuration:0 animations:^{
                [cell setFrame:CGRectMake(-cell.frame.size.width*5/4, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
            } completion:^(BOOL finished){
                if(finished) {
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
    MainCellNib *cell  = (MainCellNib*)[self.tableView cellForRowAtIndexPath:swipedIndexPath];
    [UIView animateWithDuration:0.3 animations:^{
        [cell setFrame:CGRectMake(-cell.frame.size.width*5/4, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    } completion:^(BOOL finished){
        if(finished)
            [UIView animateWithDuration:0 animations:^{
                [cell setFrame:CGRectMake(cell.frame.size.width*5/4, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
            } completion:^(BOOL finished){
                if(finished)
                    [UIView animateWithDuration:0.3 animations:^{
                        [cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
                    }];
            }];
    }];
}



@end

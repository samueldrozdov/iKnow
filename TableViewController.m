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

- (void)presentLoginView
{
    LoginViewController *lvc = [[LoginViewController alloc] init];
    [self presentViewController:lvc animated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([PFUser currentUser] &&
        [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        
    } else {
        //[self presentLoginView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    categories = [[IKCategories sharedManager] getCategories];
    selectedCategoryIndex = 0;
    categorySelected = false;
    
    tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tgr.delegate = self;
    
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
    if(!categorySelected) {
        //If no cell has been selected return the number of categories plus one, for the add button
        return [categories count] + 1;
    } else {
        //[add] Return the number of items in the selected category
        
        //place holder
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainCellNib *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    
    cell.mainTextView.font = [UIFont fontWithName:@"Helvetica Bold" size:30];
    //[add] resize for size of text label
    
    [cell.mainTextView setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]];
    [cell.mainTextView setTextAlignment:NSTextAlignmentCenter];
    cell.mainTextView.delegate = self;
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    //add tags as identifiers of the cells row
    [cell setTag:indexPath.row];
    [cell.mainTextView setTag:indexPath.row];
    [cell.categoryButton setTag:indexPath.row];
    
    if(categorySelected) {
        //[add] Return cells for the selected category
        cell.categoryButton.hidden = YES;
        [cell.mainTextView setEditable:NO];
        [cell.mainTextView setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];

    } else
    //[Removed for now] Add your own categories
    /* if([categories count] == indexPath.row) {
        //Add button cell
        cell.mainTextView.text = [NSString stringWithFormat:@"+"];
        cell.mainTextView.font = [UIFont fontWithName:@"Helvetica Bold" size:40];
        [cell setBackgroundColor:[UIColor colorWithRed:149/255.0 green:165/255.0 blue:166/255.0 alpha:1.0]];
        [cell.mainTextView setBackgroundColor:[UIColor colorWithRed:149/255.0 green:165/255.0 blue:166/255.0 alpha:1.0]];
        [cell.mainTextView setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
        cell.mainTextView.userInteractionEnabled = NO;
        
        cell.categoryButton.hidden = YES;
        //plus button/background could be yellow because it is the most eye catching color
        
    } else */ if([categories count] == indexPath.row) {
        
        //Your Code/Button Here!
        cell.mainTextView.text = @"Logout";
        cell.mainTextView.editable = NO;
        cell.categoryButton.hidden = YES;

        cell.mainTextView.userInteractionEnabled = NO;
        
        UIColor *bgColor = [UIColor colorWithRed:241/255.0 green:196/255.0 blue:15/255.0 alpha:0.9];
        [cell setBackgroundColor:bgColor];
        [cell.mainTextView setBackgroundColor:bgColor];
    } else {
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipedRight:)];
        [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [cell addGestureRecognizer:swipeRight];
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipedLeft:)];
        [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [cell addGestureRecognizer:swipeLeft];
        
        //Category cell
        [cell setBackgroundColor:categories[indexPath.row][@"color"]];
        [cell.mainTextView setBackgroundColor:categories[indexPath.row][@"color"]];
        
        
        cell.mainTextView.text = categories[indexPath.row][@"title"];
        [cell.categoryButton addTarget:self action:@selector(categoryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.categoryButton.hidden = NO;
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
    
    /*
    MainCellNib *cell = (MainCellNib*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setTag:indexPath.row];
    if([categories count] == indexPath.row) {
        //Add button clicked
        cell.mainTextView.font = [UIFont fontWithName:@"Helvetica" size:30];
        [cell.mainTextView setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]];
        NSLog(@"hmm");
    } else if([categories count] + 1 == indexPath.row) {
        //Add button clicked
        [self logoutMethod];
    } else if([cell.mainTextView.text isEqualToString:categories[indexPath.row][@"title"]]) {
        //Only clear the text if it is the same as the default text
        cell.mainTextView.text = @"";
        //Begin editing label
    }
    */
}

#pragma mark - Text Saving / Mechanics

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [self.tableView addGestureRecognizer:tgr];
    [textView becomeFirstResponder];
    
    if([textView.text isEqualToString:categories[textView.tag][@"title"]]) {
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    [self.tableView removeGestureRecognizer:tgr];
    [textView resignFirstResponder];
    
    if([textView.text isEqualToString:categories[textView.tag][@"title"]]) {
        NSLog(@"text view was not edited");
    } else if ([[textView.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        NSLog(@"text view empty");
        textView.text = categories[textView.tag][@"title"];
    } else {
        //save text here
        NSLog(@"%@", textView.text);
    }
}

-(void)viewTapped {
    [self.view endEditing:YES];
}

-(void)cellSwipedRight:(UIGestureRecognizer*)gesture {
    [self.view endEditing:YES];
    
    CGPoint location = [gesture locationInView:self.tableView];
    NSIndexPath *swipedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    MainCellNib *cell  = (MainCellNib*)[self.tableView cellForRowAtIndexPath:swipedIndexPath];
    [UIView animateWithDuration:0.3 animations:^{
        [cell setFrame:CGRectMake(cell.frame.size.width*5/4, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    } completion:^(BOOL finished){
        if(finished)
        [UIView animateWithDuration:0 animations:^{
            [cell setFrame:CGRectMake(-cell.frame.size.width*5/4, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
        } completion:^(BOOL finished){
            if(finished)
            [UIView animateWithDuration:0.3 animations:^{
                [cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
            }];
        }];
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

#pragma mark - Editing Buttons

/* Not yet implemented
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Button 1: Generate Random Quote
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Random \n:)" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                NSLog(@"Action to perform with Button 1");
                //generate randome
        }];
    button.backgroundColor = [UIColor colorWithRed:41/255.0 green:128/255.0 blue:185/255.0 alpha:1.0];

    //Button 2: Delete
    UITableViewRowAction *button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete \n:(" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"Action to perform with Button2!");
            [categories removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

        }];
    button2.backgroundColor = [UIColor colorWithRed:192/255.0 green:57/255.0 blue:43/255.0 alpha:1.0];
    
    return @[button2, button];
}

//Make cells slidable for actions
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}
*/

#pragma mark - Section Header


-(void)backButtonTapped:(UIButton*)sender {
    categorySelected = false;
    selectedCategoryIndex = 0;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(categorySelected) {
        return 55;
    } else {
        return 0;
    }
}

-(void)categoryButtonClicked:(UIButton*)sender {
    categorySelected = true;
    selectedCategoryIndex = [sender tag];
    [self.tableView reloadData];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(categorySelected) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        NSString *categoryString = categories[selectedCategoryIndex][@"title"];
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 10, 20)];
        [backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [backButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:30]];
        [backButton setTitle:@"<" forState:UIControlStateNormal];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, tableView.frame.size.width, 30)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont fontWithName:@"Helvetica" size:30]];
        [label setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1.0]];
        [label setText:categoryString];
        
        [view addSubview:label];
        [view addSubview:backButton];
        [view setBackgroundColor:[UIColor colorWithRed:241/255.0 green:196/255.0 blue:15/255.0 alpha:1.0]];
        
        return view;
    } else {
        return nil;
    }
}



@end

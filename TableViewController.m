//
//  TableViewController.m
//  iKnow
//
//  Created by Samuel Drozdov on 10/24/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import "TableViewController.h"
#import "MainCellNib.h"

@interface TableViewController ()

@end

@implementation TableViewController {
    NSMutableArray *categories;
    NSMutableArray *colors;
    bool categorySelected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    categories = [[NSMutableArray alloc] init];
    colors = [[NSMutableArray alloc] init];
    
    categorySelected = false;
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tgr.delegate = self;
    [self.tableView addGestureRecognizer:tgr];
    
    [self.tableView setBackgroundColor:[UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1.0f]];
    
    //six flat colors so the screen (split in five) never shows two of the same color
    UIColor *color0 = [UIColor colorWithRed:46/255.0 green:204/255.0 blue:113/255.0 alpha:1.0f];
    UIColor *color1 = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:52/255.0 green:152/255.0 blue:219/255.0 alpha:1.0];
    UIColor *color3 = [UIColor colorWithRed:230/255.0 green:126/255.0 blue:35/255.0 alpha:1.0];
    UIColor *color4 = [UIColor colorWithRed:155/255.0 green:89/255.0 blue:182/255.0 alpha:1.0];
    UIColor *color5 = [UIColor colorWithRed:241/255.0 green:196/255.0 blue:15/255.0 alpha:0.9];
    [colors addObject:color0];
    [colors addObject:color1];
    [colors addObject:color2];
    [colors addObject:color3];
    [colors addObject:color4];
    [colors addObject:color5];
    
    //Register the custom table view cell from its nib file
    UINib *mainCell = [UINib nibWithNibName:@"MainCellNib" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:mainCell forCellReuseIdentifier:@"MainCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    //use plist to store category data!? Default data would work because it could be deleted
    //default categories
    [self addCategoryWithString:@"An Interesting Fact"];
    [self addCategoryWithString:@"A Cool Quote"];
    [self addCategoryWithString:@"A SAT Word"];
    [self addCategoryWithString:@"That Person's Name"];
    [self addCategoryWithString:@"A Nice Song"];
    
    //[optional] Suggestions somewhere???
    /* //Suggestions
    [self addCategoryWithString:@"A Tasty Resturaut"];
    [self addCategoryWithString:@"A Good Recipe"];
    */
}

//Add Category (Adds category, create storage for its contents)
- (void)addCategoryWithString:(NSString*)string {
    if([[string stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        NSLog(@"Write something hooligan!");
    } else {
        [categories addObject:string];
        //(optional)Maybe pick your own color too? when adding a category, boosts memory
    }
}

#pragma mark - Table View Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(!categorySelected) {
        //If no cell has been selected return the number of categories plus one, for the add button
        return [categories count] + 1;
    } else {
        //[add] Return the number of items in the selected category
        
        //place holder
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainCellNib *cell = [self.tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    
    [cell setBackgroundColor:[colors objectAtIndex:(indexPath.row % 6)]];
    [cell.mainTextView setBackgroundColor:[colors objectAtIndex:(indexPath.row % 6)]];
    cell.mainTextView.font = [UIFont fontWithName:@"Helvetica Bold" size:30];
    //[add] resize for size of text label
    
    [cell.mainTextView setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]];
    [cell.mainTextView setTextAlignment:NSTextAlignmentCenter];
    cell.mainTextView.delegate = self;
    
    if([categories count] == indexPath.row) {
        //Add button cell
        cell.mainTextView.text = [NSString stringWithFormat:@"+"];
        cell.mainTextView.font = [UIFont fontWithName:@"Helvetica Bold" size:40];
        [cell setBackgroundColor:[UIColor colorWithRed:149/255.0 green:165/255.0 blue:166/255.0 alpha:1.0]];
        [cell.mainTextView setBackgroundColor:[UIColor colorWithRed:149/255.0 green:165/255.0 blue:166/255.0 alpha:1.0]];
        [cell.mainTextView setTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
        cell.mainTextView.userInteractionEnabled = NO;
        
        cell.categoryButton.hidden = YES;
        //plus button/background could be yellow because it is the most eye catching color
        
    } else if(!categorySelected) {
        //Category cell
        
        cell.mainTextView.text = [categories objectAtIndex:indexPath.row];
        
    } else {
        //[add] Return cells for the selected category
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Return the height of the row
    return self.view.frame.size.height/5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainCellNib *cell = (MainCellNib*)[tableView cellForRowAtIndexPath:indexPath];
    if([categories count] == indexPath.row) {
        //Add button clicked
        cell.mainTextView.font = [UIFont fontWithName:@"Helvetica" size:30];
        [cell.mainTextView setTextColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]];
    } else if([cell.mainTextView.text isEqualToString:[categories objectAtIndex:indexPath.row]]) {
        //Only clear the text if it is the same as the default text
        cell.mainTextView.text = @"";
        //Begin editing label
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainCellNib *cell = (MainCellNib*)[tableView cellForRowAtIndexPath:indexPath];
    //If the cell is deselcted without new text it shows the category
    if([cell.mainTextView.text isEqualToString:@""]) {
        cell.mainTextView.text = [categories objectAtIndex:indexPath.row];
    } else {
        //[add] Stop editing text and save
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    //[add] move the selected cell to the top and make it a section header with a back button
    //reload the table view with the past data from that category
}

#pragma mark - Text Saving / Mechanics

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"ASD");
}


-(void)viewTapped {
    [self.view endEditing:YES];
}

#pragma mark - Editing Buttons

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

#pragma mark - Section Header

/* [add] for when a category is selected, it becomes the section header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(selected) {
    } else {
    return 50;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(selected) {
    } else {
    return scrollViewController;
    }
}
*/


@end
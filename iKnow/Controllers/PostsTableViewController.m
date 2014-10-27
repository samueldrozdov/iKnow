//
//  PostsTableViewController.m
//  iKnow
//
//  Created by Andrew Drozdov on 10/26/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import "PostsTableViewController.h"

#import "DataManager.h"
#import "IKColor.h"
#import "UIImage-JTColor.h"

@interface PostsTableViewController ()

@end

@implementation PostsTableViewController
{
    NSArray *posts;
    NSDictionary *category;
    DataManager *dataManager;
}

- (id) initWithCategory:(NSDictionary*)c
{
    if (self = [super init])
    {
        category = c;
        dataManager = [DataManager sharedManager];
        
        NSString *placeHolder = [NSString stringWithFormat:@"Loading data for %@...",category[@"title"]];
        posts = @[@{ @"Content": placeHolder}];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = category[@"color"];
    
    [dataManager queryPostsWithCategory:category[@"key"] withBlock:^(NSError *err, NSArray *objects) {
        posts = [NSArray arrayWithArray:objects];
        [self.tableView reloadData];
    }];
    
    [self setupNavigation];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setupNavigation
{
    [self setTitle:category[@"title"] withColor:[IKColor lightTextColor]];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.rightBarButtonItem = backButton;
    
    [self designFlatNavigationBar:self.navigationController.navigationBar withBarColor:category[@"color"] andButtonColor:[IKColor lightTextColor] andTranslucency:NO];
}

- (void)designFlatNavigationBar:(UINavigationBar*)navigationBar withBarColor:(UIColor*)barColor andButtonColor:(UIColor*)buttonColor andTranslucency:(BOOL)translucent
{
    navigationBar.barTintColor = barColor; // The actual navigation bar
    navigationBar.tintColor = buttonColor; // The color of the navigation bar buttons
    navigationBar.translucent = translucent;
    navigationBar.shadowImage = [UIImage imageWithColor:barColor];
    
    [navigationBar setBackgroundImage:[UIImage imageWithColor:barColor]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
}

- (void)setTitle:(NSString *)title withColor:(UIColor*)titleColor
{
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    titleView = [[UILabel alloc] initWithFrame:CGRectZero];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.textColor = titleColor;
    titleView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    self.navigationItem.titleView = titleView;
    titleView.text = title;
    [titleView sizeToFit];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }

    NSDictionary *item = (NSDictionary *)[posts objectAtIndex:indexPath.row];
    cell.textLabel.text = [item objectForKey:@"Content"];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

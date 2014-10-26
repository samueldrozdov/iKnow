//
//  AddPostViewController.m
//  iKnow
//
//  Created by Andrew Drozdov on 10/25/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import "AddPostViewController.h"
#import "DataManager.h"
#import "DataConstants.h"

@interface AddPostViewController ()

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)doneButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *postTextField;

@end

@implementation AddPostViewController
{
    NSDictionary *category;
    DataManager *dataManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = category[@"color"];
    self.postTextField.placeholder = category[@"title"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id) initWithCategory:(NSDictionary*)c
{
    if (self = [super init])
    {
        category = c;
        dataManager = [DataManager sharedManager];
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonClicked:(id)sender {
    NSLog(@"done clicked");
    [dataManager postData:@{
                            IKPostCategory: category[@"key"],
                            IKPostContent: self.postTextField.text
                            } withBlock:^(NSError *err, NSString *objectId) {
                                if (err) NSLog(@"failure");
                                else NSLog(@"success");
                                [self dismissViewControllerAnimated:YES completion:nil];
                            }];
    
    
}

@end

//
//  MainCell.h
//  iKnow
//
//  Created by Samuel Drozdov on 10/25/14.
//  Copyright (c) 2014 MoonAnimals. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCellNib : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *mainTextView;
@property (weak, nonatomic) IBOutlet UIButton *categoryButton;

@end

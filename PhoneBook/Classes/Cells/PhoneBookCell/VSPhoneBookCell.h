//
//  VSPhoneBookCell.h
//  PhoneBook
//
//  Created by Valera Shnaider on 25.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

#import "VSPhoneListViewController.h"

@interface VSPhoneBookCell : UITableViewCell <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (assign, nonatomic) NSInteger contactIndex;
@property (weak, nonatomic) VSPhoneListViewController *listController;

@end

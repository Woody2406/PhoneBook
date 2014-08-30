//
//  VSPhoneListViewController.h
//  PhoneBook
//
//  Created by Valera Shnaider on 25.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

@interface VSPhoneListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *contactListTableView;

- (void)reloadContacts;

@end

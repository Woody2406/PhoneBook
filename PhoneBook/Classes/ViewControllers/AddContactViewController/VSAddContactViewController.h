//
//  VSAddContactViewController.h
//  PhoneBook
//
//  Created by Valera Shnaider on 25.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

#import "VSContactsManager.h"
#import "VSContactDetailsViewController.h"

@interface VSAddContactViewController : UIViewController

@property (weak, nonatomic) VSContactModel *contact;
@property (weak, nonatomic) VSContactDetailsViewController *contactDetailController;

@end

//
//  VSViewController.m
//  PhoneBook
//
//  Created by Valera Shnaider on 25.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

#import "VSStartViewController.h"
#import "VSContactsManager.h"

@interface VSStartViewController ()

@end

@implementation VSStartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[VSContactsManager sharedInstance] getContactsFromPhone];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

@end

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

@property (weak, nonatomic) IBOutlet UIImageView *appLogoImageView;
@end

@implementation VSStartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[VSContactsManager sharedInstance] getContactsFromPhone];
    self.appLogoImageView.layer.cornerRadius = 120.0f;
    self.appLogoImageView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openPhoneBook:)];
    [self.appLogoImageView addGestureRecognizer:tapGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    self.appLogoImageView.layer.opacity = 1;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)openPhoneBook:(UITapGestureRecognizer *)tapGesture
{
    [self performSegueWithIdentifier:@"phoneList" sender:self];
}

@end

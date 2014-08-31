//
//  VSContactDetailsViewController.m
//  PhoneBook
//
//  Created by Valera Shnaider on 25.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

#import "VSContactDetailsViewController.h"
#import "VSAddContactViewController.h"

@interface VSContactDetailsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *surnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end

@implementation VSContactDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width / 2;
    self.photoImageView.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.nameTextField.text = self.contact.name;
    self.surnameTextField.text = self.contact.surname;
    self.phoneNumberTextField.text = self.contact.phoneNumber;
    self.emailTextField.text = self.contact.email;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    self.birthdayTextField.text = [formatter stringFromDate:self.contact.birthday];
    self.photoImageView.image = self.contact.photo;
}

- (IBAction)editContact:(id)sender
{
    VSAddContactViewController *editContactController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"addContact"];
    editContactController.contact = self.contact;
    editContactController.contactDetailController = self;
    [self presentViewController:editContactController animated:NO completion:nil];
}
@end

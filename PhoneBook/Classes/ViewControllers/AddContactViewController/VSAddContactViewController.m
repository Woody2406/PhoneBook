//
//  VSAddContactViewController.m
//  PhoneBook
//
//  Created by Valera Shnaider on 25.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

#import "VSAddContactViewController.h"
#import "VSContactsManager.h"

@interface VSAddContactViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *surnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation VSAddContactViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.datePicker.hidden = YES;
    if (self.contact) {
        self.nameTextField.text = self.contact.name;
        self.surnameTextField.text = self.contact.surname;
        self.phoneTextField.text = self.contact.phoneNumber;
        self.emailTextField.text = self.contact.email;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"dd MMMM yyyy"];
        self.birthdayTextField.text = [formatter stringFromDate:self.contact.birthday];
        self.photoImageView.image = self.contact.photo;
    }
    self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.width / 2;
    self.photoImageView.layer.masksToBounds = YES;
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)newDateValue:(id)sender
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM yyyy"];
    self.birthdayTextField.text = [formatter stringFromDate:self.datePicker.date];
}
- (IBAction)showDatePicker:(id)sender
{
    [self.nameTextField resignFirstResponder];
    [self.surnameTextField resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    self.datePicker.hidden = NO;
}

- (IBAction)done:(id)sender
{
    VSContactModel *contact = [[VSContactModel alloc] init];
    contact.name = self.nameTextField.text;
    contact.surname = self.surnameTextField.text;
    contact.phoneNumber = self.phoneTextField.text;
    contact.email = self.emailTextField.text;
    contact.birthday = self.datePicker.date;
    contact.photo = self.photoImageView.image;
    
    if (!self.contact) {
        [[VSContactsManager sharedInstance].contacts addObject:contact];
    } else {
        [[VSContactsManager sharedInstance].contacts replaceObjectAtIndex:[[VSContactsManager sharedInstance].contacts indexOfObject:self.contact] withObject:contact];
        self.contactDetailController.contact = contact;
    }
     [[VSContactsManager sharedInstance] saveContactList];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.datePicker.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end

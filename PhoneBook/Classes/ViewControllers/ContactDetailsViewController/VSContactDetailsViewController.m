//
//  VSContactDetailsViewController.m
//  PhoneBook
//
//  Created by Valera Shnaider on 25.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

#import "VSContactDetailsViewController.h"

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
    self.nameTextField.text = self.contact.name;
    self.surnameTextField.text = self.contact.surname;
    self.phoneNumberTextField.text = [NSString stringWithFormat:@"%li", self.contact.phoneNumber];
    self.emailTextField.text = self.contact.email;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    self.birthdayTextField.text = [formatter stringFromDate:self.contact.birthday];
}

@end

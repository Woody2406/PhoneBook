//
//  VSPhoneBookCell.m
//  PhoneBook
//
//  Created by Valera Shnaider on 25.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

#import "VSPhoneBookCell.h"
#import "VSContactsManager.h"

@implementation VSPhoneBookCell

- (IBAction)deleteContact:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Delete contact" message:@"Do you want to delete this contact?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1: {
            [[VSContactsManager sharedInstance].contacts removeObject:[VSContactsManager sharedInstance].contacts[self.contactIndex]];
            [self.listController reloadContacts];
            [[VSContactsManager sharedInstance] saveContactList];
            break;
        }
        default:
            break;
    }
}

@end

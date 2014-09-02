//
//  VSContactsManager.m
//  PhoneBook
//
//  Created by Valera Shnaider on 30.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

#import "VSContactsManager.h"

@implementation VSContactsManager

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    
    static dispatch_once_t dispatchOnceT;
    dispatch_once(&dispatchOnceT, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;    
}

- (void)getContactsFromPhone
{
    self.contacts = [[NSMutableArray alloc] init];

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            if (!granted){
                NSLog(@"Just denied");
                return;
            }
            ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
            
            NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
            
            for (int i = 0; i < allContacts.count; i++) {
                
                VSContactModel *contact = [[VSContactModel alloc] init];
                
                contact.name = (__bridge_transfer NSString *)ABRecordCopyValue(CFBridgingRetain(allContacts[i]), kABPersonFirstNameProperty);
                contact.surname = (__bridge_transfer NSString *)ABRecordCopyValue(CFBridgingRetain(allContacts[i]), kABPersonLastNameProperty);
                ABMultiValueRef emails = ABRecordCopyValue(CFBridgingRetain(allContacts[i]), kABPersonEmailProperty);
                if (emails) {
                    contact.email = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emails, 0);
                }
                ABMultiValueRef phones = ABRecordCopyValue(CFBridgingRetain(allContacts[i]), kABPersonPhoneProperty);
                if (phones) {
                    contact.phoneNumber = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, 0);
                }
                contact.birthday = (__bridge_transfer NSDate *)ABRecordCopyValue(CFBridgingRetain(allContacts[i]), kABPersonBirthdayProperty);
                contact.photo = [UIImage imageWithData:(__bridge_transfer NSData *)ABPersonCopyImageDataWithFormat(CFBridgingRetain(allContacts[i]), kABPersonImageFormatThumbnail)];
                
                [self.contacts addObject:contact];
            }
            [self saveContactList];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        });
    } else {
        [self getContactList];
    }
}

- (void)saveContactList
{
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
    
    for (VSContactModel *contact in self.contacts) {
        NSMutableDictionary *contactDictionary = [[NSMutableDictionary alloc] init];
        [contactDictionary setObject:contact.name ? contact.name : @"" forKey:@"name"];
        [contactDictionary setObject:contact.surname ? contact.surname : @"" forKey:@"surname"];
        [contactDictionary setObject:contact.phoneNumber ? contact.phoneNumber : @"" forKey:@"phone"];
        [contactDictionary setObject:contact.email ? contact.email : @"" forKey:@"email"];
        [contactDictionary setObject:contact.birthday ? contact.birthday : [NSDate dateWithTimeIntervalSince1970:-999999999999999999] forKey:@"birthday"];
        [contactDictionary setObject:contact.photo ? UIImagePNGRepresentation(contact.photo) : UIImagePNGRepresentation([UIImage imageNamed:@"DefaultProfileImage"]) forKey:@"photo"];
        [contacts addObject:contactDictionary];
    }
    [[NSUserDefaults standardUserDefaults] setObject:contacts forKey:@"contactList"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)getContactList
{
    NSMutableArray *contacts = [[NSMutableArray alloc] initWithArray:(NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"contactList"]];
    for (NSDictionary *contact in contacts) {
        VSContactModel *contactModel = [[VSContactModel alloc] init];
        contactModel.name = [contact valueForKey:@"name"];
        contactModel.surname = [contact valueForKey:@"surname"];
        contactModel.email = [contact valueForKey:@"email"];
        contactModel.phoneNumber = [contact valueForKey:@"phone"];
        contactModel.birthday = [contact valueForKey:@"birthday"];
        contactModel.photo = [UIImage imageWithData:[contact valueForKey:@"photo"]];
        [self.contacts addObject:contactModel];

    }
    [self sortContactList];
}

- (void)sortContactList
{
    [self.contacts sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
}

@end

//
//  VSContactsManager.h
//  PhoneBook
//
//  Created by Valera Shnaider on 30.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

#import "VSContactModel.h"
#import <AddressBook/AddressBook.h>

@interface VSContactsManager : NSObject

@property (strong,nonatomic) NSMutableArray *contacts;

+ (instancetype)sharedInstance;
- (void)getContactsFromPhone;
- (void)saveContactList;

@end

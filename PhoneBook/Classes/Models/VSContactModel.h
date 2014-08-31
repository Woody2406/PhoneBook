//
//  VSContactModel.h
//  PhoneBook
//
//  Created by Valera Shnaider on 30.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//


@interface VSContactModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) UIImage *photo;

@end

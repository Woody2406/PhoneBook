//
//  VSPhoneListViewController.m
//  PhoneBook
//
//  Created by Valera Shnaider on 25.08.14.
//  Copyright (c) 2014 Valera Shnaider. All rights reserved.
//

#import "VSPhoneListViewController.h"
#import "VSPhoneBookCell.h"
#import "VSContactsManager.h"
#import "VSContactDetailsViewController.h"

@interface VSPhoneListViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSArray *filteredContactList;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation VSPhoneListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.filteredContactList = [NSArray arrayWithArray:[VSContactsManager sharedInstance].contacts];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[VSContactsManager sharedInstance] sortContactList];
    self.filteredContactList = [VSContactsManager sharedInstance].contacts;
    [self.contactListTableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filteredContactList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VSPhoneBookCell *cell = [tableView dequeueReusableCellWithIdentifier:@"phoneBookCell"];
    VSContactModel *contact = (VSContactModel *)[self.filteredContactList objectAtIndex:indexPath.row];
    cell.contactName.text = [NSString stringWithFormat:@"%@ %@", contact.name, contact.surname];
    cell.contactIndex = indexPath.row;
    cell.listController = self;
    return cell;
}

 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
        [tableView cellForRowAtIndexPath:indexPath].selected = NO;
        return;
    }
    VSContactDetailsViewController *detailController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"contactDetails"];
    detailController.contact = [VSContactsManager sharedInstance].contacts[indexPath.row];
    [self.navigationController pushViewController:detailController animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (!searchText.length) {
        self.filteredContactList = [VSContactsManager sharedInstance].contacts;
        [self.contactListTableView reloadData];
        return;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name BEGINSWITH[c] %@) OR (surname BEGINSWITH[c] %@)", searchText, searchText];
    self.filteredContactList = [[VSContactsManager sharedInstance].contacts filteredArrayUsingPredicate:predicate];
    [self.contactListTableView reloadData];
}

- (void)reloadContacts
{
    self.filteredContactList = [VSContactsManager sharedInstance].contacts;
    [self.contactListTableView reloadData];
}

@end

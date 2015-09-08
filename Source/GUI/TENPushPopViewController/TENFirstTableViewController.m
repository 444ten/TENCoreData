//
//  TENFirstTableViewController.m
//  TENCoreData
//
//  Created by 444ten on 9/8/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import "TENFirstTableViewController.h"

#import "TENSecondViewController.h"
#import "TENModel.h"

@implementation TENFirstTableViewController

#pragma mark -
#pragma mark View Controller Life Cycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = self.model.title;
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TENSecondViewController *controller = [TENSecondViewController new];
    controller.model = self.model;

    [self.navigationController pushViewController:controller animated:YES];
}

@end

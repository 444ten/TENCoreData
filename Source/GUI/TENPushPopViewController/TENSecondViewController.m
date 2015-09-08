//
//  TENSecondViewController.m
//  TENCoreData
//
//  Created by 444ten on 9/8/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import "TENSecondViewController.h"
#import "TENModel.h"

@implementation TENSecondViewController

#pragma mark -
#pragma mark View Handling

- (IBAction)onButton:(UIButton *)sender {
    NSLog(@"%@" ,sender.restorationIdentifier);
    
    self.model.title = sender.restorationIdentifier;
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

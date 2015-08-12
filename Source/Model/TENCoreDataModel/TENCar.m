//
//  TENCar.m
//  TENCoreData
//
//  Created by 444ten on 8/12/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import "TENCar.h"
#import "TENUser.h"


@implementation TENCar

@dynamic model;
@dynamic user;

- (BOOL)validateForDelete:(NSError **)error {
    NSLog(@"car: %@ deleted", self.model);
    
    return YES;
}

@end

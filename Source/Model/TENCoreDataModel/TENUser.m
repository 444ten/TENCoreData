//
//  TENUser.m
//  TENCoreData
//
//  Created by 444ten on 8/12/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import "TENUser.h"
#import "TENCar.h"


@implementation TENUser

@dynamic firstName;
@dynamic lastName;
@dynamic car;

- (BOOL)validateForDelete:(NSError **)error {
    NSLog(@"user: %@ deleted", self.firstName);
    
    return YES;
}

@end

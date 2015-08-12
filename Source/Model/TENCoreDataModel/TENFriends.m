//
//  TENFriends.m
//  TENCoreData
//
//  Created by 444ten on 8/12/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import "TENFriends.h"

static NSString * const kTENFirstName = @"firstName";
static NSString * const kTENLastName = @"lastName";

@implementation TENFriends

@dynamic firstName;
@dynamic lastName;

#pragma mark -
#pragma mark Accessors

- (void)setFirstName:(NSString *)firstName {
    [self willChangeValueForKey:kTENFirstName];
    [self setPrimitiveValue:firstName forKey:kTENFirstName];
    [self didChangeValueForKey:kTENFirstName];
    
    NSLog(@"SET firstName");
}

- (NSString *)firstName {
    NSString *result = nil;
    
    [self willAccessValueForKey:kTENFirstName];
    result = [self primitiveValueForKey:kTENFirstName];
    [self didAccessValueForKey:kTENFirstName];
    
    NSLog(@"GET firstName");
    
    return result;
}

//- (BOOL)validateFirstName:(__autoreleasing id *)value error:(NSError *__autoreleasing *)error {
//    NSLog(@"firstName invalidate");
//    
//    return NO;
//}

@end

//
//  TENUser.h
//  TENCoreData
//
//  Created by 444ten on 8/20/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TENCoreDataObject.h"

@class TENCar;

@interface TENUser : TENCoreDataObject

@property (nonatomic, retain) NSString  *firstName;
@property (nonatomic, retain) NSString  *lastName;
@property (nonatomic, retain) TENCar    *car;
@property (nonatomic, retain) NSArray   *firstNameS;

@end

//
//  TENCar.h
//  TENCoreData
//
//  Created by 444ten on 8/12/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TENCoreDataObject.h"

@class TENUser;

@interface TENCar : TENCoreDataObject

@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) TENUser *user;

@end

//
//  TENDataManager.h
//  TENCoreData
//
//  Created by 444ten on 8/20/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

static NSString * const TENEnityUser = @"TENUser";
static NSString * const TENEnityCar = @"TENCar";
static NSString * const TENEnityCoreDataObject = @"TENCoreDataObject";

@interface TENDataManager : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext          *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel            *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator    *persistentStoreCoordinator;

+ (TENDataManager *)sharedManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)addUserWithFirstName:(NSString *)firstName lastName:(NSString *)lastName carModel:(NSString *)carModel;
- (void)addUsers;

- (NSArray *)allObjects;
- (NSArray *)objectsByEntityName:(NSString *)entityName;
- (void)printObjectsFromArray:(NSArray *)array;
- (void)deleteAllObjects;
- (void)deleteFirstCar;
- (void)deleteFirstUser;


@end

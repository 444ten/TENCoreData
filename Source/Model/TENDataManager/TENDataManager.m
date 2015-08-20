//
//  TENDataManager.m
//  TENCoreData
//
//  Created by 444ten on 8/20/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import "TENDataManager.h"

#import "TENCar.h"
#import "TENUser.h"

static NSString * const TENEnityUser = @"TENUser";
static NSString * const TENEnityCar = @"TENCar";
static NSString * const TENEnityCoreDataObject = @"TENCoreDataObject";

@interface TENDataManager ()

- (void)addUserWithFirstName:(NSString *)firstName lastName:(NSString *)lastName carModel:(NSString *)carModel;
- (void)addUsers;

- (NSArray *)allObjects;
- (NSArray *)objectsByEntityName:(NSString *)entityName;
- (void)printObjectsFromArray:(NSArray *)array;
- (void)deleteAllObjects;
- (void)deleteFirstCar;
- (void)deleteFirstUser;

@end

@implementation TENDataManager

#pragma mark -
#pragma mark Class Methods

+ (TENDataManager *)sharedManager {
    static TENDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [TENDataManager new];
    });
    
    return manager;
}

#pragma mark -
#pragma mark Private

- (void)addUserWithFirstName:(NSString *)firstName lastName:(NSString *)lastName carModel:(NSString *)carModel {
    TENUser *user = [NSEntityDescription insertNewObjectForEntityForName:TENEnityUser inManagedObjectContext:self.managedObjectContext];
    TENCar *car = [NSEntityDescription insertNewObjectForEntityForName:TENEnityCar inManagedObjectContext:self.managedObjectContext];
    
    
    user.firstName = firstName;
    user.lastName  = lastName;
    user.car = car;
    
    car.model = carModel;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
        
        abort();
    }
}

- (void)addUsers {
    [self addUserWithFirstName:@"Sara" lastName:@"Conor" carModel:@"Citroen"];
    [self addUserWithFirstName:@"John" lastName:@"Doe" carModel:@"Jeep"];
    [self addUserWithFirstName:@"Mary" lastName:@"Kay" carModel:@"Mazda"];
}

- (NSArray *)allObjects {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:TENEnityCoreDataObject inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest new];
    request.entity = entityDescription;
    request.fetchBatchSize = 2;
    //    request.fetchOffset
    //    request.fetchLimit
    //    request.relationshipKeyPathsForPrefetching = @[...] - сразу загрузить из базы
    
    return [self.managedObjectContext executeFetchRequest:request error:nil];
}

- (NSArray *)objectsByEntityName:(NSString *)entityName {
    //    NSEntityDescription *description = [NSEntityDescription entityForName:entityName
    //                                                   inManagedObjectContext:self.managedObjectContext];
    //    NSFetchRequest *request = [NSFetchRequest new];
    NSFetchRequest *request = [self.managedObjectModel fetchRequestTemplateForName:@"carModelJeep"];
    
    //    request.entity = description;
    //    request.relationshipKeyPathsForPrefetching = @[@"user"];
    //
    //    NSSortDescriptor *modelDescriptor = [[NSSortDescriptor alloc] initWithKey:@"model" ascending:NO];
    //    request.sortDescriptors = @[modelDescriptor];
    
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"user.firstName = %@", @"Sara"]; // courses.@count
    //    request.predicate = predicate;
    
    return [self.managedObjectContext executeFetchRequest:request error:nil];
}

- (void)printObjectsFromArray:(NSArray *)array {
    for (id object in array) {
        if ([object isMemberOfClass:[TENUser class]]) {
            TENUser *user = (TENUser *)object;
            NSLog(@"user: %@ - %@, car: %@", user.firstName, user.lastName, user.car.model);
        } else if ([object isMemberOfClass:[TENCar class]]) {
            TENCar *car = (TENCar *)object;
            NSLog(@"car: %@, user: %@", car.model, car.user.firstName);
        }
    }
}

- (void)deleteAllObjects {
    NSArray *objects = [self allObjects];
    
    for (id object in objects) {
        [self.managedObjectContext deleteObject:object];
    }
    
    [self.managedObjectContext save:nil];
}

- (void)deleteFirstCar {
    TENCar *car = [[self objectsByEntityName:TENEnityCar] firstObject];
    
    [self.managedObjectContext deleteObject:car];
    [self.managedObjectContext save:nil];
}

- (void)deleteFirstUser {
    TENUser *user = [[self objectsByEntityName:TENEnityUser] firstObject];
    
    [self.managedObjectContext deleteObject:user];
    [self.managedObjectContext save:nil];
    
}

#pragma mark -
#pragma mark Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "TEN.TENCoreData" in the application's documents directory.
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TENCoreData" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TENCoreData.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
    if (!coordinator) {
        return nil;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end

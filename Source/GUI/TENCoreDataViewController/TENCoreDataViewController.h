//
//  TENCoreDataViewController.h
//  TENCoreData
//
//  Created by 444ten on 8/20/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TENCoreDataViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

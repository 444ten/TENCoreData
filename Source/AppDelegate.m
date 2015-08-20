//
//  AppDelegate.m
//  TENCoreData
//
//  Created by 444ten on 8/12/15.
//  Copyright (c) 2015 444ten. All rights reserved.
//

#import "AppDelegate.h"

#import "UIWindow+TENExtensions.h"
#import "UIViewController+TENExtensions.h"

#import "TENFriendsViewController.h"
#import "TENDataManager.h"
#import "TENCoreDataViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    TENCoreDataViewController *controller = [TENCoreDataViewController controller];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];

    window.rootViewController = navigationController;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

    [[TENDataManager sharedManager] saveContext];
}

@end

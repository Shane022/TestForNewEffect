//
//  AppDelegate.m
//  TestForNewEffect
//
//  Created by dvt04 on 17/5/3.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "AppDelegate.h"
#import "TSPSuspensionWindow.h"

@interface AppDelegate ()

@property (nonatomic, strong) TSPSuspensionWindow *suspensionView;

@end

@implementation AppDelegate

- (void)showSuspensionView
{
    [self performSelector:@selector(setSuspensionView) withObject:nil afterDelay:1.5];
}

- (void)setSuspensionView
{
    if (_suspensionView == nil) {
        _suspensionView = [[TSPSuspensionWindow alloc] initWithFrame:CGRectMake(5, 150, 60, 60)];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self.window makeKeyWindow];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSuspensionView) name:@"showSuspensionView" object:nil];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

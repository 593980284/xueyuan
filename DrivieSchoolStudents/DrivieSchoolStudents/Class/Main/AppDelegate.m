//
//  AppDelegate.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "AppDelegate.h"
#import "EDSTabBarViewController.h"
#import "EDSMoLocationManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //只获取一次
    __block  BOOL isOnece = YES;
    [EDSMoLocationManager getMoLocationWithSuccess:^(double lat, double lng){
        isOnece = NO;
        //只打印一次经纬度
        DLog(@"lat lng (%f, %f)", lat, lng);
        
        [UserDefault setObject:@{@"lat":[NSString stringWithFormat:@"%f",lat],@"lng":[NSString stringWithFormat:@"%f",lng]} forKey:KuserDefaultsLocation];
        
        if (!isOnece) {
            [EDSMoLocationManager stop];
        }
    } Failure:^(NSError *error){
        isOnece = NO;
        DLog(@"error = %@", error);
        if (!isOnece) {
            [EDSMoLocationManager stop];
        }
    }];
    
    
    //    //一直持续获取定位则
    //    [EDSMoLocationManager getMoLocationWithSuccess:^(double lat, double lng){
    //        //不断的打印经纬度
    //        DLog(@"lat lng (%f, %f)", lat, lng);
    //    } Failure:^(NSError *error){
    //        DLog(@"error = %@", error);
    //    }];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[EDSTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
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

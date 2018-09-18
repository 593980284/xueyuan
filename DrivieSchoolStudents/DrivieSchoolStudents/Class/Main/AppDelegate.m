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

#import "XGPush.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<XGPushDelegate>

@end

@implementation AppDelegate
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error {
    
    NSLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
    [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:@"" type:XGPushTokenBindTypeAccount];
}

- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error {
    
}

- (void)xgPushDidRegisteredDeviceToken:(NSString *)deviceToken error:(NSError *)error {
    NSLog(@"%s, result %@, error %@", __FUNCTION__, error?@"NO":@"OK", error);
}


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
    
    
    [[XGPush defaultManager] setEnableDebug:YES];
    XGNotificationAction *action1 = [XGNotificationAction actionWithIdentifier:@"xgaction001" title:@"xgAction1" options:XGNotificationActionOptionNone];
    XGNotificationAction *action2 = [XGNotificationAction actionWithIdentifier:@"xgaction002" title:@"xgAction2" options:XGNotificationActionOptionDestructive];
    if (action1 && action2) {
        XGNotificationCategory *category = [XGNotificationCategory categoryWithIdentifier:@"xgCategory" actions:@[action1, action2] intentIdentifiers:@[] options:XGNotificationCategoryOptionNone];
        
        XGNotificationConfigure *configure = [XGNotificationConfigure configureNotificationWithCategories:[NSSet setWithObject:category] types:XGUserNotificationTypeAlert|XGUserNotificationTypeBadge|XGUserNotificationTypeSound];
        if (configure) {
            [[XGPush defaultManager] setNotificationConfigure:configure];
        }
    }
    
    [[XGPush defaultManager] startXGWithAppID:2200309040 appKey:@"IPG9R71U6H8B" delegate:self];
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    
    [self moveFilesToDocument];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[EDSTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    return YES;
}


//把数据库放到document
- (void)moveFilesToDocument
{
    NSFileManager*fileManager =[NSFileManager defaultManager];
    NSError*error;
    NSArray*paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory =[paths objectAtIndex:0];

    NSString*txtPath = [documentsDirectory stringByAppendingPathComponent:@"bank.db"];

    if([fileManager fileExistsAtPath:txtPath] == NO){
        NSString*resourcePath =[[NSBundle mainBundle] pathForResource:@"bank" ofType:@"db"];
        [fileManager copyItemAtPath:resourcePath toPath:txtPath error:&error];
    }
    
    NSFileManager*fileManager1 =[NSFileManager defaultManager];
    NSError*error1;
    NSArray*paths1 =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString*documentsDirectory1 =[paths1 objectAtIndex:0];
    
    NSString*txtPath1 = [documentsDirectory1 stringByAppendingPathComponent:@"classify.db"];
    
    if([fileManager1 fileExistsAtPath:txtPath1] == NO){
        NSString*resourcePath =[[NSBundle mainBundle] pathForResource:@"classify" ofType:@"db"];
        [fileManager1 copyItemAtPath:resourcePath toPath:txtPath1 error:&error1];
    }
    
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

// 此方法不再需要实现；
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSLog(@"[XGDemo] device token is %@", [[XGPushTokenManager defaultTokenManager] deviceTokenString]);
//}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"[XGDemo] register APNS fail.\n[XGDemo] reason : %@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"registerDeviceFailed" object:nil];
}

/**
 收到通知消息的回调，通常此消息意味着有新数据可以读取（iOS 7.0+）
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"[XGDemo] receive slient Notification");
    NSLog(@"[XGDemo] userinfo %@", userInfo);
    [SVProgressHUD showWithStatus:userInfo];
    [SVProgressHUD dismissWithDelay:5];
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

// iOS 10 新增 API
// iOS 10 会走新 API, iOS 10 以前会走到老 API
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
// App 用户点击通知
// App 用户选择通知中的行为
// App 用户在通知中心清除消息
// 无论本地推送还是远程推送都会走这个回调
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    NSLog(@"[XGDemo] click notification");
    if ([response.actionIdentifier isEqualToString:@"xgaction001"]) {
        NSLog(@"click from Action1");
    } else if ([response.actionIdentifier isEqualToString:@"xgaction002"]) {
        NSLog(@"click from Action2");
    }
    
    [SVProgressHUD showWithStatus:response.actionIdentifier];
    [SVProgressHUD dismissWithDelay:5];
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    
    completionHandler();
}

// App 在前台弹通知需要调用这个接口
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}
#endif
@end

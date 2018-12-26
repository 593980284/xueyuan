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
#import "EDSTheoryLearningViewController.h"
#import "EDSNavigationViewController.h"
#import "NSObject+EDSTool.h"
#import "EDSBeingPushedViewController.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>
#import "XGPush.h"

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<XGPushDelegate>

@end

@implementation AppDelegate
- (void)xgPushDidFinishStart:(BOOL)isSuccess error:(NSError *)error {
    
    DLog(@"%s, result %@, error %@", __FUNCTION__, isSuccess?@"OK":@"NO", error);
    if ([EDSToolClass isBlankString:[EDSSave account].userID]) {
        
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:[EDSSave account].phone type:XGPushTokenBindTypeAccount];
    }else{
        
        [[XGPushTokenManager defaultTokenManager] bindWithIdentifier:@"" type:XGPushTokenBindTypeAccount];
    }
    
}

- (void)xgPushDidFinishStop:(BOOL)isSuccess error:(NSError *)error {
    
}

- (void)xgPushDidRegisteredDeviceToken:(NSString *)deviceToken error:(NSError *)error {
    DLog(@"%s, result %@, error %@", __FUNCTION__, error?@"NO":@"OK", error);
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
	//第三方注册
	[self registerKey];
	
    [[XGPush defaultManager] startXGWithAppID:2200309037 appKey:@"IE5JCL1H877B" delegate:self];
    [[XGPush defaultManager] setXgApplicationBadgeNumber:0];
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    
    [self moveFilesToDocument];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[EDSTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    [self loadCookies];
    return YES;
}

- (void)registerKey
{
	
//	//友盟
	[UMConfigure initWithAppkey:@"5c1a13ddb465f5eabc000286" channel:@"App Store"];
#ifdef DEBUG
	    [[UMSocialManager defaultManager] openLog:YES];
#else
#endif
//	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WX_APP_ID appSecret:WX_APP_Secret redirectURL:nil];
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101537582" appSecret:@"947129a7fbabef719410f6486ae9693f" redirectURL:@"www.qq.com"];
	
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
	//6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
	//6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
	BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}
//加载Cookie 一般都是app刚刚启动的时候
- (void)loadCookies
{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"org.skyfox.cookie"]];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie  in cookies) {
        [cookieStorage setCookie:cookie];
    }
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
    DLog(@"[XGDemo] register APNS fail.\n[XGDemo] reason : %@", error);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"registerDeviceFailed" object:nil];
}

/**
 收到通知消息的回调，通常此消息意味着有新数据可以读取（iOS 7.0+）
 
 @param application  UIApplication 实例
 @param userInfo 推送时指定的参数
 @param completionHandler 完成回调
 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    DLog(@"[XGDemo] receive slient Notification");
    DLog(@"[XGDemo] userinfo %@", userInfo);
    
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
    
    NSString *msgID = [response.notification.request.content.userInfo valueForKey:@"msgId"] ;
    
    EDSBeingPushedViewController *vc = [[EDSBeingPushedViewController alloc] init];
    vc.msgID = msgID;
    [[self currentViewController].navigationController pushViewController:vc animated:YES];
    
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

//
//  AppDelegate+JSJCategory.m
//  JianShiJia
//
//  Created by 班文政 on 2018/1/23.
//  Copyright © 2018年 BanWenZheng. All rights reserved.
//

#import "AppDelegate+JSJCategory.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation AppDelegate (JSJCategory)

#pragma mark - *******************************  检测网络状况  *******************************
- (void)monitorNetWork{
    //电池条显示网络活动
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    //检测网络状态
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case 1:
            case 2:
                [EDSToolClass NoNetWorkingView:ONLINE];
                break;
                //            case 0:
            default:
                [EDSToolClass NoNetWorkingView:OUTLINE];
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end

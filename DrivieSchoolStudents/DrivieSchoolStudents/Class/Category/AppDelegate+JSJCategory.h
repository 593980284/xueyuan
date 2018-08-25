//
//  AppDelegate+JSJCategory.h
//  JianShiJia
//
//  Created by 班文政 on 2018/1/23.
//  Copyright © 2018年 BanWenZheng. All rights reserved.
//

#import "AppDelegate.h"
typedef NS_ENUM(NSInteger, NETSTATE) {
    ONLINE,//有网
    OUTLINE,//没网
};
@interface AppDelegate (JSJCategory)

-(void)monitorNetWork;
@end

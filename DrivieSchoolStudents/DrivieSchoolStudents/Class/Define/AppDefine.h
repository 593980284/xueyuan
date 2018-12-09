
//
//  AppDefine.h
//  自定义TabBar
//
//  Created by 小伴 on 16/7/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//
//  PS: App 项目用到的参数定义 -> URL 的入参、通知名字、SDK 的 AppKey 等

#ifndef AppDefine_h
#define AppDefine_h

//#ifdef __OBJC__
//    #import <Foundation/Foundation.h> //下面要是用到 Foundation 库就要包括
//#endif

//域名           //域名
#ifdef DEBUG //处于开发测试阶段

#define LINEURL @"http://111.39.245.156:8087"

#else //处于发布正式阶段

#define LINEURL @"http://112.2.0.75:9001"

#endif

#define kZSNotificationHomeBtnCenter                  @"kZSNotificationHomeBtnCenter"
#define KuserDefaultsLocation                         @"KuserDefaultsLocation"//本地位置
#define kXGNotfificationPushVC                        @"kXGNotfificationPushVC"//信鸽推送跳转页面
#define  HC_windowWidth    [UIScreen mainScreen].bounds.size.width
#define  HC_750Ratio       HC_windowWidth / 750.0

#endif /* AppDefine_h */

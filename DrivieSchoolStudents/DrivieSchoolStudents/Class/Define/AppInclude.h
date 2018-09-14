//
//  AppInclude.h
//  自定义TabBar
//
//  Created by 小伴 on 2016/11/21.
//  Copyright © 2016年 huangqimeng. All rights reserved.
//
//  PS:包含 APP 用到的分类、三方库、SDK 等
//  #import "APP 用到的分类、三方库、SDK 等"


#ifndef AppInclude_h
#define AppInclude_h

#ifdef __OBJC__

#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
/* 改变系统的target+selector模式为 block模式。 带来紧凑的代码风格，高效率的回调执行 */
#import "BlocksKit.h"
#import "BlocksKit+MessageUI.h"
#import "BlocksKit+UIKit.h"
#import "Masonry.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "SDCycleScrollView.h"
#import "MJExtension.h"

#import "EDSAccount.h"
#import "EDSSave.h"
#import "EDSToolClass.h"
#import "EDSRefreshFooter.h"
#import "EDSRefreshHeader.h"

#import "UIBarButtonItem+BHYCategory.h"
#import "AppDelegate+JSJCategory.h"
#import "NSString+JSJHash.h"
#import "UILabel+BHYCustom.h"
#import "UIImageView+BHYCustom.h"
#import "UIView+WZExtension.h"
#import "NSString+JSJTextSize.h"
#import "UIView+BHYCore.h"
#import "CALayer+BHYXibBorderColor.h"
#import "UILabel+ChangeLineSpaceAndWordSpace.h"

/**
 #查询风采# http://111.39.245.156:8087/lexiang/dist/index.html?id=4000001 需要ID字段
 #学习#http://111.39.245.156:8087/lexiang/dist/index.html#/study
 #学习流程#http://111.39.245.156:8087/lexiang/dist/index.html#/studyFlow
 #报名流程#http://111.39.245.156:8087/lexiang/dist/index.html#/signUp
 #价格公示#http://111.39.245.156:8087/lexiang/dist/index.html#/priceShowindex.html?id=4000001&className&carType  需要ID className(可为空) carTpye（可为空）
 */
#endif

#endif /* AppInclude_h */

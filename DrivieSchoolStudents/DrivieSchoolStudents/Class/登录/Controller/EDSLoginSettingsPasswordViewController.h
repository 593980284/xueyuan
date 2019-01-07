//
//  EDSLoginSettingsPasswordViewController.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/25.
//  Copyright © 2018 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BHYBaseViewController.h"
typedef NS_ENUM(NSInteger, LoginSetType) {
    LoginSetTypeRegister = 0,//注册
    LoginSetTypeBindPhone,//QQ、微信登录绑定手机号
    LoginSetTypeSet, //游客验证码登录，没设置密码
};

@interface EDSLoginSettingsPasswordViewController : BHYBaseViewController

@property (nonatomic , copy) NSString *phone;
@property(nonatomic, assign)LoginSetType setType;
@property(nonatomic, copy)NSString *code;
@end


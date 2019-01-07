//
//  RegisterViewController.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/5.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "BHYBaseViewController.h"

@interface RegisterViewController : BHYBaseViewController
@property(nonatomic, assign)BOOL isBindPhone;
@property(nonatomic, copy)NSString *type;
@property(nonatomic, copy)NSString *openId;
@property(nonatomic, strong)NSDictionary *data;
@end

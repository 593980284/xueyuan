//
//  EDSStudentMsgModel.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSStudentMsgModel : NSObject

@property (nonatomic , copy) NSString              * content;//消息发布内容
@property (nonatomic , copy) NSString              * msgId;//消息id主键
@property (nonatomic , copy) NSString              * msgType;//0 投诉信息 1 改进意见 2 驾校发布消息 3 教学提醒消息 4 签到提醒 5 停课提醒
@property (nonatomic , copy) NSString              * date;//消息发布时间

@property (nonatomic,assign) CGFloat cellHeight;

@end

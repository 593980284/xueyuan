//
//  EDSStudentMsgDetailModel.h
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDSStudentMsgDetailModel : NSObject

@property (nonatomic , copy) NSString *problemTitle;//问题标题
@property (nonatomic , copy) NSString *problemContent;//问题内容
@property (nonatomic , copy) NSString *problemTime;//问题时间

@property (nonatomic , copy) NSString *answerTitle;//回答标题
@property (nonatomic , copy) NSString *answerContent;//回答内容
@property (nonatomic , copy) NSString *answerTime;//回答时间
@property (nonatomic , copy) NSString *msdType; //类型
@property (nonatomic , copy) NSString *appointmentId;
@property (nonatomic , copy) NSString *studentId; 


@end

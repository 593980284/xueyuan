//
//  EDSUploadStudentImgRequest.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/6.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "HQMBaseRequest.h"

@interface EDSUploadStudentImgRequest : HQMBaseRequest

@property (nonatomic, copy) NSString *phone;//学员手机号
@property (nonatomic, copy) NSString *imageCode;//图片数据（格式为base64）

@end

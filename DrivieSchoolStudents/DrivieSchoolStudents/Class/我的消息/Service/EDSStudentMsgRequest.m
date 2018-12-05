//
//  EDSStudentMsgRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/10.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentMsgRequest.h"
#import "EDSStudentMsgModel.h"

@implementation EDSStudentMsgRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/message/findStudentMsg";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             @"type":_type,
             @"page": [NSString stringWithFormat:@"%ld",_page],
             @"rows": @"10",
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray <EDSStudentMsgModel *>*model = [EDSStudentMsgModel mj_objectArrayWithKeyValuesArray:data];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, model);
    }
}

@end

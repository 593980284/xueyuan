//
//  LunRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/10.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "LunRequest.h"

@implementation LunRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/forum/getStudentForumToken";
}

- (NSDictionary *)requestArguments
{
    return @{};
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

//"list": [
//         {
//             "shuttleBusName": "开往幸福的列车",
//             "id": 10,
//             "startPlace": "东京站",
//             "startTime": "18:02",
//             "endPlace": "东京站",
//             "endTime": "18:02"
//         },

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        self.successBlock(resCode, data, data);
    }
}

@end

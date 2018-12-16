//
//  CarRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "CarRequest.h"

@implementation CarRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/shuttleBus/getShuttleBusList";
}

- (NSDictionary *)requestArguments
{
    return @{@"schoolId": [NSString stringWithFormat:@"%@",self.schoolId],
             @"rows": [NSString stringWithFormat:@"%ld",self.rows],
             @"page": [NSString stringWithFormat:@"%ld",self.page],
             };
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
    NSArray * arr = data[@"list"];
    if (arr == nil) {
        arr = @[];
    }
    if (self.successBlock) {
        self.successBlock(resCode, data, arr);
    }
}


@end

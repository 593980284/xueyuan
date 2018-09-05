//
//  EDSSchoolListRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/5.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSchoolListRequest.h"
#import "EDSSchoolListModel.h"

@implementation EDSSchoolListRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/presignup/findSchoolList";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"order":_order,
             @"schoolName":_schoolName,
             @"lng":_lng,
             @"lat":_lat,
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray <EDSSchoolListModel *> *lists = [EDSSchoolListModel mj_objectArrayWithKeyValuesArray:data];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, lists);
    }
}

@end

//
//  EDSSchoolRegionRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSchoolRegionRequest.h"

#import "EDSSchoolRegionModel.h"


@implementation EDSSchoolRegionRequest


- (NSString *)requestURLPath
{
    return @"/app/lexiang/school/findSchoolRegion";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"schoolId":_schoolId,
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray <EDSSchoolRegionModel *>*model = [EDSSchoolRegionModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"list"]];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, model);
    }
}

@end

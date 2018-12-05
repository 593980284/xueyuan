//
//  EDSFindSchoolInformationRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFindSchoolInformationRequest.h"
#import "EDSSchoolInformationDetailModel.h"

@implementation EDSFindSchoolInformationRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/school/findSchoolInformation";
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
    EDSSchoolInformationDetailModel *model = [EDSSchoolInformationDetailModel mj_objectWithKeyValues:[data valueForKey:@"list"][0]];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, model);
    }
}
@end


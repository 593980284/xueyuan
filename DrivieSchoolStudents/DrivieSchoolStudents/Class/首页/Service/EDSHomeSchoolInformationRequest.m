//
//  EDSHomeSchoolInformationRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHomeSchoolInformationRequest.h"
#import "EDSDrivingSchoolModel.h"

@implementation EDSHomeSchoolInformationRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/homePage/homeSchoolInformation";
}

- (NSDictionary *)requestArguments
{
    return @{@"schoolId":_schoolId};
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray<EDSDrivingSchoolModel *> *arr = [EDSDrivingSchoolModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"list"]];
    if (self.successBlock) {
        self.successBlock(resCode, data, arr);
    }
}
@end

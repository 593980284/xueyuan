//
//  EDSSchoolStyleRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSchoolStyleRequest.h"

#import "EDSSchoolStyleModel.h"

@implementation EDSSchoolStyleRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/school/findSchoolStyle";
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
    NSArray <EDSSchoolStyleModel *>*list = [EDSSchoolStyleModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"list"]];
    
    if (self.successBlock) {
        
        self.successBlock(resCode, data, list);
    }
}
@end


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
             @"phone":_phone,
             @"rows": [NSString stringWithFormat:@"%ld",self.rows == 0? 10 : self.rows],
             @"page": [NSString stringWithFormat:@"%ld", _page]
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


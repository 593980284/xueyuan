//
//  EDSStudentCourseRecordRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/13.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStudentCourseRecordRequest.h"

#import "EDSCourseRecordModel.h"

@implementation EDSStudentCourseRecordRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/findStudentCourseRecord";
}

- (NSDictionary *)requestArguments
{
    return @{@"phone":[EDSSave account].phone,
             @"page": [NSString stringWithFormat:@"%ld", _myPage],
             @"rows": @"10"
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray <EDSCourseRecordModel *>*clist = [EDSCourseRecordModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"clist"]];
    NSArray <EDSCourseRecordModel *>*ulist = [EDSCourseRecordModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"ulist"]];
    
    NSArray *model = @[@[],@[]];
    
    if (clist.count > 0) {
        model = @[clist,@[]];
    }
    
    if (ulist.count > 0) {
        
        model = @[@[],ulist];
    }
    
    if (clist.count > 0 && ulist.count > 0) {
        model = @[clist,ulist];
    }
    
    if (self.successBlock) {
        
        self.successBlock(resCode, data, model);
    }
}

@end

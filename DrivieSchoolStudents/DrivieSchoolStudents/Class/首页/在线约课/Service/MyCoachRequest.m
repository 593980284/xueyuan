//
//  MyCoachRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/2.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "MyCoachRequest.h"
#import "CoachModel.h"
@implementation MyCoachRequest
- (NSString *)requestURLPath
{
    return @"/app/lexiang/coachChangeApply/findMyCoach";
}

- (NSDictionary *)requestArguments
{
//    return @{
//             @"phone":_phone,
//             };
    return [self mj_keyValues];
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray<CoachModel *> *list = [CoachModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"list"]];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, list);
    }
}
@end

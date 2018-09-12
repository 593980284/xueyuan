//
//  EDSOnlineClassListByDateRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineClassListByDateRequest.h"
#import "EDSOnlineClassListByDateModel.h"


@implementation EDSOnlineClassListByDateRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/findOnlineClassListByDate";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"phone":_phone,
             @"date":_date,
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray<EDSOnlineClassListByDateModel *> *list1 = [EDSOnlineClassListByDateModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"list_1"]];
    NSArray<EDSOnlineClassListByDateModel *> *list2 = [EDSOnlineClassListByDateModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"list_2"]];
    NSArray<EDSOnlineClassListByDateModel *> *list3 = [EDSOnlineClassListByDateModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"list_3"]];
    NSArray *model = [NSArray arrayWithObjects:list1,list2, list3, nil];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, model);
    }
}
@end

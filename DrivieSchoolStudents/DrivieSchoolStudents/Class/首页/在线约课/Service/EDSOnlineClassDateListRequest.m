//
//  EDSOnlineClassDateListRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineClassDateListRequest.h"
#import "EDSOnlineClassDateListModel.h"

@implementation EDSOnlineClassDateListRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/course/findOnlineClassDateList";
}

- (NSDictionary *)requestArguments
{
   return [self mj_keyValues];;
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray <EDSOnlineClassDateListModel *> *model = [EDSOnlineClassDateListModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"list"]];
    if (self.successBlock) {
        
        self.successBlock(resCode, data, model);
    }
}

@end

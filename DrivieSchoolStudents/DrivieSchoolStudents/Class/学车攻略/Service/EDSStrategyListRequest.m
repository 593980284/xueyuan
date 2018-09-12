//
//  EDSStrategyListRequest.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStrategyListRequest.h"

#import "EDSStrategyListModel.h"

@implementation EDSStrategyListRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/strategy/findStrategyList";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"rows":NumPerPage,
             @"page":_page,
             @"strategyType":_strategyType,
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray<EDSStrategyListModel *> *arr = [EDSStrategyListModel mj_objectArrayWithKeyValuesArray:[data valueForKey:@"list"]];
    
    if (self.successBlock) {
        
        self.successBlock(resCode, data, arr);
    }
}
@end

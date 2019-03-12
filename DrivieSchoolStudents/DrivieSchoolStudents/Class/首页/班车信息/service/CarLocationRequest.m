//
//  CarLocationRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2019/3/9.
//  Copyright © 2019年 班文政. All rights reserved.
//

#import "CarLocationRequest.h"
@implementation CarLocationModel
@end
@implementation CarLocationRequest
- (NSString *)requestURLPath
{
    return @"/app/lexiang/shuttleBus/getShuttleBusLocation";
}

- (NSDictionary *)requestArguments
{
    return @{
             @"busId":self.busId,
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
    
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSMutableArray<CarLocationModel *>*model = [NSMutableArray new];
    if (data[@"list"]) {
        NSArray * list = data[@"list"];
        model =  [CarLocationModel mj_objectArrayWithKeyValuesArray:list];
        
      
    }
    if (self.successBlock) {
        self.successBlock(resCode, data, model);
    }
}
@end

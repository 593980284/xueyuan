//
//  EDSBusInfoRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/23.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSBusInfoRequest.h"
#import "EDSBusInfoModel.h"

@implementation EDSBusInfoRequest

- (NSString *)requestURLPath
{
    if (self.busInfoType == 0) {
        return @"/app/lexiang/shuttleBus/getShuttleBusDetail";
    }else{
        return @"/app/lexiang/shuttleBus/getShuttleBusReturenDetail";
    }
    
}

- (NSDictionary *)requestArguments
{
    return @{
             @"id":_busInfoId,
            };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
    
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray <EDSBusInfoModel *>*model = [EDSBusInfoModel mj_objectArrayWithKeyValuesArray:data];
    if (self.successBlock) {
        self.successBlock(resCode, data, model);
    }
}
@end

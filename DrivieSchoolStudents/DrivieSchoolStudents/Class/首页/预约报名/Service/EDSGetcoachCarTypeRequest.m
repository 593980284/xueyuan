//
//  EDSGetcoachCarTypeRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSGetcoachCarTypeRequest.h"

#import "EDSGetcoachCarTypeModel.h"

@implementation EDSGetcoachCarTypeRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/presignup/getcoachCarType";
}

- (NSDictionary *)requestArguments
{
    return @{};
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    NSArray *list = [EDSGetcoachCarTypeModel mj_objectArrayWithKeyValuesArray:data];
    
    if (self.successBlock) {
        
        self.successBlock(resCode, data, list);
    }
}
@end

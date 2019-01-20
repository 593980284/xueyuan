//
//  EDSAppTouristRegistRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSAppTouristRegistRequest.h"

@implementation EDSAppTouristRegistRequest

- (NSString *)requestURLPath
{
    if (self.requestTypeNotBindQQ_Wx) {
        return @"/app/lexiang/login/appCancelBindThird";
    }
    if (self.requestTypeBindQQ_Wx) {
        return @"/app/lexiang/login/appBindThirdStudent";
    }
    return @"/app/lexiang/login/appTouristRegist";
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (NSDictionary *)requestArguments
{
    NSMutableDictionary *dic = [[self mj_keyValues] mutableCopy];
    if(!dic[@"code"]){
        [dic setValue:@"" forKey:@"code"];
    };
    [dic removeObjectForKey:@"showHUD"];
    [dic removeObjectForKey:@"failureBlock"];
    [dic removeObjectForKey:@"successBlock"];
    [dic removeObjectForKey:@"requestTypeBindQQ_Wx"];
    [dic removeObjectForKey:@"requestTypeNotBindQQ_Wx"];
    return dic;
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
    }
}
@end

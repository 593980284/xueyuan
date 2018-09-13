//
//  EDSUploadStudentImgRequest.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/6.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSUploadStudentImgRequest.h"

@implementation EDSUploadStudentImgRequest

- (NSDictionary *)requestArguments
{
    return @{@"imageCode":_imageCode,
             @"phone":_phone,
             };
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

- (NSString *)requestURLPath
{
    return @"/app/lexiang/studentSetting/uploadStudentImage";
}

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    EDSAccount *account = [EDSSave account];
    account.photo = [LINEURL stringByAppendingPathComponent:[data valueForKey:@"picUrl"]];
    [EDSSave save:account];
    
    if (self.successBlock) {
        
        self.successBlock(resCode, data, nil);
    }
}
@end

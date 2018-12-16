//
//  ZanRequest.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/16.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "ZanRequest.h"

@implementation ZanRequest

- (NSString *)requestURLPath
{
    return @"/app/lexiang/school/updateSchoolStyle";
}

- (NSDictionary *)requestArguments
{
    return [self mj_keyValues];
}

- (HQMRequestMethod)requestMethod
{
    return HQMRequestMethodPOST;
}

//"styleName" : "xxx",
//"styleContent" : "xxx",
//"stylePhoto" : "xxx",
//"styleVideo" : "xxx",
//"clickCount" : "xxx",
//"likeCount" : "xxx",
//"creatTime" : "xxx",
//"isLike"："xxx"

- (void)handleData:(id)data errCode:(NSInteger)resCode
{
    if (self.successBlock) {
        self.successBlock(resCode, data, data);
    }
}

@end

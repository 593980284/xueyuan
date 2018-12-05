//
//  EDSSchoolStyleModel.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSchoolStyleModel.h"

@implementation EDSSchoolStyleModel

- (NSString *)showStylePhoto
{
    return [LINEURL stringByAppendingPathComponent:_titleCover];
}

@end

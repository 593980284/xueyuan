//
//  EDSSchoolInformationDetailModel.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSchoolInformationDetailModel.h"

@implementation EDSSchoolInformationDetailModel

- (NSString *)showSchoolPhoto
{
    return [LINEURL stringByAppendingPathComponent:_schoolPhoto];
}

- (NSString *)showSchoolPrice
{
    return _schoolPrice.length > 0 ? [NSString stringWithFormat:@"￥%@",_schoolPrice] : @"";
}

- (NSString  *)showStarScore
{
    return [NSString stringWithFormat:@"%@分",_starScore];
}

- (NSInteger)showStarScoreInterger
{
    return ceil([_starScore doubleValue] / 2);
}
- (double)lat
{
    NSArray *arr = [_lngLat componentsSeparatedByString:@","];
    return [arr[1] doubleValue];
}


- (double)lng
{
    NSArray *arr = [_lngLat componentsSeparatedByString:@","];
    return [arr[0] doubleValue];
}

@end

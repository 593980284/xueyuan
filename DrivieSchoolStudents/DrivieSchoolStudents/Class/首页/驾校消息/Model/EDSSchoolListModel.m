//
//  EDSSchoolListModel.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/5.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSchoolListModel.h"

@implementation EDSSchoolListModel

- (NSString *)appPhoto
{
    return [LINEURL stringByAppendingPathComponent:_appPhoto];
}

- (NSString *)showDistance
{
    double dist = [_distance doubleValue];
    dist = dist / 1000.0;
    return [NSString stringWithFormat:@"%.0fkm",dist];
}

- (NSAttributedString *)showCartyoePrice
{
    
    NSString *string = _carTypePrice.length > 0 ? @"￥" : @" ";
    _showCartyoePrice = [NSString attributedStringWithColorTitle:_carTypePrice normalTitle:@"" frontTitle:string normalColor:[EDSToolClass getColorWithHexString:@"#FF571D"] diffentColor:[EDSToolClass getColorWithHexString:@"#FF571D"] normalFont:kFont(14) differentFont:kFont(18)];
    return _showCartyoePrice;
}

- (NSInteger)showScore
{
    return ceil([_starScore integerValue]);
}

@end

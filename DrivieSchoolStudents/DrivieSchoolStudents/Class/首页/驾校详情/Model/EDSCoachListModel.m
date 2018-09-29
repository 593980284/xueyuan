//
//  EDSCoachListModel.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCoachListModel.h"

@implementation EDSCoachListModel

- (NSInteger)showCoachStarInterger
{
    return ceil([_coachStar doubleValue] / 2);
}

- (NSString *)showCoachPhoto
{
    return [LINEURL stringByAppendingPathComponent:_coachPhoto];
}

- (NSArray *)showTagArr
{
    return _coachLabel.length > 0 ? [_coachLabel componentsSeparatedByString:@","] : @[];
}

- (NSString *)showCoachDescrp
{
    return [NSString stringWithFormat:@"%@年教练 · %@",_teachAge,_teachType];
}

- (NSString *)coachStar
{
    return [NSString stringWithFormat:@"%.1f",[_coachStar floatValue]];
}

@end

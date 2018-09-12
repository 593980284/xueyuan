//
//  EDSStrategyListModel.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSStrategyListModel.h"

@implementation EDSStrategyListModel

- (NSString *)strategyPhoto
{
    return [LINEURL stringByAppendingPathComponent:_strategyPhoto];
}
@end

//
//  EDSRefreshFooter.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/12.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSRefreshFooter.h"

@implementation EDSRefreshFooter

- (void)prepare
{
    [super prepare];
    // 不要自动刷新
    //self.automaticallyRefresh = YES;
    self.automaticallyChangeAlpha = YES;
}

@end

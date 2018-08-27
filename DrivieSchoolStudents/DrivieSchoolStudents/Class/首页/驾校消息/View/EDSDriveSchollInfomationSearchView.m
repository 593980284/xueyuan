//
//  EDSDriveSchollInfomationSearchView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDriveSchollInfomationSearchView.h"

@implementation EDSDriveSchollInfomationSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSDriveSchollInfomationSearchView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSDriveSchollInfomationSearchView" owner:self options:nil] lastObject];
    }
    return self;
}

- (void)setup{
    
}
@end

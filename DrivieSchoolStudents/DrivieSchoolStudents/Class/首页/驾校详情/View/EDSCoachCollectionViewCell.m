//
//  EDSCoachCollectionViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCoachCollectionViewCell.h"
#import "EDSDriveStarView.h"

@interface EDSCoachCollectionViewCell ()

@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView;

@end

@implementation EDSCoachCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.driveStarView.selectNumber = 2;
}


@end

//
//  BaoMingTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "BaoMingTableViewCell.h"

@implementation BaoMingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRegionModel:(EDSSchoolRegionModel *)regionModel
{
    _regionModel = regionModel;
    
    self.addressLb.text = [NSString stringWithFormat:@"%@",regionModel.pointAddress];
    self.nameLb.text = [NSString stringWithFormat:@"%@",regionModel.pointName];
    self.telLb.text = regionModel.pointPhone;
    self.distanceLb.text = regionModel.distance;
}

@end

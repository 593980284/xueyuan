//
//  EDSCheckSiteTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCheckSiteTableViewCell.h"

#import "EDSSchoolRegionModel.h"

@interface EDSCheckSiteTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *distanceLb;



@end

@implementation EDSCheckSiteTableViewCell

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
    
    self.addressLb.text = [NSString stringWithFormat:@"%@",regionModel.address];
    self.nameLb.text = [NSString stringWithFormat:@"%@",regionModel.name];
    self.distanceLb.text = regionModel.distance;
}

@end

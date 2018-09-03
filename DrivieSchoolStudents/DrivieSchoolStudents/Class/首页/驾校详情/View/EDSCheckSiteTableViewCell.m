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

@property (weak, nonatomic) IBOutlet UILabel *checkSiteAddress;
@property (weak, nonatomic) IBOutlet UILabel *checkSiteName;


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
    
    self.checkSiteAddress.text = regionModel.address;
    self.checkSiteName.text = regionModel.name;
}

@end

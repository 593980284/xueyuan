//
//  EDSHomeTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHomeTableViewCell.h"
#import "EDSDriveStarView.h"

#import "EDSDrivingSchoolModel.h"

@interface EDSHomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *driveImgView;
@property (weak, nonatomic) IBOutlet UILabel *driveNameLbl;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLbl;
@property (weak, nonatomic) IBOutlet UILabel *drivePriceLbl;

@end

@implementation EDSHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setCellArr:(NSArray *)cellArr{
    _cellArr = cellArr;
    
    [self.driveImgView sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=c4b4d6dff01f4134ff37037e151e95c1/c995d143ad4bd113115afc0e57afa40f4bfb0572.jpg"] placeholderImage:PLACEHOLDERGOODSIMAGE];
    
    self.driveStarView.selectNumber = 2;
}

- (void)setModel:(EDSDrivingSchoolModel *)model
{
    _model = model;
    
    [self.driveImgView sd_setImageWithURL:[NSURL URLWithString:model.schoolPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    self.driveStarView.selectNumber = 1;
    self.driveNameLbl.text = model.schoolName;
    self.distanceLbl.text = model.distance;
    self.drivePriceLbl.attributedText = model.showSchoolPrice;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

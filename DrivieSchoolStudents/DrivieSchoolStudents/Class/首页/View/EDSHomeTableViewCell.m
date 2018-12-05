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
#import "EDSSchoolListModel.h"

@interface EDSHomeTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *driveImgView;
@property (weak, nonatomic) IBOutlet UILabel *driveNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *levLb;

@property (weak, nonatomic) IBOutlet UILabel *drivePriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *driveAddress;

@property (weak, nonatomic) IBOutlet UILabel *driveScoreLbl;
@property (weak, nonatomic) IBOutlet UILabel *AALB;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end

@implementation EDSHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _logoImageView.hidden = YES;
}

- (void)setCellArr:(NSArray *)cellArr{
    _cellArr = cellArr;
    
    [self.driveImgView sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.baidu.com/9fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=c4b4d6dff01f4134ff37037e151e95c1/c995d143ad4bd113115afc0e57afa40f4bfb0572.jpg"] placeholderImage:PLACEHOLDERGOODSIMAGE];
    
//    self.driveStarView.selectNumber = 2;
}

- (void)setSchoolListModel:(EDSSchoolListModel *)schoolListModel
{
    _schoolListModel = schoolListModel;
    [self.driveImgView sd_setImageWithURL:[NSURL URLWithString:schoolListModel.appPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
//    self.driveStarView.selectNumber = schoolListModel.showScore;
    self.driveNameLbl.text = schoolListModel.schoolName;
//    self.distanceLbl.text = schoolListModel.showDistance;
    self.drivePriceLbl.text = schoolListModel.showDistance;
    self.driveAddress.text = schoolListModel.address;
    self.levLb.text = [NSString stringWithFormat:@"信誉等级："];
    NSString * a = @"";
    for(int i =0; i<schoolListModel.reputationLevel; i ++){
        a = [NSString stringWithFormat:@"%@A", a];
    }
    self.AALB.text = a;
//    self.driveScoreLbl.text = [NSString stringWithFormat:@"%.1f分",[schoolListModel.starScore floatValue]];
}

- (void)setModel:(EDSDrivingSchoolModel *)model
{
    _model = model;
    _logoImageView.hidden = model.isUnion == 1 ? NO : YES;
    [self.driveImgView sd_setImageWithURL:[NSURL URLWithString:model.schoolPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
////    self.driveStarView.selectNumber = model.showScore;
   self.driveNameLbl.text = model.schoolName;
////    self.distanceLbl.text = model.distance;
    self.drivePriceLbl.text = model.distance;
    self.driveAddress.text = model.address;
    self.levLb.text = [NSString stringWithFormat:@"信誉等级："];
    NSString * a = @"";
    for(int i =0; i<model.reputationLevel; i ++){
        a = [NSString stringWithFormat:@"%@A", a];
    }
    self.AALB.text = a;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

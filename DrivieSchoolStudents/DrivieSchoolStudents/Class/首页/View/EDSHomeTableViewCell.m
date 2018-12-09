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

@property (weak, nonatomic) IBOutlet UILabel *drivePriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *driveAddress;

@property (weak, nonatomic) IBOutlet UILabel *driveScoreLbl;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIView *baView;
@property (weak, nonatomic) IBOutlet UIImageView *a1;
@property (weak, nonatomic) IBOutlet UIImageView *a5;
@property (weak, nonatomic) IBOutlet UIImageView *a4;
@property (weak, nonatomic) IBOutlet UIImageView *a3;
@property (weak, nonatomic) IBOutlet UIImageView *a2;

@end

@implementation EDSHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _logoImageView.hidden = YES;
    _baView.layer.cornerRadius = 4;
    _baView.layer.borderWidth = 1;
    _baView.layer.borderColor = ThirdColor.CGColor;
    _baView.layer.shadowColor =  [EDSToolClass getColorWithHexString:@"aaaaaa"]  .CGColor;
    _baView.layer.shadowOpacity = 0.5;
    _baView.layer.shadowOffset = CGSizeMake(-3, 3);
   
    
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
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:schoolListModel.showDistance attributes:@{NSForegroundColorAttributeName: [UIColor blueColor], NSFontAttributeName: [UIFont boldSystemFontOfSize:12]}];
    [str setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} range:NSMakeRange(str.length-2, 2)];
    self.drivePriceLbl.attributedText = str;
    self.driveAddress.text = [NSString stringWithFormat:@"地址：%@ ",schoolListModel.address];
    NSArray<UIImageView *> *as = @[_a1, _a2,_a3 , _a4,_a5];
    for (UIImageView *A in as) {
        A.hidden = YES;
    }
    for(int i =0; i<schoolListModel.reputationLevel; i ++){
        as[i].hidden = NO;
    }
}

- (void)setModel:(EDSDrivingSchoolModel *)model
{
    _model = model;
    _logoImageView.hidden = model.isUnion == 1 ? NO : YES;
    [self.driveImgView sd_setImageWithURL:[NSURL URLWithString:model.schoolPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
////    self.driveStarView.selectNumber = model.showScore;
   self.driveNameLbl.text = model.schoolName;
////    self.distanceLbl.text = model.distance;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:model.distance attributes:@{NSForegroundColorAttributeName: [EDSToolClass getColorWithHexString:@"4498ff"] , NSFontAttributeName: [UIFont boldSystemFontOfSize:14]}];
    [str setAttributes:@{NSForegroundColorAttributeName: [EDSToolClass getColorWithHexString:@"4498ff"] ,NSFontAttributeName: [UIFont systemFontOfSize:12]} range:NSMakeRange(str.length-2, 2)];
    self.drivePriceLbl.attributedText = str;
    self.driveAddress.text = [NSString stringWithFormat:@"地址：%@ ",model.address];
    NSArray<UIImageView *> *as = @[_a1, _a2,_a3 , _a4,_a5];
    for (UIImageView *A in as) {
        A.hidden = YES;
    }
    for(int i =0; i<model.reputationLevel; i ++){
        as[i].hidden = NO;
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

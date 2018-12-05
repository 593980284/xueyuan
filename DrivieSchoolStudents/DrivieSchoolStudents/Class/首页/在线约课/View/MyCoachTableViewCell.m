//
//  MyCoachTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/2.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "MyCoachTableViewCell.h"

@implementation MyCoachTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)callBtnTap:(id)sender {
   self.callBlock(_model);
}
- (IBAction)changeApply:(id)sender {
    self.changeApplyBlock(_model);
}

- (void)setModel:(CoachModel *)model{
    _model = model;
    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:model.coachPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    _nameLb.text = model.CoachName;
    _sexLb.text = model.coachSex % 2 == 0 ? @"女": @"男";
    _starView.selectNumber = model.coachStar;
    if (model.name && model.teachAge) {
          _detailLb.text = [NSString stringWithFormat:@"%@年教龄 %@  ", model.teachAge, model.name];
    }else{
        _detailLb.text = @"";
    }
    
    NSArray *logos = [model.identity componentsSeparatedByString:@","];
    _image1.hidden = ![logos containsObject:@"131000"];
    _image2.hidden = ![logos containsObject:@"132000"];
    _applyBtn.hidden = !model.isBind;
    
}

@end

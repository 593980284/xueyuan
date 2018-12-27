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
    self.contentView.backgroundColor = [UIColor clearColor];
    // Initialization code
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    view.hcShadowBlock([EDSToolClass getColorWithHexString:@"aaaaaa"], 0.5, -3, 3)
    .hcCornerRadiusBlock(3, NO)
    .hcBorderBlock([EDSToolClass getColorWithHexString:@"aaaaaa"], 0.5);
    [self.contentView insertSubview:view atIndex:0];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(7.5);
        make.bottom.mas_equalTo(5);
        make.right.mas_equalTo(-7.5);
    }];
    _starView = [[LEEStarRating alloc]initWithFrame:CGRectMake(0, 0, 80, 1) Count:5];
    _starView.maximumScore = 5;
    _starView.type = RatingTypeHalf;
    _starView.checkedImage = [UIImage imageNamed:@"star_content_icon_selected"];
    _starView.uncheckedImage = [UIImage imageNamed:@"star_content_icon_default"];
    
    [self.contentView addSubview:_starView];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(8);
        make.width.mas_equalTo(110);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-17.5);
    }];
    
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
    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LINEURL, model.coachPhoto]] placeholderImage:PLACEHOLDERGOODSIMAGE];
    _nameLb.text = model.CoachName;
    _starView.currentScore = model.coachStar / 2.0;
    _sexImage.image = [UIImage imageNamed:model.coachSex % 2 == 0 ? @"ic-woman":@"ic-man"];
//    _sexLb.text = model.coachSex % 2 == 0 ? @"女": @"男";
    if (model.name && model.teachAge) {
          _detailLb.text = [NSString stringWithFormat:@"%@年教龄 %@  ", model.teachAge, model.name];
    }else{
        _detailLb.text = @"";
    }
    
    NSArray *logs = [model.identity componentsSeparatedByString:@","];
    BOOL isJ = [logs containsObject:@"131000"];
    BOOL isS = [logs containsObject:@"132000"];
    if (isJ && isS) {
        self.Image1.hidden = NO;
        self.Image1.image = [UIImage imageNamed:@"ic-金牌教练"];
        self.image2.hidden = NO;
        self.image2.image = [UIImage imageNamed:@"ic-十佳党员"];
    }else if(!isS && !isJ){
        self.Image1.hidden = YES;
        self.image2.hidden = YES;
    }else{
        self.Image1.hidden = NO;
        self.image2.hidden = YES;
        self.Image1.image = [UIImage imageNamed:isJ ? @"ic-金牌教练": @"ic-十佳党员"];
    }
//    _image1.hidden = ![logos containsObject:@"131000"];
//    _image2.hidden = ![logos containsObject:@"132000"];
    _applyBtn.hidden = !model.isBind;
    
}

@end

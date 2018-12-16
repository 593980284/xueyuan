//
//  CarTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "CarTableViewCell.h"

@implementation CarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *bgView = [UIView new];
        bgView.backgroundColor = WhiteColor;
        bgView.layer.borderWidth = 0.5;
        bgView.layer.borderColor =  [EDSToolClass getColorWithHexString:@"aaaaaa"].CGColor;
        bgView.layer.cornerRadius = 5;
        bgView.layer.shadowColor = [EDSToolClass getColorWithHexString:@"aaaaaa"].CGColor;
        bgView.layer.shadowOpacity = 0.5;
        bgView.layer.shadowOffset = CGSizeMake(-3, 3);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(30*HC_750Ratio);
            make.width.mas_equalTo(690*HC_750Ratio);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-20*HC_750Ratio);
        }];
        
        _titleLb = [UILabel new];
        _titleLb.font = [UIFont systemFontOfSize:15];
        _titleLb.textColor = FirstColor;
        
        _detailLb = [UILabel new];
        _detailLb.font = [UIFont systemFontOfSize:12];
        _detailLb.textColor = SecondColor;
        
        _startTimeLb = [UILabel new];
        _startTimeLb.font = [UIFont systemFontOfSize:12];
        _startTimeLb.textColor = SecondColor;
        
        _endTimeLb = [UILabel new];
        _endTimeLb.font = [UIFont systemFontOfSize:12];
        _endTimeLb.textColor = SecondColor;
        
        UIImageView * sImgView = [UIImageView new];
        sImgView.image = [UIImage imageNamed:@"首"];
        UIImageView * eImgView = [UIImageView new];
        eImgView.image = [UIImage imageNamed:@"末"];
        
         [bgView addSubview:_titleLb];
         [bgView addSubview:_detailLb];
         [bgView addSubview:_startTimeLb];
         [bgView addSubview:_endTimeLb];
         [bgView addSubview:sImgView];
         [bgView addSubview:eImgView];
        
        [_titleLb sizeToFit];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(20*HC_750Ratio);
            make.left.mas_equalTo(35*HC_750Ratio);
        }];
        
        [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLb.mas_right);
            make.centerY.mas_equalTo(self.titleLb.mas_centerY);
        }];
        
        [sImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(36*HC_750Ratio);
            make.bottom.mas_equalTo(bgView.mas_bottom).offset(-20*HC_750Ratio);
            make.left.mas_equalTo(30*HC_750Ratio);
        }];
        
        [_startTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(sImgView.mas_centerY);
            make.left.mas_equalTo(sImgView.mas_right).offset(20*HC_750Ratio);
            make.width.mas_equalTo(110*HC_750Ratio);
        }];
        
        [eImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(36*HC_750Ratio);
            make.centerY.mas_equalTo(sImgView.mas_centerY);
            make.left.mas_equalTo(self.startTimeLb.mas_right);
           
        }];
        
        [_endTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(sImgView.mas_centerY);
            make.left.mas_equalTo(eImgView.mas_right).offset(20*HC_750Ratio);
            make.width.mas_equalTo(110*HC_750Ratio);
        }];
    }
    return self;
}


-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
//    dic=@{
//          @"shuttleBusName": @"g国家车",
//          @"startPlace": @"A",
//          @"endPlace": @"B",
//          @"startTime": @"7:00",
//          @"endTime": @"7:00"
//          };
    _titleLb.text = dic[@"shuttleBusName"];
    _detailLb.text = [NSString stringWithFormat:@"（%@ -> %@）",dic[@"startPlace"],dic[@"endPlace"]];
    _startTimeLb.text = dic[@"startTime"];
    _endTimeLb.text = dic[@"endTime"];
}
@end

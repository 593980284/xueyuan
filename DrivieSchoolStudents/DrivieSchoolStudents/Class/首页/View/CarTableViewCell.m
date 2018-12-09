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
        bgView.layer.borderWidth = 0.5;
        bgView.layer.borderColor =  [EDSToolClass getColorWithHexString:@"aaaaaa"].CGColor;
        bgView.layer.cornerRadius = 5;
        bgView.layer.shadowColor = [EDSToolClass getColorWithHexString:@"aaaaaa"].CGColor;
        bgView.layer.shadowOpacity = 0.5;
        bgView.layer.shadowOffset = CGSizeMake(-3, 3);
    }
    return self;
}

-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    _titleLb.text = dic[@"shuttleBusName"];
    _detailLb.text = [NSString stringWithFormat:@"（%@ -> %@）",dic[@"startPlace"],dic[@"endPlace"]];
    _startTimeLb.text = dic[@"startTime"];
    _endTimeLb.text = dic[@"endTime"];
}
@end

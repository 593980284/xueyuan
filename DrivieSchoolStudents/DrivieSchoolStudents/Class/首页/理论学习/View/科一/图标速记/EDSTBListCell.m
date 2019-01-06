//
//  EDSTBListCell.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/29.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSTBListCell.h"

@implementation EDSTBListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)getCellWithId:(NSString *)cellID andTableView:(UITableView *)tableView{
    EDSTBListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EDSTBListCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
//-(void)setModel:(EDSTBPracticeModel *)model{
//    _model = model;
//
//    self.topTitleLabel.text = model.titleStr;
//    self.firstImagV.image = [UIImage imageNamed:model.firstImgUrl];
//
//}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
//    self.topTitleLabel
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

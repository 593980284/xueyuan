//
//  EDSZXPracticeCell.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/29.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSZXPracticeCell.h"

@implementation EDSZXPracticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)getCellWithId:(NSString *)cellID andTableView:(UITableView *)tableView{
    EDSZXPracticeCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EDSZXPracticeCell" owner:nil options:nil]lastObject];
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//第一个点击事件
- (IBAction)firstBtnClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(0);
    }
}
- (IBAction)secBtnClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(1);
    }
}
- (IBAction)thirdBtnClick:(id)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(2);
    }
}
- (IBAction)fourBtnClick:(UIButton *)sender {
    if (self.btnClickBlock) {
        self.btnClickBlock(3);
    }
}

@end

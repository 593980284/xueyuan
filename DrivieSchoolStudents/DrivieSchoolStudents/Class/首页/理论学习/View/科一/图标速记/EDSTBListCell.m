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


-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    self.topTitleLabel.text = dataDic[@"title"];
    self.firstImagV.image = [UIImage imageNamed:dataDic[@"arr"][0][@"icon"]];
    self.secImageV.image = [UIImage imageNamed:dataDic[@"arr"][1][@"icon"]];
    self.thirdImageV.image = [UIImage imageNamed:dataDic[@"arr"][2][@"icon"]];
    self.fourImageV.image = [UIImage imageNamed:dataDic[@"arr"][3][@"icon"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

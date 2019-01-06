//
//  EDSTBDetailListCell.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2019/1/2.
//  Copyright © 2019 班文政. All rights reserved.
//

#import "EDSTBDetailListCell.h"

@implementation EDSTBDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)getCellWithId:(NSString *)cellID andTableView:(UITableView *)tableView{
    EDSTBDetailListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EDSTBDetailListCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

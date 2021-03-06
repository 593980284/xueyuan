//
//  EDSMyTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMyTableViewCell.h"

@interface EDSMyTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *descripLbl;

@end

@implementation EDSMyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellArr:(NSArray *)cellArr
{
    _cellArr = cellArr;
    self.iconImgView.image = [UIImage imageNamed:cellArr[1]];
    self.titleLbl.text = cellArr[0];
    
    if ([cellArr[0] isEqualToString:@"刷新缓存"]) {
        
        self.descripLbl.text = [NSString stringWithFormat:@"%@",cellArr[2]];
    }
}
@end

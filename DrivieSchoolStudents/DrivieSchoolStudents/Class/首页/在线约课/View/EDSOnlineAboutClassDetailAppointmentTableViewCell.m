//
//  EDSOnlineAboutClassDetailAppointmentTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSOnlineAboutClassDetailAppointmentTableViewCell.h"

@interface EDSOnlineAboutClassDetailAppointmentTableViewCell ()

/** 图标 */
@property (nonatomic, strong) UIImageView  *iconImgView;
/** 详情 */
@property (nonatomic, strong) UILabel  *descripLbl;

@end

@implementation EDSOnlineAboutClassDetailAppointmentTableViewCell

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
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    _iconImgView = [UIImageView imageViewWithSuperView:self.contentView];
    _iconImgView.image = [UIImage imageNamed:@"zxykxq_content_like"];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    
    _descripLbl = [UILabel labelWithText:@"预约" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    [_descripLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(46);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-15);
    }];
}
@end

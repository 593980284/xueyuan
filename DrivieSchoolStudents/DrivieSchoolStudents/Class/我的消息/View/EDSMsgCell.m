//
//  EDSMsgCell.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/9.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSMsgCell.h"
@interface EDSMsgCell()
@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UIImageView *leftImageV;
@property (nonatomic,strong) UILabel *contentText;
@property (nonatomic,strong) UILabel *timeLable;

@end

@implementation EDSMsgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = TableColor;
        [self initView];
    }
    return self;
}
-(void)initView{
    [self.bgView addSubview:self.leftImageV];
    [self.bgView addSubview:self.contentText];
    [self.bgView addSubview:self.timeLable];
    
    [self.contentView addSubview:self.bgView];
    
}
-(UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(self.leftImageV.wz_right + 10, self.contentText.wz_bottom + 5, kScreenWidth - self.leftImageV.wz_right - 10 - 20, 20)];
        _timeLable.text = @"2018-89-90  84：222";
    }
    return _timeLable;
}
-(UILabel *)contentText{
    if (!_contentText) {
        _contentText = [[UILabel alloc]initWithFrame:CGRectMake(self.leftImageV.wz_right + 10, self.leftImageV.wz_y, kScreenWidth - self.leftImageV.wz_right - 10 - 20, 20)];
        _contentText.numberOfLines = 2;
        _contentText.font = [UIFont systemFontOfSize:24];
        _contentText.text = @"测试测试测试测试测试测试测试测试测试测试测试测试";
        
    }
    return _contentText;
}

-(UIImageView *)leftImageV{
    if (!_leftImageV) {
        _leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(18, 18, 50, 50)];
        _leftImageV.backgroundColor = [UIColor redColor];
    }
    return _leftImageV;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 80)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}



@end

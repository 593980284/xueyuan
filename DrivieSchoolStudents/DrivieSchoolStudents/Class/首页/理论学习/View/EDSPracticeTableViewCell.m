//
//  EDSPracticeTableViewCell.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPracticeTableViewCell.h"
#import "EDSQuestionModel.h"

@interface EDSPracticeTableViewCell ()
/** 选项 */
@property (nonatomic, strong) UILabel  *optionsLbl;
/** 选择 */
@property (nonatomic, strong) UIImageView  *chooesImgView;
/** 答案 */
@property (nonatomic, strong) UILabel  *answerLbl;

@end

@implementation EDSPracticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAnswerModel:(EDSAnswerModel *)answerModel
{
    _answerModel = answerModel;
    
    self.answerLbl.text = answerModel.answerTitle;
    self.optionsLbl.text = answerModel.answerR;
   
    
    if (answerModel.isChoose) {
        
        self.chooesImgView.image = [UIImage imageNamed:@"ct_content_option_wrong"];
        _chooesImgView.hidden = NO;
        _optionsLbl.hidden = YES;
    }else{
        
        _chooesImgView.hidden = YES;
        _optionsLbl.hidden = NO;
    }
    
    
    if (answerModel.isCorrect) {
        
        self.chooesImgView.image = [UIImage imageNamed:@"ct_content_option_correct"];
        self.chooesImgView.hidden = NO;
        self.optionsLbl.hidden = YES;
    }
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = WhiteColor;
        [self setup];
    }
    return self;
}

- (void)setup{
    
    _optionsLbl = [UILabel labelWithText:@"A" font:kFont(18) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    _optionsLbl.layer.cornerRadius = 27*0.5;
    _optionsLbl.layer.masksToBounds = YES;
    _optionsLbl.layer.borderColor = ThirdColor.CGColor;
    _optionsLbl.layer.borderWidth = 1;
    [_optionsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];
    _optionsLbl.textAlignment = NSTextAlignmentCenter;
    
    _answerLbl = [UILabel labelWithText:@"十二个月" font:kFont(18) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    [_answerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_optionsLbl.mas_right).mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
    }];
    
    _chooesImgView = [UIImageView imageViewWithSuperView:self.contentView];
    [_chooesImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];
    _chooesImgView.image = [UIImage imageNamed:@"ct_content_option_correct"];
    
}

@end

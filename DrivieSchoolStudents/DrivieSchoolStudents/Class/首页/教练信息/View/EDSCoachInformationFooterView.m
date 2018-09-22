//
//  EDSCoachInformationFooterView.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCoachInformationFooterView.h"
#import "EDSCoachListModel.h"

@interface EDSCoachInformationFooterView ()
@property (nonatomic , strong) UILabel *ageLbl;//教龄
@property (nonatomic , strong) UILabel *subjectsLbl;//科目
@property (nonatomic , strong) UIView  *tagBgView;//标签背景
@property (nonatomic , strong) UILabel *descriptionLbl;//简介

@end

@implementation EDSCoachInformationFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = WhiteColor;
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = WhiteColor;
        [self setup];
    }
    return self;
}

- (void)setCoachModel:(EDSCoachListModel *)coachModel
{
    _coachModel = coachModel;
    
    [self addTagLblView];
    
    self.ageLbl.text = [NSString stringWithFormat:@"%@年",coachModel.teachAge];
    self.subjectsLbl.text = coachModel.teachType;
    self.descriptionLbl.text = coachModel.present;
}

- (void)setup{
    
    UIView *line = [UIView viewWithBackgroundColor:TableColor superView:self.contentView];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *agetagLbl = [UILabel labelWithText:@"教龄" font:kFont(16) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    [agetagLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(line.mas_bottom).mas_equalTo(15);
    }];
    
    _ageLbl = [UILabel labelWithText:@"5年" font:kFont(16) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    [_ageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(agetagLbl.mas_centerY);
        make.right.mas_equalTo(-15);
    }];
    
    UILabel *subjectstagLbl = [UILabel labelWithText:@"科目" font:kFont(16) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    [subjectstagLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(agetagLbl.mas_bottom).mas_equalTo(29);
    }];
    _subjectsLbl = [UILabel labelWithText:@"科目一、科目二" font:kFont(16) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    [_subjectsLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(subjectstagLbl.mas_centerY);
    }];
    
    _tagBgView = [UIView viewWithBackgroundColor:WhiteColor superView:self.contentView];
    [_tagBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(subjectstagLbl.mas_bottom).mas_equalTo(22);
        make.height.mas_equalTo(35);
    }];
    
    UILabel *descriptiontagLbl = [UILabel labelWithText:@"个人简介" font:kFont(16) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    [descriptiontagLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.tagBgView.mas_bottom).mas_equalTo(19);
    }];
    _descriptionLbl = [UILabel labelWithText:@"个人简介个人简，介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人简介个人" font:kFont(16) textColor:SecondColor backGroundColor:ClearColor superView:self.contentView];
    [_descriptionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(descriptiontagLbl.mas_top);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(KLineX(255));
        make.bottom.mas_equalTo(-20);
    }];
}

- (void)addTagLblView
{
    UILabel *tagLabel = [UILabel labelWithText:@"教练标签" font:kFont(16) textColor:SecondColor backGroundColor:ClearColor superView:self.tagBgView];
    [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(7);
    }];
    
    for (int i = 0; i < self.coachModel.showTagArr.count; i ++) {
        
        NSInteger x = i / 2;
        NSInteger y = i % 2;
        
        UILabel *label = [UILabel labelWithText:self.coachModel.showTagArr[i] font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.tagBgView];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 5;
        label.layer.borderColor = SeparatorCOLOR.CGColor;
        label.layer.borderWidth = 1;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 30));
            make.top.mas_equalTo(40*x);
            make.right.mas_equalTo(-15 - 100*y);
        }];
        
        if (i == self.coachModel.showTagArr.count - 1) {
            
            [self.tagBgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(40*2);
            }];
        }
    }
}
@end

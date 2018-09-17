//
//  EDSPracticeHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPracticeHeaderView.h"
#import <UIImage+GIF.h>

#import "EDSQuestionModel.h"

@interface EDSPracticeHeaderView ()

/** 单选还是多选 */
@property (nonatomic, strong) UILabel  *choosetypeLbl;
/** 题目 */
@property (nonatomic, strong) UILabel  *titleLbl;
/** 图片 */
@property (nonatomic, strong) UIImageView  *pictureImgView;
@end

@implementation EDSPracticeHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.wz_width = kScreenWidth;
        [self setup];
        [self layoutIfNeeded];
    }
    return self;
}

- (void)layoutIfNeeded
{
    [super layoutIfNeeded];
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (void)setQuestionModel:(EDSQuestionModel *)questionModel
{
    _questionModel = questionModel;
    
    _choosetypeLbl.text = questionModel.isMultiple ? @"单选题" : @"多选题";
    
    NSString *labelText = [NSString stringWithFormat:@"  %@",questionModel.questionTitle];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"ks_content_frame"];
    //    attch.
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, attch.image.size.width, attch.image.size.height);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attributedString appendAttributedString:string];
    NSAttributedString *behind = [[NSAttributedString alloc]initWithString:labelText];
    [attributedString appendAttributedString:behind];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    
    _titleLbl.attributedText = attributedString;
    
    if ([questionModel.questionPictureUrl isEqualToString:@"1326"] || [questionModel.questionPictureUrl isEqualToString:@"1327"] || [questionModel.questionPictureUrl isEqualToString:@"1328"] || [questionModel.questionPictureUrl isEqualToString:@"1329"] || [questionModel.questionPictureUrl isEqualToString:@"1330"]|| [questionModel.questionPictureUrl isEqualToString:@"1331"]||[questionModel.questionPictureUrl isEqualToString:@"1332"]||[questionModel.questionPictureUrl isEqualToString:@"1400"] ||[questionModel.questionPictureUrl isEqualToString:@"1401"]||[questionModel.questionPictureUrl isEqualToString:@"1410"]||[questionModel.questionPictureUrl isEqualToString:@"1424"]||[questionModel.questionPictureUrl isEqualToString:@"1458"]||[questionModel.questionPictureUrl isEqualToString:@"1465"]||[questionModel.questionPictureUrl isEqualToString:@"1474"]||[questionModel.questionPictureUrl isEqualToString:@"1485"]||[questionModel.questionPictureUrl isEqualToString:@"1488"]||[questionModel.questionPictureUrl isEqualToString:@"2020"]||[questionModel.questionPictureUrl isEqualToString:@"2028"]||[questionModel.questionPictureUrl isEqualToString:@"2208"]||[questionModel.questionPictureUrl isEqualToString:@"2272"]||[questionModel.questionPictureUrl isEqualToString:@"2301"]||[questionModel.questionPictureUrl isEqualToString:@"2302"]||[questionModel.questionPictureUrl isEqualToString:@"1333"]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:questionModel.questionPictureUrl ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *image = [UIImage sd_animatedGIFWithData:data];
        _pictureImgView.image = image;
        
    }else{
        
        _pictureImgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",questionModel.questionPictureUrl]];
    }
    
    
    CGFloat widthR = kScreenWidth - 30;
    CGFloat width = _pictureImgView.image.size.width;
    CGFloat height = _pictureImgView.image.size.height;
    CGFloat heightR = 0.f;
    
    if (width != 0) {
        
        heightR = widthR * height / width;
    }
    
    [_pictureImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(heightR);
    }];
    
    [self  getPracticeHeaderViewHeight];
    [self layoutIfNeeded];
}

- (CGFloat)getPracticeHeaderViewHeight
{
    return CGRectGetMaxY(self.pictureImgView.frame);
}

- (void)setup{
    
    _choosetypeLbl = [UILabel labelWithText:@"单选题" font:kFont(10) textColor:ThemeColor backGroundColor:ClearColor superView:self];
    [_choosetypeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(19);
    }];
    _choosetypeLbl.textAlignment = NSTextAlignmentCenter;
    
    _titleLbl = [UILabel labelWithText:@"" font:kFont(18) textColor:SecondColor backGroundColor:ClearColor superView:self];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
        make.width.mas_equalTo(kScreenWidth - 30);
    }];
    
    _pictureImgView = [UIImageView imageViewWithSuperView:self];
    [_pictureImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->_titleLbl.mas_bottom).mas_equalTo(8);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(kScreenWidth - 30);
        make.height.mas_equalTo(66);
        make.bottom.mas_equalTo(0);
    }];
}

@end

//
//  EDSBusInfoTopView.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/23.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSBusInfoTopView.h"

@interface EDSBusInfoTopView()
@property (nonatomic,strong) UILabel *leftTopLabel;
@property (nonatomic,strong) UILabel *rightTopLabel;
@property (nonatomic,strong) UILabel *beginTimeLabel;
@property (nonatomic,strong) UILabel *endTimeLabel;

@property (nonatomic,strong) UIImageView *beginImgLabel;
@property (nonatomic,strong) UIImageView *endImgLabel;

@property (nonatomic,strong) UIButton *refeshBtn;

@end
@implementation EDSBusInfoTopView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
-(void)initView{
    self.backgroundColor = [UIColor whiteColor];
    
    _leftTopLabel = [UILabel labelWithText:@"" font:[UIFont systemFontOfSize:13] textColor:[UIColor blackColor] backGroundColor:nil superView:self];
    
    _rightTopLabel = [UILabel labelWithText:@"" font:[UIFont systemFontOfSize:10] textColor:[UIColor blackColor] backGroundColor:nil superView:self];
    
    _beginImgLabel =[UIImageView imageViewWithSuperView:self];
    _beginImgLabel.image = [UIImage imageNamed:@"busfInfo_Begin"];

    _beginTimeLabel =[UILabel labelWithText:@"" font:[UIFont systemFontOfSize:11] textColor:[UIColor lightGrayColor] backGroundColor:[UIColor whiteColor] superView:self];
    
    
    
    _endImgLabel =[UIImageView imageViewWithSuperView:self];
    _endImgLabel.image = [UIImage imageNamed:@"busInfo_End"];
  
    _endTimeLabel = [UILabel labelWithText:@"" font:[UIFont systemFontOfSize:11] textColor:[UIColor lightGrayColor] backGroundColor:[UIColor whiteColor] superView:self];
    
    _refeshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _refeshBtn.backgroundColor = [UIColor redColor];
    [_refeshBtn setImage:[UIImage imageNamed:@"ic_qiehuan"] forState:UIControlStateNormal];
    [_refeshBtn bk_whenTapped:^{
                      NSLog(@"刷新");
        if (self.refreshBtnClick) {
            self.refreshBtnClick();
        }
    }];
    [self addSubview:_refeshBtn];
    
    [self setConstraint];
}
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    self.leftTopLabel.text = dataDic[@"shuttleBusName"];
    self.rightTopLabel.text = [NSString stringWithFormat:@"%@->%@",dataDic[@"startPlace"],dataDic[@"endPlace"]];
    self.beginTimeLabel.text = dataDic[@"startTime"];
    self.endTimeLabel.text = dataDic[@"endTime"];
    
}
-(void)setConstraint{
    [self.leftTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(10).equalTo(self);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    [self.rightTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10).equalTo(self);
        make.right.mas_offset(-10).equalTo(self);
        make.left.equalTo(self.leftTopLabel.mas_right).mas_offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.beginImgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15).equalTo(self.leftTopLabel.mas_bottom);
        make.left.equalTo(self).mas_offset(10);
        make.height.width.mas_equalTo(25);
    }];
    
    [self.beginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20).equalTo(self.leftTopLabel.mas_bottom);
        make.left.equalTo(self.beginImgLabel.mas_right).mas_offset(5);
        make.height.mas_equalTo(15);
        
    }];
    
    [self.endImgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15).equalTo(self.leftTopLabel.mas_bottom);
        make.left.equalTo(self.beginTimeLabel.mas_right).mas_offset(30);
        make.height.width.mas_equalTo(25);
    }];
    
    [self.endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20).equalTo(self.leftTopLabel.mas_bottom);
        make.left.equalTo(self.endImgLabel.mas_right).mas_offset(5);
        make.height.mas_equalTo(15);
    }];
    
    [self.refeshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_offset(10).equalTo(self.leftTopLabel.mas_bottom);
        make.right.equalTo(self.mas_right).mas_offset(-10);
        make.width.height.mas_equalTo(30);
    }];
    
}
@end

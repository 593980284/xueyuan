//
//  EDSEDSDrivingDetailsHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSEDSDrivingDetailsHeaderView.h"

#import "EDSDriveStarView.h"
#import "EDSHeaderPageButtonView.h"

#import "EDSSchoolInformationDetailModel.h"
#import "SelectScrollView.h"

@interface EDSEDSDrivingDetailsHeaderView ()


/** 图片 */
@property (nonatomic, strong) UIImageView  *drivingImgView;
/** 驾校名 */
@property (nonatomic, strong) UILabel  *drivingNameLbl;
/** 价格 */
@property (nonatomic, strong) UILabel  *drivingPriceLbl;
/** 星级 */
//@property (strong, nonatomic) EDSDriveStarView *driveStarView;
/** 分数 */
@property (nonatomic, strong) UILabel  *driveScoreLbl;


/** 驾校名 */
@property (nonatomic, strong) UILabel  *commentDriveNameLbl;
/** 星级 */
@property (nonatomic, strong) EDSDriveStarView  *commentDriveStarView;
/** 分数 */
@property (nonatomic, strong) UILabel  *commentDriveScoreLbl;

@property (nonatomic, strong) UIImageView *a1;
@property (nonatomic, strong) UIImageView *a2;
@property (nonatomic, strong) UIImageView *a3;
@property (nonatomic, strong) UIImageView *a4;
@property (nonatomic, strong) UIImageView *a5;

@end

@implementation EDSEDSDrivingDetailsHeaderView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = WhiteColor;
        self.drivingImgView.image = PLACEHOLDERGOODSIMAGE ;
        self.drivingNameLbl.text = @"";
        self.drivingPriceLbl.text = @"";
        self.driveScoreLbl.text = @"";
        self.driveAddressLbl.text = @"";
//        self.driveStarView.selectNumber = 0;
        self.commentBgView.alpha = 0.0;
        self.driveSchoolBgView.alpha = 1.0;
        
        self.commentDriveScoreLbl.text = @"";
        self.commentDriveStarView.selectNumber = 0;
        self.commentDriveNameLbl.text = @"";
        self.driveAddressLbl.userInteractionEnabled = YES;
        
        _a1 = [UIImageView new];
        _a1.image = [UIImage imageNamed:@"A"];
        [self addSubview:_a1];
        [_a1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(15);
            make.top.mas_equalTo(self.drivingNameLbl.mas_bottom).offset(3);
            make.left.mas_equalTo(self.drivingNameLbl);
        }];
        
        _a2 = [UIImageView new];
        _a2.image = [UIImage imageNamed:@"A"];
        [self addSubview:_a2];
        [_a2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(15);
            make.top.mas_equalTo(self.drivingNameLbl.mas_bottom).offset(3);
            make.left.mas_equalTo(self.a1.mas_right).offset(3);
        }];
        
        
        _a3 = [UIImageView new];
        _a3.image = [UIImage imageNamed:@"A"];
        [self addSubview:_a3];
        [_a3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(15);
            make.top.mas_equalTo(self.drivingNameLbl.mas_bottom).offset(3);
            make.left.mas_equalTo(self.a2.mas_right).offset(3);
        }];
        
        
        _a4 = [UIImageView new];
        _a4.image = [UIImage imageNamed:@"A"];
        [self addSubview:_a4];
        [_a4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(15);
            make.top.mas_equalTo(self.drivingNameLbl.mas_bottom).offset(3);
            make.left.mas_equalTo(self.a3.mas_right).offset(3);
        }];
        
        _a5 = [UIImageView new];
        _a5.image = [UIImage imageNamed:@"A"];
        [self addSubview:_a5];
        [_a5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(15);
            make.top.mas_equalTo(self.drivingNameLbl.mas_bottom).offset(3);
              make.left.mas_equalTo(self.a4.mas_right).offset(3);
        }];
    }
    return self;
}


- (instancetype)init
{
    return [self initWithFrame:self.frame];
}



- (void)setItemHeight:(CGFloat)itemHeight
{
    _itemHeight = itemHeight;
}

- (void)setSelectedItemIndex:(NSInteger)selectedItemIndex
{
    _selectedItemIndex = selectedItemIndex;
}

- (void)setInformationDetailModel:(EDSSchoolInformationDetailModel *)informationDetailModel
{
    _informationDetailModel = informationDetailModel;
    
    [self.drivingImgView sd_setImageWithURL:[NSURL URLWithString:informationDetailModel.showSchoolPhoto] placeholderImage:PLACEHOLDERGOODSIMAGE];
    
    self.drivingNameLbl.text = informationDetailModel.schoolName;
    
    self.drivingPriceLbl.text = informationDetailModel.distance;
    self.drivingPriceLbl.textColor = [UIColor colorWithRed:100/255.0 green:150/255.0 blue:240/255.0 alpha:1];
    self.driveScoreLbl.textColor = [UIColor colorWithRed:100/255.0 green:150/255.0 blue:240/255.0 alpha:1];
//    NSString * a = @"";
//    for (int i = 0; i<informationDetailModel.reputationLevel; i++) {
//        a = [NSString stringWithFormat:@"%@A", a];
//    }
//    self.driveScoreLbl.text = [NSString stringWithFormat:@"信誉等级：%@", a];
    NSArray<UIImageView *> *as = @[_a1, _a2,_a3 , _a4,_a5];
    for (UIImageView *A in as) {
        A.hidden = YES;
    }
    for(int i =0; i<informationDetailModel.reputationLevel; i ++){
        as[i].hidden = NO;
    }
    self.driveAddressLbl.text = informationDetailModel.address;
    
//    self.driveStarView.selectNumber = informationDetailModel.showStarScoreInterger;
    
    @weakify(self);
    self.commentBgView.alpha = 0.0;
    self.driveSchoolBgView.alpha = 1.0;
    
    self.commentDriveScoreLbl.text = informationDetailModel.showStarScore;
    self.commentDriveStarView.selectNumber = informationDetailModel.showStarScoreInterger;
    self.commentDriveNameLbl.text = informationDetailModel.schoolName;
}

- (void)setHeaderModel:(NSArray *)headerModel
{
    _headerModel = headerModel;

    [self.drivingImgView sd_setImageWithURL:[NSURL URLWithString:@"http://t10.baidu.com/it/u=1234345764,2064519377&fm=173&app=25&f=JPEG?w=600&h=361&s=750229F541719788DDB9A41603001093"] placeholderImage:PLACEHOLDERGOODSIMAGE];

    self.drivingNameLbl.text = @"小白驾校";

    self.drivingPriceLbl.text = @"￥3000.00";

    self.driveScoreLbl.text = @"8分";

    self.driveAddressLbl.text = @"南京市长江路南京市长江路1234号";

    @weakify(self);
    self.commentBgView.alpha = 0.0;
    self.driveSchoolBgView.alpha = 1.0;

    self.commentDriveScoreLbl.text = @"5分";
    self.commentDriveStarView.selectNumber = 3;
    self.commentDriveNameLbl.text = @"hahahha";
}

- (UIView *)driveSchoolBgView
{
    if (!_driveSchoolBgView) {
        
        _driveSchoolBgView = [UIView viewWithBackgroundColor:WhiteColor superView:self];
        [_driveSchoolBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(139);
        }];
    }
    return _driveSchoolBgView;
}

- (UIImageView *)drivingImgView
{
    if (!_drivingImgView) {
        
        _drivingImgView = [UIImageView imageViewWithSuperView:self.driveSchoolBgView];
        [_drivingImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 80));
            make.left.top.mas_equalTo(15);
        }];
    }
    return _drivingImgView;
}


- (UILabel *)drivingNameLbl
{
    if (!_drivingNameLbl) {
        
        _drivingNameLbl = [UILabel labelWithText:@"小白驾校" font:[UIFont boldSystemFontOfSize:17] textColor:FirstColor backGroundColor:ClearColor superView:self.driveSchoolBgView];
        _drivingNameLbl.numberOfLines = 1;
        [_drivingNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->_drivingImgView.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(self->_drivingImgView.mas_top);
            make.width.mas_equalTo(200);
        }];
    }
    return _drivingNameLbl;
}

- (UILabel *)drivingPriceLbl
{
    if (!_drivingPriceLbl) {
        
        _drivingPriceLbl = [UILabel labelWithText:@"￥3000.00" font:kFont(14) textColor:[EDSToolClass getColorWithHexString:@"#666666"] backGroundColor:ClearColor superView:self.driveSchoolBgView];
        [_drivingPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self->_drivingImgView.mas_top);
        }];
    }
    return _drivingPriceLbl;
}

//- (EDSDriveStarView *)driveStarView
//{
//    if (!_driveStarView) {
//
//        _driveStarView = [[EDSDriveStarView alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
//        _driveStarView.selectNumber = 2;
//        [self.driveSchoolBgView addSubview:_driveStarView];
//        [_driveStarView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(100, 15));
//            make.left.mas_equalTo(self->_drivingNameLbl.mas_left);
//            make.top.mas_equalTo(self->_drivingNameLbl.mas_bottom).mas_equalTo(10);
//        }];
//    }
//    return _driveStarView;
//}

- (UILabel *)driveScoreLbl
{
    if (!_driveScoreLbl) {
        
        _driveScoreLbl = [UILabel labelWithText:@"8分" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.driveSchoolBgView];
        [_driveScoreLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.drivingImgView.mas_centerY);
            make.left.mas_equalTo(self.drivingImgView.mas_right).mas_equalTo(10);
        }];

    }
    return _driveScoreLbl;
}


- (UILabel *)driveAddressLbl
{
    if (!_driveAddressLbl) {
        
//        UIImageView *addressImgView = [UIImageView imageViewWithSuperView:self.driveSchoolBgView];
//        addressImgView.image = [UIImage imageNamed:@"map_content_icon_default"];
//        [addressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(10, 14));
//            make.left.mas_equalTo(self->_drivingImgView.mas_right).mas_offset(10);
//            make.bottom.mas_equalTo(self->_drivingImgView.mas_bottom);
//        }];
        
        _driveAddressLbl = [UILabel labelWithText:@"南京市长江路南京市长江路1234号" font:kFont(13) textColor:SecondColor backGroundColor:ClearColor superView:self.driveSchoolBgView];
        _driveAddressLbl.numberOfLines = 1;
        [_driveAddressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.mas_equalTo(addressImgView.mas_centerY);
//            make.left.mas_equalTo(addressImgView.mas_right).mas_equalTo(8);
            make.right.mas_equalTo(-15);
            make.left.mas_equalTo(self->_drivingImgView.mas_right).mas_offset(10);
            make.bottom.mas_equalTo(self->_drivingImgView.mas_bottom);
        }];
        
        
        UIView *btnBgView = [UIView viewWithBackgroundColor:WhiteColor superView:self];
        [btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        
        [self addFuntionBtnViewWithParentView:btnBgView];
        
        
        UIView *line = [UIView viewWithBackgroundColor:TableColor superView:self];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(10);
            make.bottom.mas_equalTo(btnBgView.mas_top);
        }];
    }
    return _driveAddressLbl;
}

- (UIView *)commentBgView
{
    if (!_commentBgView) {
        
        _commentBgView = [UIView viewWithBackgroundColor:WhiteColor superView:self];
        [_commentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.driveSchoolBgView.mas_bottom);
            make.height.mas_equalTo(46);
        }];
        
        
    }
    return _commentBgView;
}


- (UILabel *)commentDriveNameLbl
{
    if (!_commentDriveNameLbl) {
        
        _commentDriveNameLbl = [UILabel labelWithText:@"小白驾校" font:[UIFont boldSystemFontOfSize:17] textColor:FirstColor backGroundColor:ClearColor superView:self.commentBgView];
        _commentDriveNameLbl.numberOfLines = 1;
        [_commentDriveNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(kScreenWidth - 200);
        }];
    }
    return _commentDriveNameLbl;
}

- (UILabel *)commentDriveScoreLbl
{
    if (!_commentDriveScoreLbl) {
        
        _commentDriveScoreLbl = [UILabel labelWithText:@"8分" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.commentBgView];
        [_commentDriveScoreLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        }];
    }
    return _commentDriveScoreLbl;
}

- (EDSDriveStarView *)commentDriveStarView
{
    if (!_commentDriveStarView) {
        
        _commentDriveStarView = [[EDSDriveStarView alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
        [self.commentBgView addSubview:_commentDriveStarView];
        [_commentDriveStarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 15));
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(self.commentDriveScoreLbl.mas_left).mas_equalTo(-10);
        }];
    }
    return _commentDriveStarView;
}

- (void)addCommentSubViewWithParentView:(UIView *)parentView
{
    
}

- (void)addFuntionBtnViewWithParentView:(UIView *)parentView
{
//    EDSHeaderPageButtonView *headerView = [[EDSHeaderPageButtonView alloc] init];
//    headerView.btnArr = @[@"简介",@"风采展示",@"报名点",@"训练场地",@"教练员"];
//    [parentView addSubview:headerView];
//    @weakify(self);
//    headerView.headerPageButtonDidSelectStringback = ^(NSString *titleStr) {
//        @strongify(self);
//        if (self.drivingDetailsHeaderViewDidSelectStringback) {
//            self.drivingDetailsHeaderViewDidSelectStringback(titleStr);
//        }
//    };
//    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(0);
//    }];
    
    SelectScrollView * sc  = [[SelectScrollView alloc]initWithTitles:@[@"简介",@"风采展示",@"报名点",@"训练场地",@"教练员",@"班车信息"]];
    [parentView addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    sc.block = ^(NSString * _Nonnull titleStr) {
        self.drivingDetailsHeaderViewDidSelectStringback(titleStr);
    };
    
    /*
    UIView *line = [UIView viewWithBackgroundColor:TableColor superView:parentView];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    _indicatorView = [UIView viewWithBackgroundColor:ThemeColor superView:parentView];
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 2));
        make.bottom.mas_equalTo(0);
        make.centerX.mas_equalTo(0).multipliedBy(0.33);
    }];
    
    _introductionBtn = [[UIButton alloc] init];
    [_introductionBtn setTitleColor:FirstColor forState:UIControlStateNormal];
    [_introductionBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [_introductionBtn setTitle:@"简介" forState:UIControlStateNormal];
    [_introductionBtn setTitle:@"简介" forState:UIControlStateSelected];
    _introductionBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [parentView addSubview:_introductionBtn];
    [_introductionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    _introductionBtn.selected = YES;
    
    _teachingStyleBtn = [[UIButton alloc] init];
    [_teachingStyleBtn setTitleColor:FirstColor forState:UIControlStateNormal];
    [_teachingStyleBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [_teachingStyleBtn setTitle:@"教学风采" forState:UIControlStateNormal];
    [_teachingStyleBtn setTitle:@"教学风采" forState:UIControlStateSelected];
    _teachingStyleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [parentView addSubview:_teachingStyleBtn];
    [_teachingStyleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self->_introductionBtn.mas_right);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    _coachBtn = [[UIButton alloc] init];
    [_coachBtn setTitleColor:FirstColor forState:UIControlStateNormal];
    [_coachBtn setTitleColor:ThemeColor forState:UIControlStateSelected];
    [_coachBtn setTitle:@"教练员" forState:UIControlStateNormal];
    [_coachBtn setTitle:@"教练员" forState:UIControlStateSelected];
    _coachBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [parentView addSubview:_coachBtn];
    [_coachBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self->_teachingStyleBtn.mas_right);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    @weakify(self);
    [_introductionBtn bk_whenTapped:^{
        @strongify(self);
        self->_introductionBtn.selected = YES;
        self->_teachingStyleBtn.selected = NO;
        self->_coachBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0).multipliedBy(0.33);
                make.size.mas_equalTo(CGSizeMake(50, 2));
                make.bottom.mas_equalTo(0);
            }];
        }];
    }];
    [_teachingStyleBtn bk_whenTapped:^{
        @strongify(self);
        self->_introductionBtn.selected = NO;
        self->_teachingStyleBtn.selected = YES;
        self->_coachBtn.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0).multipliedBy(1);
                make.size.mas_equalTo(CGSizeMake(50, 2));
                make.bottom.mas_equalTo(0);
            }];
        }];
    }];
    [_coachBtn bk_whenTapped:^{
        @strongify(self);
        self->_introductionBtn.selected = NO;
        self->_teachingStyleBtn.selected = NO;
        self->_coachBtn.selected = YES;
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0).multipliedBy(1.66);
                make.size.mas_equalTo(CGSizeMake(50, 2));
                make.bottom.mas_equalTo(0);
            }];
        }];
    }];
     */
}
@end

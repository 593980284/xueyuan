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


@interface EDSEDSDrivingDetailsHeaderView ()
/** 图片 */
@property (nonatomic, strong) UIImageView  *drivingImgView;
/** 驾校名 */
@property (nonatomic, strong) UILabel  *drivingNameLbl;
/** 价格 */
@property (nonatomic, strong) UILabel  *drivingPriceLbl;
/** 星级 */
@property (strong, nonatomic) EDSDriveStarView *driveStarView;
/** 分数 */
@property (nonatomic, strong) UILabel  *driveScoreLbl;
/** 按钮查看场地 */
@property (nonatomic, strong) UIButton  *chectSiteBtn;
/** 地址 */
@property (nonatomic, strong) UILabel  *driveAddressLbl;


/** 简介 */
@property (nonatomic, strong) UIButton  *introductionBtn;
/** 教学风采 */
@property (nonatomic, strong) UIButton  *teachingStyleBtn;
/** 教练员 */
@property (nonatomic, strong) UIButton  *coachBtn;
/** 指示器 */
@property (nonatomic, strong) UIView  *indicatorView;
@end

@implementation EDSEDSDrivingDetailsHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (void)setHeaderModel:(NSArray *)headerModel
{
    _headerModel = headerModel;
    
    [self.drivingImgView sd_setImageWithURL:[NSURL URLWithString:@"http://t10.baidu.com/it/u=1234345764,2064519377&fm=173&app=25&f=JPEG?w=600&h=361&s=750229F541719788DDB9A41603001093"] placeholderImage:PLACEHOLDERGOODSIMAGE];
    
    self.drivingNameLbl.text = @"小白驾校";
    
    self.drivingPriceLbl.text = @"￥3000.00";
    
    self.driveScoreLbl.text = @"8分";
    
    self.driveAddressLbl.text = @"南京市长江路南京市长江路1234号";
    
    [self.chectSiteBtn bk_whenTapped:^{
        DLog(@"查看场地");
    }];
}

- (UIImageView *)drivingImgView
{
    if (!_drivingImgView) {
        
        _drivingImgView = [UIImageView imageViewWithSuperView:self];
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
        
        _drivingNameLbl = [UILabel labelWithText:@"小白驾校" font:[UIFont boldSystemFontOfSize:17] textColor:FirstColor backGroundColor:ClearColor superView:self];
        [_drivingNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->_drivingImgView.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(self->_drivingImgView.mas_top);
        }];
    }
    return _drivingNameLbl;
}

- (UILabel *)drivingPriceLbl
{
    if (!_drivingPriceLbl) {
        
        _drivingPriceLbl = [UILabel labelWithText:@"￥3000.00" font:kFont(14) textColor:[EDSToolClass getColorWithHexString:@"#FF571D"] backGroundColor:ClearColor superView:self];
        [_drivingPriceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self->_drivingImgView.mas_top);
        }];
    }
    return _drivingPriceLbl;
}

- (EDSDriveStarView *)driveStarView
{
    if (!_driveStarView) {
        
        _driveStarView = [[EDSDriveStarView alloc] initWithFrame:CGRectMake(0, 0, 100, 15)];
        _driveStarView.selectNumber = 2;
        [self addSubview:_driveStarView];
        [_driveStarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 15));
            make.left.mas_equalTo(self->_drivingNameLbl.mas_left);
            make.top.mas_equalTo(self->_drivingNameLbl.mas_bottom).mas_equalTo(10);
        }];
    }
    return _driveStarView;
}

- (UILabel *)driveScoreLbl
{
    if (!_driveScoreLbl) {
        
        _driveScoreLbl = [UILabel labelWithText:@"8分" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self];
        [_driveScoreLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.driveStarView.mas_centerY);
            make.left.mas_equalTo(self.driveStarView.mas_right).mas_equalTo(13);
        }];

    }
    return _driveScoreLbl;
}

- (UIButton *)chectSiteBtn
{
    if (!_chectSiteBtn) {
        
        _chectSiteBtn = [[UIButton alloc] init];
        [_chectSiteBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        [_chectSiteBtn setTitle:@"查看场地" forState:UIControlStateNormal];
        [_chectSiteBtn setBackgroundColor:ThemeColor];
        [self addSubview:_chectSiteBtn];
        _chectSiteBtn.layer.cornerRadius = 5;
        _chectSiteBtn.layer.masksToBounds = YES;
        _chectSiteBtn.titleLabel.font = kFont(14);
        [_chectSiteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 25));
            make.left.mas_equalTo(self->_drivingNameLbl.mas_left);
            make.bottom.mas_equalTo(self->_drivingImgView.mas_bottom);
        }];
    }
    return _chectSiteBtn;
}

- (UILabel *)driveAddressLbl
{
    if (!_driveAddressLbl) {
        
        UIImageView *addressImgView = [UIImageView imageViewWithSuperView:self];
        addressImgView.image = [UIImage imageNamed:@"map_content_icon_default"];
        [addressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 14));
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(self->_drivingImgView.mas_bottom).mas_equalTo(15);
        }];
        
        _driveAddressLbl = [UILabel labelWithText:@"南京市长江路南京市长江路1234号" font:kFont(16) textColor:SecondColor backGroundColor:ClearColor superView:self];
        [_driveAddressLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(addressImgView.mas_centerY);
            make.left.mas_equalTo(addressImgView.mas_right).mas_equalTo(8);
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


- (void)addFuntionBtnViewWithParentView:(UIView *)parentView
{
    EDSHeaderPageButtonView *headerView = [[EDSHeaderPageButtonView alloc] init];
    headerView.btnArr = @[@"简介",@"教学风采",@"教练员"];
    [parentView addSubview:headerView];
    headerView.headerPageButtonDidSelectStringback = ^(NSString *titleStr) {
        
    };
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
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

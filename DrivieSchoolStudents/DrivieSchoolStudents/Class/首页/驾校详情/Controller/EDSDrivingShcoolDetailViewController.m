//
//  EDSDrivingShcoolDetailViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDrivingShcoolDetailViewController.h"
#import "EDSSubscribeApplyViewController.h"

#import "EDSEDSDrivingDetailsHeaderView.h"
#import "EDSDrivingDetailsFooterView.h"
#import "EDSFirstView.h"
#import "EDSSecondView.h"
#import "EDSThirdView.h"
#import "EDSFourView.h"

#import "EDSFindSchoolInformationRequest.h"

#import "EDSSchoolInformationDetailModel.h"

#define kTopView_Height 193
#define kItemheight 100

@interface EDSDrivingShcoolDetailViewController ()

@property (strong, nonatomic) EDSEDSDrivingDetailsHeaderView *topView;
@property (nonatomic, strong) EDSDrivingDetailsFooterView  *footerView;
@property (nonatomic, strong) EDSFirstView      *firstView;
@property (nonatomic, strong) EDSSecondView     *secondView;
@property (nonatomic, strong) EDSThirdView      *thirdView;
@property (nonatomic, strong) EDSFourView       *fourView;

/** 详情数据 */
@property (nonatomic, strong) EDSSchoolInformationDetailModel  *detailModel;

@end

@implementation EDSDrivingShcoolDetailViewController


- (void)loadView
{
    [super loadView];
}

#pragma mark ------------------------ 网络请求 --------------------------------
- (void)requestData
{
    @weakify(self);
    EDSFindSchoolInformationRequest *request = [EDSFindSchoolInformationRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
     
        @strongify(self);
        EDSSchoolInformationDetailModel *detailModel = model;
        self.topView.informationDetailModel = detailModel;
        self.firstView.appContent = detailModel.appContent;
        
        self.detailModel = detailModel;
        
    } failureBlock:^(NSError *error) {
        
    }];
    request.showHUD = YES;
    request.schoolId = self.schoolId;
    [request startRequest];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"驾校详情";
    
    [self.view addSubview:self.topView];
    @weakify(self);
    self.topView.drivingDetailsHeaderViewDidSelectStringback = ^(NSString *titleStr) {
        @strongify(self);
        if ([titleStr isEqualToString:@"简介"]) {
            
            self.firstView.hidden = NO;
            self.secondView.hidden = YES;
            self.thirdView.hidden = YES;
            self.fourView.hidden = YES;
        }else if ([titleStr isEqualToString:@"教学风采"]){
            
            self.firstView.hidden = YES;
            self.secondView.hidden = NO;
            self.thirdView.hidden = YES;
            self.fourView.hidden = YES;
        }else if ([titleStr isEqualToString:@"教练员"]){
            
            self.firstView.hidden = YES;
            self.secondView.hidden = YES;
            self.thirdView.hidden = NO;
            self.fourView.hidden = YES;
        }else if ([titleStr isEqualToString:@"查看场地"]){
            
            self.firstView.hidden = YES;
            self.secondView.hidden = YES;
            self.thirdView.hidden = YES;
            self.fourView.hidden = NO;
        }
    };
    
    [self.view addSubview:self.firstView];
    [self.view addSubview:self.secondView];
    [self.view addSubview:self.thirdView];
    [self.view addSubview:self.fourView];
    
    self.firstView.hidden = NO;
    self.secondView.hidden = YES;
    self.thirdView.hidden = YES;
    self.fourView.hidden = YES;
    
    self.footerView.drivingDetailsFooterViewDidSelectStringback = ^(NSString *titleStr) {
    
        @strongify(self);
        if ([titleStr  isEqualToString:@"咨询"]) {
            
            [EDSToolClass getOpenTelphone:self.detailModel.phone];
        }else if ([titleStr isEqualToString:@"价格公示"]){
            
        }else{
            
            EDSSubscribeApplyViewController *vc = [[EDSSubscribeApplyViewController alloc] init];
            vc.schoolArr = @[self.detailModel.schoolId,self.detailModel.schoolName];
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
}

- (void)setSchoolId:(NSString *)schoolId
{
    _schoolId = schoolId;
    
    [self requestData];
}

- (EDSEDSDrivingDetailsHeaderView *)topView
{
    if (!_topView) {
        _topView = [[EDSEDSDrivingDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopView_Height)];
        _topView.itemHeight = kItemheight;
        [self.view addSubview:_topView];
    }
    return _topView;
}

- (EDSDrivingDetailsFooterView *)footerView
{
    if (!_footerView) {
        
        _footerView = [[EDSDrivingDetailsFooterView alloc] init];
        [self.view addSubview:_footerView];
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(69);
        }];
    }
    return _footerView;
}


- (EDSFirstView *)firstView
{
    if (!_firstView) {
        
        _firstView = [[EDSFirstView alloc] init];
        _firstView.topView = self.topView;
        [self.view addSubview:_firstView];
        [_firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.footerView.mas_top);
            make.top.mas_equalTo(self.topView.mas_bottom);
        }];
    }
    return _firstView;
}

- (EDSSecondView *)secondView
{
    if (!_secondView) {
        
        _secondView = [[EDSSecondView alloc] init];
        _secondView.topView = self.topView;
        _secondView.schoolId = self.schoolId;
        [self.view addSubview:_secondView];
        [_secondView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.footerView.mas_top);
            make.top.mas_equalTo(self.topView.mas_bottom);
        }];
    }
    return _secondView;
}


- (EDSThirdView *)thirdView
{
    if (!_thirdView) {
        
        _thirdView = [[EDSThirdView alloc] init];
        _thirdView.topView = self.topView;
        _thirdView.schoolId = self.schoolId;
        [self.view addSubview:_thirdView];
        [_thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.footerView.mas_top);
            make.top.mas_equalTo(self.topView.mas_bottom);
        }];
    }
    return _thirdView;
}


- (EDSFourView *)fourView
{
    if (!_fourView) {
        
        _fourView = [[EDSFourView alloc] init];
        _fourView.topView = self.topView;
        _fourView.schoolId = self.schoolId;
        [self.view addSubview:_fourView];
        [_fourView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.footerView.mas_top);
            make.top.mas_equalTo(self.topView.mas_bottom);
        }];
    }
    return _fourView;
}

@end

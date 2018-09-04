//
//  EDSSubscribeApplyViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubscribeApplyViewController.h"
#import "EDSDrivingSchoolInformationViewController.h"
#import "EDSChooseBoxViewController.h"
#import "PopAnimator.h"
#import "UICustomDatePicker.h"

#import "HomeConstants.h"

#import "EDSSubscribeApplyOneTableViewCell.h"
#import "EDSSubscribeApplyTwoTableViewCell.h"

#import "EDSStudentPreSignUpRequest.h"
#import "EDSGetcoachCarTypeRequest.h"

#import "EDSGetcoachCarTypeModel.h"
#import "EDSChooseBoxViewController.h"

@interface EDSSubscribeApplyViewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
{
    NSString *_schoolID;//继续
    NSString *_carId;//车型
    UITextField *_nameTextF;//姓名
    UITextField *_codeTextF;//身份证
    UITextField *_phoneTextF;//联系方式
    NSString *_time;//预约时间
}

@property (nonatomic, strong) PopAnimator *popAnimator;
/** 车型模型 */
@property (nonatomic, strong) NSArray <EDSGetcoachCarTypeModel *>  *carTypeArr;
/** 车型选择模型 */
@property (nonatomic, strong) NSMutableArray<EDSChooseBoxModel *>  *chooseBoxModelArr;
@end

@implementation EDSSubscribeApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"预约报名";
    self.carTypeArr = [[NSArray alloc] init];
    self.chooseBoxModelArr = [[NSMutableArray alloc] init];
    
    _schoolID = @"";
    _carId = @"";
    _time = @"";
    
    
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"goback"] forState:UIControlStateNormal];
    [backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    backBtn.wz_size = CGSizeMake(25, 40);
    self.navigationItem.leftBarButtonItem = item;
    
    [self setup];
    [self getcoachCarTypeRequest];
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setSchoolArr:(NSArray *)schoolArr
{
    _schoolArr = schoolArr;
}

- (void)setup{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = ClearColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-100);
    }];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:PLACEHOLDERGOODSIMAGE];
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.showPageControl = YES;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.frame = CGRectMake(0, 0, kScreenWidth, EDSHomeTableViewHeaderSlideH);
    self.tableView.tableHeaderView = cycleScrollView;
    cycleScrollView.imageURLStringsGroup = @[
                                             @"http://pic35.photophoto.cn/20150516/0005018639255973_b.jpg",
                                             @"http://pic35.photophoto.cn/20150516/0005018639255973_b.jpg",
                                             ];
    
    UIButton *determineBtn = [[UIButton alloc] init];
    [determineBtn setTitle:@"确认预约" forState:UIControlStateNormal];
    [determineBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    determineBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    determineBtn.backgroundColor = ThemeColor;
    determineBtn.layer.cornerRadius = 5;
    determineBtn.layer.masksToBounds = YES;
    [self.view addSubview:determineBtn];
    [determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-18);
    }];
    
    [determineBtn bk_whenTapped:^{
        
        [self submitrRequestData];
    }];
    
    UILabel *label = [UILabel labelWithText:@"注：驾校工作时间为9:00:00-17:00:00" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.view];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(determineBtn.mas_top).mas_equalTo(-25);
    }];
}

#pragma mark ------------------------ 网络请求 --------------------------------
- (void)submitrRequestData
{
    if (_schoolID.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择驾校"];
        [SVProgressHUD dismissWithDelay:1];
        return;
    }
    if (_nameTextF.text.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        [SVProgressHUD dismissWithDelay:1];
        return;
    }
    if (_codeTextF.text.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
        [SVProgressHUD dismissWithDelay:1];
        return;
    }
    if (_phoneTextF.text.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请输入联系方式"];
        [SVProgressHUD dismissWithDelay:1];
        return;
    }
    if (_carId.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择车型"];
        [SVProgressHUD dismissWithDelay:1];
        return;
    }
    if (_time.length == 0) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择时间"];
        [SVProgressHUD dismissWithDelay:1];
        return;
    }
    
    EDSStudentPreSignUpRequest *request = [EDSStudentPreSignUpRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            [SVProgressHUD showSuccessWithStatus:@"报名成功"];
            [SVProgressHUD dismissWithDelay:1.5];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            });
        }
    } failureBlock:^(NSError *error) {
        
    }];
    
    request.schoolId = _schoolID;
    request.studentName = _nameTextF.text;
    request.certNo = _codeTextF.text;
    request.mobile = _phoneTextF.text;
    request.applyDriveCar = _carId;
    request.appointmentTime = _time;
    request.signupSource = @"1";
    [request startRequest];
}

- (void)getcoachCarTypeRequest
{
    @weakify(self);
    EDSGetcoachCarTypeRequest *request = [EDSGetcoachCarTypeRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        if (errCode == 1) {
            
            self.carTypeArr = model;
            
            dispatch_apply(self.carTypeArr.count, dispatch_get_global_queue(0, 0), ^(size_t i) {
                
                EDSChooseBoxModel *model = [[EDSChooseBoxModel alloc] init];
                model.name = self.carTypeArr[i].name;
                model.code = self.carTypeArr[i].code;
                [self.chooseBoxModelArr addObject:model];
                
            });
        }else
        {
            [self getcoachCarTypeRequest];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    request.showHUD = YES;
    [request startRequest];
}


#pragma make ------ tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return EDSSubscribeApplyOneTableViewCellH;

    }else{
        
        return EDSSubscribeApplyTwoTableViewCellH;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        EDSSubscribeApplyOneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSSubscribeApplyOneTableViewCell"];
        
        if (!cell) {
            cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSSubscribeApplyOneTableViewCell" owner:self options:nil].firstObject;
        }
        NSString *schoolName = self.schoolArr[1];
        
        cell.drivingSchoolLbl.text = schoolName.length > 0  ? schoolName : @"请选择驾校";
        _schoolID = _schoolArr[0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = TableColor;
        
        @weakify(self);
        @weakify(cell);
        
        cell.subscribeApplyOneTableDidSelectStringback = ^(NSString *titleStr) {
            
            @strongify(self);
            //选择驾校
            if ([titleStr isEqualToString:@"选择驾校"]) {
                
                EDSDrivingSchoolInformationViewController *vc = [[EDSDrivingSchoolInformationViewController alloc] init];
                vc.firstBtnString = @"联盟驾校";
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                //选择车型
                CGFloat width = kScreenWidth;
                
                CGFloat height = 350;
                
                CGRect coverFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
                
                CGRect presentedFrame = CGRectMake(0,kScreenHeight - height, width, height);
                
                self.popAnimator = [[PopAnimator alloc]initWithCoverFrame:coverFrame presentedFrame:presentedFrame startPoint:CGPointMake(0.5, 0.5) startTransform:CGAffineTransformMakeScale(0.5, 0.5) endTransform:CGAffineTransformMakeScale(0.0001, 0.0001)];
                
                self.popAnimator.isClose = YES;
                
                EDSChooseBoxViewController *vc = [[EDSChooseBoxViewController alloc] init];
                
                vc.modalPresentationStyle = UIModalPresentationCustom;
                
                vc.transitioningDelegate = self.popAnimator;
                
                vc.modelArr = self.chooseBoxModelArr;
                
                vc.chooseBoxViewTableDidSelectModel = ^(EDSChooseBoxModel *model) {
                    
                    @strongify(cell);
                    cell.carTypeLbl.text = model.name;
                    self->_carId = model.code;
                };
                
                [self presentViewController:vc animated:YES completion:nil];
            }
        };
        
        return cell;
        
    }else{
        
        EDSSubscribeApplyTwoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSSubscribeApplyTwoTableViewCell"];
        
        if (!cell) {
            cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSSubscribeApplyTwoTableViewCell" owner:self options:nil].firstObject;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = TableColor;
        
        _nameTextF = cell.nameTextF;
        _phoneTextF = cell.phoneTextF;
        _codeTextF = cell.codeTextF;
        
        @weakify(cell);
        cell.subscribeApplyTwoTableDidSelectStringback = ^(NSString *titleStr) {
            
            [UICustomDatePicker showCustomDatePickerAtView:self.view choosedDateBlock:^(NSString *date) {
                @strongify(cell);
                
                cell.timeLbl.text = date;
                self->_time = date;
            } cancelBlock:^{
                
            }];
        };
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView viewWithBackgroundColor:TableColor superView:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView viewWithBackgroundColor:TableColor superView:nil];
}

@end

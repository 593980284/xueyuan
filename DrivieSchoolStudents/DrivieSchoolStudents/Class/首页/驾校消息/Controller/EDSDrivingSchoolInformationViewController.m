//
//  EDSDrivingSchoolInformationViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDrivingSchoolInformationViewController.h"
#import "EDSDrivingShcoolDetailViewController.h"//驾校详情

#import "EDSDriveSchollInfomationSearchView.h"
#import "EDSDriveSchollInfomationHeaderView.h"
#import "EDSHomeTableViewCell.h"

#import "EDSSchoolListRequest.h"

#import "EDSSchoolListModel.h"

#import "HomeConstants.h"

@interface EDSDrivingSchoolInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_type;
    NSString *_schoolName;
}

/** 数据 */
@property (nonatomic, strong) NSArray<EDSSchoolListModel *>  *listsArr;

@end

@implementation EDSDrivingSchoolInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listsArr = [[NSArray alloc] init];
    [self addHeaderView];
    _type = @"0";
    _schoolName = @"";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(EDSDrivingSchoolInformationHeaderH);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    [self schoollistRequest];
}

- (void)addHeaderView
{
    
    EDSDriveSchollInfomationSearchView *searchView = [[EDSDriveSchollInfomationSearchView alloc] initWithFrame:CGRectMake(45, 27, kScreenWidth - 45 - 15, 30)];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 5;
    searchView.layer.borderColor = SeparatorCOLOR.CGColor;
    searchView.layer.borderWidth = 0.5;
    @weakify(self);
    [searchView.searchTextF setBk_didEndEditingBlock:^(UITextField *textField) {
        @strongify(self);
        self->_schoolName = textField.text;
        [self schoollistRequest];
    }];
    searchView.searchTextFWidth.constant = kScreenWidth - 100;
    
    [searchView.searchTextF setBk_shouldReturnBlock:^BOOL(UITextField *textField) {
        
        @strongify(self);
        self->_schoolName = textField.text;
        [self schoollistRequest];
        [textField resignFirstResponder];
        return YES;
    }];
    self.navigationItem.titleView = searchView;
    
    EDSDriveSchollInfomationHeaderView *headerView = [[EDSDriveSchollInfomationHeaderView alloc] init];
    [self.view addSubview:headerView];
    headerView.driveSchollInfomationHeaderViewDidSelectStringback = ^(NSString *titleStr) {
        @strongify(self);
        self->_type = titleStr;
        [self schoollistRequest];
    };
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(EDSDrivingSchoolInformationHeaderH);
    }];
}

#pragma mark ------------------------ 网络请求 --------------------------------
- (void)schoollistRequest
{
    EDSSchoolListRequest *request = [EDSSchoolListRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            self.listsArr = model;
            [self.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    
    NSDictionary *dict = [UserDefault objectForKey:KuserDefaultsLocation];
    
    double localLng = [dict[@"lng"] doubleValue];
    double localLat = [dict[@"lat"] doubleValue];
    
    request.order = _type;
    request.schoolName = _schoolName;
    request.lng = [NSString stringWithFormat:@"%f",localLng];
    request.lat = [NSString stringWithFormat:@"%f",localLat];
    request.showHUD = YES;
    [request startRequest];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listsArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return EDSHomeTableViewCellH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSHomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSHomeTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSHomeTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.schoolListModel = self.listsArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSDrivingShcoolDetailViewController *vc = [[EDSDrivingShcoolDetailViewController alloc] init];
    vc.schoolId = self.listsArr[indexPath.row].schoolId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

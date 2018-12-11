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
#import "MyButton.h"
#import "MyViewOne.h"

@interface EDSDrivingSchoolInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
//    NSString *_type;
    NSString *_schoolName;
}

/** 数据 */
@property (nonatomic, strong) NSArray<EDSSchoolListModel *>  *listsArr;
@property(nonatomic, strong)NSString *orderType;
@property(nonatomic, strong)NSString *regionCode;
@property(nonatomic, strong)NSString *schoolType;
@property(nonatomic, strong)NSArray *array1;
@property(nonatomic, strong)NSArray *array2;
@property(nonatomic, strong)NSArray *array3;
@property(nonatomic, strong)MyViewOne *view1;
@property(nonatomic, strong)MyViewOne *view2;
@property(nonatomic, strong)MyViewOne *view3;
@property(nonatomic, strong)NSMutableArray *btns;
@end

@implementation EDSDrivingSchoolInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.listsArr = [[NSArray alloc] init];
    _btns = [NSMutableArray new];
//    _type = @"0";
    _schoolName = @"";
    self.orderType = @"1";
    self.regionCode = @"";
    self.schoolType = @"1";
    self.page = 1;
    _array1 = @[@{@"name":@"联盟驾校",@"code":@"1"},
                @{@"name":@"全部驾校",@"code":@"2"}];
    _array2 = @[@{@"name":@"距离排序",@"code":@"1"},
                @{@"name":@"信誉等级排序",@"code":@"2"}];
    _array3 = @[  @{@"name":@"全市",@"code":@""},
                  @{@"name":@"玄武区",@"code":@"320102"},
                  @{@"name":@"秦淮区",@"code":@"320103"},
                  @{@"name":@"建邺区",@"code":@"320105"},
                  @{@"name":@"鼓楼区",@"code":@"320106"},
                  @{@"name":@"浦口区",@"code":@"320111"},
                  @{@"name":@"栖霞区",@"code":@"320113"},
                  @{@"name":@"雨花台区",@"code":@"320114"},
                  @{@"name":@"江宁区",@"code":@"320115"},
                  @{@"name":@"六合区",@"code":@"320116"},
                  @{@"name":@"溧水区",@"code":@"320117"},
                  @{@"name":@"高淳区",@"code":@"320118"}];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = 0;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(EDSDrivingSchoolInformationHeaderH);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(schoollistRequest)];
     self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(schoollistRequest2)];
    [self.tableView.mj_header beginRefreshing];
     [self addHeaderView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
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
    
//    EDSDriveSchollInfomationHeaderView *headerView = [[EDSDriveSchollInfomationHeaderView alloc] init];
//    [self.view addSubview:headerView];
//    headerView.driveSchollInfomationHeaderViewDidSelectStringback = ^(NSString *titleStr) {
//        @strongify(self);
//        self->_type = titleStr;
//        [self schoollistRequest];
//    };
 
    UIView *headerView = [[UIView alloc] init];
    [self.view addSubview:headerView];
    NSArray *titles = @[@"联盟驾校",@"按距离",@"全市"];
    for (int i = 0; i<titles.count; i++) {
        MyButton *btn = [MyButton new];
        [btn setTitle:titles[i] forState:0];
        btn.frame = CGRectMake(kScreenWidth/3 * i, 0, kScreenWidth/3, 45);
        [headerView addSubview:btn];
        [_btns addObject:btn];
        [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(EDSDrivingSchoolInformationHeaderH);
    }];
    
    _view1 = [[MyViewOne alloc]initWithData:_array1];
    _view2 = [[MyViewOne alloc]initWithData:_array2];
    _view3 = [[MyViewOne alloc]initWithData:_array3];
    
    [self.view addSubview:_view1];
    [self.view addSubview:_view2];
    [self.view addSubview:_view3];
    
    _view1.missBlock = ^{
        UIButton *btn = self.btns[0];
        btn.selected = NO;
    };
    _view2.missBlock = ^{
        UIButton *btn = self.btns[1];
        btn.selected = NO;
    };
    _view3.missBlock = ^{
        UIButton *btn = self.btns[2];
        btn.selected = NO;
    };
    
   [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(headerView.mas_bottom);
    }];
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(headerView.mas_bottom);
    }];
    [_view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(headerView.mas_bottom);
    
    }];
    
    _view1.btnTapBlock = ^(NSString *name, NSString *code) {
        UIButton *btn = self.btns[0];
        [btn setTitle:name forState:0];
        btn.selected = NO;
        self.schoolType = code;
        [self.tableView.mj_header beginRefreshing];
    };
    _view2.btnTapBlock = ^(NSString *name, NSString *code) {
        UIButton *btn = self.btns[1];
        [btn setTitle:name forState:0];
        btn.selected = NO;
        self.orderType = code;
         [self.tableView.mj_header beginRefreshing];
    };
    _view3.btnTapBlock = ^(NSString *name, NSString *code) {
        UIButton *btn = self.btns[2];
        [btn setTitle:name forState:0];
        btn.selected = NO;
        self.regionCode = code;
        [self.tableView.mj_header beginRefreshing];
    };
}

- (void)btnTap:(UIButton *)btn{
    NSInteger index = [_btns indexOfObject:btn];
    if (btn.selected) {
        btn.selected = NO;
        if (index == 0) {
            _view1.hidden = YES;
        }
        if (index == 1) {
            _view2.hidden = YES;
        }
        if (index == 2) {
            _view3.hidden = YES;
        }
    }else{
         _view1.hidden = YES;
         _view2.hidden = YES;
         _view3.hidden = YES;
        for (UIButton * b in _btns) {
            b.selected = NO;
        }
         btn.selected = YES;
        if (index == 0) {
            _view1.hidden = NO;
        }
        if (index == 1) {
            _view2.hidden = NO;
        }
        if (index == 2) {
            _view3.hidden = NO;
        }
        
    }
}



#pragma mark ------------------------ 网络请求 --------------------------------
- (void)schoollistRequest
{
    self.page = 1;
    EDSSchoolListRequest *request = [EDSSchoolListRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            self.listsArr = model;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
         [self.tableView.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
          [self.tableView.mj_header endRefreshing];
    }];
    
    NSDictionary *dict = [UserDefault objectForKey:KuserDefaultsLocation];
    
    double localLng = [dict[@"lng"] doubleValue];
    double localLat = [dict[@"lat"] doubleValue];
    
//    request.order = _type;
    request.schoolName = _schoolName;
    request.schoolType = self.schoolType;
    request.longitude= [NSString stringWithFormat:@"%f",localLng];
    request.latitude= [NSString stringWithFormat:@"%f",localLat];
    request.orderType = self.orderType;
    request.page = self.page;
    request.regionCode = self.regionCode;
    [request startRequest];
}

- (void)schoollistRequest2
{
    self.page++;
    EDSSchoolListRequest *request = [EDSSchoolListRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, NSArray* model) {
        
        if (errCode == 1) {
            if (model.count == 0) {
                 [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                 [self.tableView.mj_footer endRefreshing];
            }
            NSMutableArray *dada = [self.listsArr mutableCopy];
            [dada addObjectsFromArray:model];
            self.listsArr = dada;
            [self.tableView reloadData];
        }else{
             [self.tableView.mj_footer endRefreshing];
             self.page--;
        }
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        self.page--;
        
    }];
    
    NSDictionary *dict = [UserDefault objectForKey:KuserDefaultsLocation];
    
    double localLng = [dict[@"lng"] doubleValue];
    double localLat = [dict[@"lat"] doubleValue];
    
    //    request.order = _type;
    request.schoolName = _schoolName;
    request.schoolType = self.schoolType;
    request.longitude= [NSString stringWithFormat:@"%f",localLng];
    request.latitude= [NSString stringWithFormat:@"%f",localLat];
    request.orderType = self.orderType;
    request.page = self.page;
    request.regionCode = self.regionCode;
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

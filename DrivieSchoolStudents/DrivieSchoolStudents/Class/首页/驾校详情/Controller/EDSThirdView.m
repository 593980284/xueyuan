//
//  EDSThirdView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSThirdView.h"
#import "EDSEDSDrivingDetailsHeaderView.h"
#import "EDSCoachInformationViewController.h"

#import "EDSCoachTableViewCell.h"

#import "EDSCoachListRequest.h"

#import "EDSCoachListModel.h"

@interface EDSThirdView()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView  *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray <EDSCoachListModel *> *listArr;

@end

@implementation EDSThirdView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    self.backgroundColor = WhiteColor;
    self.listArr = [[NSArray alloc] init];
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)setSchoolId:(NSString *)schoolId
{
    _schoolId = schoolId;
    [self requestData];
}

#pragma mark ------------------------ 网络请求 --------------------------------
- (void)requestData
{
    EDSCoachListRequest *request = [EDSCoachListRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            self.listArr = model;
            
            [self.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    request.schoolId = self.schoolId;
    request.showHUD = YES;
    [request  startRequest];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSCoachTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSCoachTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSCoachTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.coachModel = self.listArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSCoachInformationViewController *vc = [[EDSCoachInformationViewController alloc] init];
    vc.coachModel = self.listArr[indexPath.row];
    [self.parentView.navigationController  pushViewController:vc animated:YES];
}

#pragma mark - firstTableView的代理方法scrollViewDidScroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat placeHolderHeight = self.topView.wz_height - self.topView.itemHeight;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= 0 && offsetY <= placeHolderHeight) {
        
        self.topView.wz_y = -offsetY;
        self.topView.commentBgView.alpha = offsetY/placeHolderHeight;
        self.topView.driveSchoolBgView.alpha = 1 - offsetY/placeHolderHeight;
    }
    else if (offsetY > placeHolderHeight) {
        self.topView.wz_y = - placeHolderHeight;
        self.topView.commentBgView.alpha = 1.0;
        self.topView.driveSchoolBgView.alpha = 0.0;
    }
    else if (offsetY <0) {
        self.topView.wz_y =  - offsetY;
        self.topView.commentBgView.alpha = 0.0;
        self.topView.driveSchoolBgView.alpha = 1.0;
    }
}

@end

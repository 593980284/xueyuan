//
//  EDSFourView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFourView.h"
#import "EDSEDSDrivingDetailsHeaderView.h"

#import "EDSCheckSiteTableViewCell.h"

#import "EDSSchoolRegionModel.h"
#import "EDSSchoolRegionRequest.h"
#import "MJRefreshAutoNormalFooter.h"
#import "MJRefreshNormalHeader.h"

@interface EDSFourView()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, assign) NSInteger page;
/** 数据 */
@property (nonatomic, strong) NSArray<EDSSchoolRegionModel *>  *listArr;
@end

@implementation EDSFourView


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
//    self.tableView.separatorColor = ClearColor;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.tableView.tableFooterView = [UIView new];
    [self addSubview:self.tableView];
      self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData2)];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)requestData
{
    self.page = 1;
    EDSSchoolRegionRequest *request = [EDSSchoolRegionRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            self.listArr = model;
            
            [self.tableView reloadData];
        }
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer resetNoMoreData];
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
    request.schoolId = self.schoolId;
    request.page = _page;
    [request  startRequest];
}

- (void)requestData2
{
    self.page++;
    EDSSchoolRegionRequest *request = [EDSSchoolRegionRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, NSArray* model) {
        
        if (errCode == 1) {
            NSMutableArray *data = [self.listArr mutableCopy];
            if (model.count > 0) {
                  [self.tableView.mj_footer endRefreshing];
            }else{
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            self.listArr = data;
            [self.tableView reloadData];
        }else{
             [self.tableView.mj_footer endRefreshing];
        }
    } failureBlock:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
    
    request.schoolId = self.schoolId;
    request.page = _page;
    [request  startRequest];
}

- (void)setSchoolId:(NSString *)schoolId
{
    _schoolId = schoolId;
    [self requestData];
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
    EDSCheckSiteTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSCheckSiteTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSCheckSiteTableViewCell" owner:self options:nil].firstObject;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.regionModel = self.listArr[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

//#pragma mark - firstTableView的代理方法scrollViewDidScroll
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat placeHolderHeight = self.topView.wz_height - self.topView.itemHeight;
//    
//    CGFloat offsetY = scrollView.contentOffset.y;
//    
//    DLog(@"%f",offsetY);
//    
//    if (offsetY >= 0 && offsetY <= placeHolderHeight) {
//
//        self.topView.wz_y = -offsetY;
//        self.topView.commentBgView.alpha = offsetY/placeHolderHeight;
//        self.topView.driveSchoolBgView.alpha = 1 - offsetY/placeHolderHeight;
//    }
//    else if (offsetY > placeHolderHeight) {
//        self.topView.wz_y = - placeHolderHeight;
//        self.topView.commentBgView.alpha = 1.0;
//        self.topView.driveSchoolBgView.alpha = 0.0;
//    }
//    else if (offsetY <0) {
//        self.topView.wz_y =  - offsetY;
//        self.topView.commentBgView.alpha = 0.0;
//        self.topView.driveSchoolBgView.alpha = 1.0;
//    }
//}

@end

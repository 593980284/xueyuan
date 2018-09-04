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

@interface EDSFourView()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView  *tableView;
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
    self.tableView.separatorColor = ClearColor;
    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)requestData
{
    EDSSchoolRegionRequest *request = [EDSSchoolRegionRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
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

#pragma mark - firstTableView的代理方法scrollViewDidScroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat placeHolderHeight = self.topView.wz_height - self.topView.itemHeight;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    DLog(@"%f",offsetY);
    
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

//
//  EDSPracticeViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPracticeViewController.h"

#import "EDSPracticeHeaderView.h"
#import "EDSPracticeTableViewCell.h"
#import "EDSPracticeFooterView.h"

#import "EDSDataBase.h"

#import "EDSQuestionModel.h"

@interface EDSPracticeViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 数据 */
@property (nonatomic, strong) EDSQuestionModel  *tableViewModel;
/** 头部试图 */
@property (nonatomic, strong) EDSPracticeHeaderView  *headerView;
@end

@implementation EDSPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"练习";
    self.view.backgroundColor = WhiteColor;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = ClearColor;
    self.tableView.backgroundColor = WhiteColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-120);
    }];
    
    self.headerView.questionModel = self.tableViewModel;
    [self.tableView setTableHeaderView:self.headerView];
    [self.tableView.tableHeaderView layoutIfNeeded];
    
    
    EDSPracticeFooterView *footerView = [[EDSPracticeFooterView alloc] init];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(120);
    }];
    @weakify(self);
    footerView.practiceFooterViewDidSelectStringback = ^(NSString *titleStr) {
        @strongify(self);
        if ([titleStr  isEqualToString:@"下一题"]) {
            
            [self getNextQuestion];
        }
    };
}

#pragma mark ------------------------ 下一题 --------------------------------
- (void)getNextQuestion
{
    self.tableViewModel =  [[EDSDataBase sharedDataBase] getRandomSubjectFirst];
    
    self.headerView.questionModel = self.tableViewModel;
    [self.tableView setTableHeaderView:self.headerView];
    
    [self.tableView reloadData];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableViewModel.answerlists.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"EDSPracticeTableViewCell";
    // 2.从缓存池中取
    EDSPracticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[EDSPracticeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    EDSAnswerModel *answerModel = self.tableViewModel.answerlists[indexPath.row];
    
    int index = [[NSString stringWithFormat:@"%ld",(long)indexPath.row] intValue] ;
    
    index += 65;
    
    answerModel.answerR = [NSString stringWithFormat:@"%c",index];
    
    cell.answerModel = self.tableViewModel.answerlists[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableViewModel.isMultiple) {
        
        dispatch_apply(self.tableViewModel.answerlists.count, dispatch_get_global_queue(0, 0), ^(size_t i) {
            
            if (i == indexPath.row) {
                
                self.tableViewModel.answerlists[i].isChoose = YES;
            }else{
                
                self.tableViewModel.answerlists[i].isChoose = NO;
            }
        });
    }else{
        
        EDSAnswerModel *answerModel = self.tableViewModel.answerlists[indexPath.row];
        answerModel.isChoose = !answerModel.isChoose;
    }
    
    [self.tableView reloadData];
}

- (EDSQuestionModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        _tableViewModel =  [[EDSDataBase sharedDataBase] getRandomSubjectFirst];
    }
    return _tableViewModel;
}


- (EDSPracticeHeaderView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[EDSPracticeHeaderView alloc] init];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(kScreenWidth);
        }];
    }
    return _headerView;
}
@end

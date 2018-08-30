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

#import "EDSQuestionModel.h"

@interface EDSPracticeViewController ()<UITableViewDataSource,UITableViewDelegate>
/** 数据 */
@property (nonatomic, strong) EDSQuestionModel  *tableViewModel;
@end

@implementation EDSPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"错题回顾";
    self.view.backgroundColor = WhiteColor;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = ClearColor;
    self.tableView.backgroundColor = WhiteColor;
    
    EDSPracticeHeaderView *headerView = [[EDSPracticeHeaderView alloc] init];
    self.tableView.tableHeaderView = headerView;
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth);
    }];
    headerView.questionModel = self.tableViewModel;
    
    [self.tableView.tableHeaderView layoutIfNeeded];
    self.tableView.tableHeaderView = headerView;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
    EDSAnswerModel *answerModel = self.tableViewModel.answerlists[indexPath.row];
    answerModel.isChoose = YES;
    [self.tableView reloadData];
}

- (EDSQuestionModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        _tableViewModel = [[EDSQuestionModel alloc] init];
        _tableViewModel.isMultiple = YES;
        _tableViewModel.questionTitle = @"对未取得驾驶证驾驶机动车的追究其,法律责任对未取得驾驶证驾驶机动车的追究其法律责任。";
        _tableViewModel.questionPictureUrl = @"http://www.xinhuanet.com/politics/2018-08/29/1123348759_15355476801511n.jpg";
        
        NSMutableArray <EDSAnswerModel *>*arr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 5; i ++ ) {
            
            EDSAnswerModel *answer = [[EDSAnswerModel alloc] init];
            answer.answerTitle = @"六个月";
            answer.answerR = @"B";
            [arr addObject:answer];
        }
        _tableViewModel.answerlists  = arr;
    }
    return _tableViewModel;
}

@end

//
//  EDSSubjectFourRecitedPoliticsViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/17.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubjectFourRecitedPoliticsViewController.h"
#import "EDSClearRecordViewController.h"//清除
#import "PopAnimator.h"

#import "EDSPracticeHeaderView.h"
#import "EDSPracticeTableViewCell.h"
#import "EDSRecitedPoliticsFooterView.h"

#import "EDSFourDataBase.h"

#import "EDSQuestionModel.h"

@interface EDSSubjectFourRecitedPoliticsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isChooes;
}

@property (nonatomic, strong) PopAnimator *popAnimator;
/** 数据 */
@property (nonatomic, strong) EDSQuestionModel  *tableViewModel;
/** 头部试图 */
@property (nonatomic, strong) EDSPracticeHeaderView  *headerView;
/** 脚部试图 */
@property (nonatomic, strong) EDSRecitedPoliticsFooterView  *footerView;

@end

@implementation EDSSubjectFourRecitedPoliticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.title = @"背题";
    _isChooes = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
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
    
    
    self.footerView.ID = self.tableViewModel.ID;
    self.footerView.isCollection = self.tableViewModel.isCollection;
    
    @weakify(self);
    [self.footerView.nextBtn  bk_whenTapped:^{
        @strongify(self);
        [self getNextQuestion];
    }];
}

#pragma mark ------------------------ 下一题 --------------------------------
- (void)getNextQuestion
{
    self.tableView.allowsSelection = YES;
    
    if (self.tableViewModel.ID.length > 0) {
        
        NSString *ID = [EDSSave account].fourSubjectRecitedPoliticeID;
        NSInteger iD = ID.length > 0 ? [ID integerValue] + 1 : 1326;
        EDSAccount *account = [EDSSave account];
        account.fourSubjectRecitedPoliticeID = [NSString stringWithFormat:@"%ld",(long)iD];
        [EDSSave save:account];
        
        self.tableViewModel =  [[EDSFourDataBase sharedDataBase] getFourSubjectQuestionWithID:account.fourSubjectRecitedPoliticeID];
        _isChooes = YES;
        NSString *string = self.tableViewModel.answer;
        for (int i = 0; i < self.tableViewModel.answerlists.count; i ++) {
            
            self.tableViewModel.answerlists[i].isLook = YES;
            self.tableViewModel.answerlists[i].isSubjectFour = self.tableViewModel.isMultiple;
            
            int index = i;
            index += 65;
            NSString *answerstr = [NSString stringWithFormat:@"%c",index];
            
            if ([string rangeOfString:answerstr].location != NSNotFound) {
                
                self.tableViewModel.answerlists[i].isCorrect = YES;
                self.tableViewModel.answerlists[i].isChoose = YES;
            }
        }
        
        self.headerView.questionModel = self.tableViewModel;
        [self.tableView setTableHeaderView:self.headerView];
        
        self.footerView.ID = self.tableViewModel.ID;
        self.footerView.isCollection = self.tableViewModel.isCollection;
        
        [self.tableView reloadData];
    }else
    {
        [SVProgressHUD showInfoWithStatus:@"已是最后一题"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
    
}

#pragma mark ------------------------ 获取底部数据 --------------------------------
- (void)getFooterViewModel
{
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *bgView = [UIView viewWithBackgroundColor:WhiteColor superView:nil];
    UILabel *footerLbl = [UILabel labelWithText:@"" font:kFont(18) textColor:FirstColor backGroundColor:WhiteColor superView:bgView];
    footerLbl.text = [NSString stringWithFormat:@"答案：%@",self.tableViewModel.answer];//@"答案：B";
    [footerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    
    if (_isChooes) {
        
        footerLbl.hidden = NO;
    }else{
        
        footerLbl.hidden = YES;
    }
    
    return bgView;
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
   
}

//每隔4个字符添加一个空格的字符串算法
- (NSString *)dealWithString:(NSString *)number
{
    NSString *doneTitle = @"";
    int count = 0;
    for (int i = 0; i < number.length; i++) {
        
        count++;
        doneTitle = [doneTitle stringByAppendingString:[number substringWithRange:NSMakeRange(i, 1)]];
        if (count == 1) {
            doneTitle = [NSString stringWithFormat:@"%@,", doneTitle];
            count = 0;
        }
    }
    return doneTitle;
}

- (EDSQuestionModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        _tableViewModel =  [[EDSFourDataBase sharedDataBase] getFourSubjectQuestionWithID:[EDSSave account].fourSubjectRecitedPoliticeID];
        _isChooes = YES;
        NSString *string = self.tableViewModel.answer;
        for (int i = 0; i < self.tableViewModel.answerlists.count; i ++) {
            
            self.tableViewModel.answerlists[i].isLook = YES;
            self.tableViewModel.answerlists[i].isSubjectFour = self.tableViewModel.isMultiple;
            
            int index = i;
            index += 65;
            NSString *answerstr = [NSString stringWithFormat:@"%c",index];
            
            if ([string rangeOfString:answerstr].location != NSNotFound) {
                
                self.tableViewModel.answerlists[i].isCorrect = YES;
                self.tableViewModel.answerlists[i].isChoose = YES;
            }
        }
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


- (EDSRecitedPoliticsFooterView *)footerView
{
    if (!_footerView) {
        
        _footerView = [[EDSRecitedPoliticsFooterView alloc] init];
        [self getFooterViewModel];
        [self.view addSubview:_footerView];
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(120);
        }];
    }
    return _footerView;
}


@end

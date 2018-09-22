//
//  EDSSubjectFourExamErrorsViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/20.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubjectFourExamErrorsViewController.h"
#import "EDSClearRecordViewController.h"//清除
#import "PopAnimator.h"

#import "EDSPracticeHeaderView.h"
#import "EDSPracticeTableViewCell.h"
#import "EDSFourPracticeView.h"

#import "EDSFourDataBase.h"

#import "EDSQuestionModel.h"

@interface EDSSubjectFourExamErrorsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isChooes;
    NSInteger _currount;
    NSInteger _errorsCount;
    NSInteger _correctCount;
}

@property (nonatomic, strong) PopAnimator *popAnimator;
/** 数据 */
@property (nonatomic, strong) EDSQuestionModel  *tableViewModel;
/** 头部试图 */
@property (nonatomic, strong) EDSPracticeHeaderView  *headerView;
/** 脚部试图 */
@property (nonatomic, strong) EDSFourPracticeView  *footerView;

@end

@implementation EDSSubjectFourExamErrorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.title = @"错题回顾";
    _isChooes = NO;
    _currount = 0;
    _errorsCount = 0;
    _correctCount = 0;
    
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
    
    if (self.errorsArr.count > 0) {
        
        self.headerView.questionModel = self.tableViewModel;
    }else{
        
        [self.tableView removeFromSuperview];
        [self.footerView removeFromSuperview];
        
        UILabel *label = [UILabel labelWithText:@"您还没有错题" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.view];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(0);
        }];
    }
    
    [self.tableView setTableHeaderView:self.headerView];
    [self.tableView.tableHeaderView layoutIfNeeded];
    
    @weakify(self);
    if (self.tableViewModel.isMultiple) {
        [self.footerView.commitBtn setTitle:@"下一题" forState:UIControlStateNormal];
    }
    
    [self.footerView.commitBtn bk_whenTapped:^{
        
        @strongify(self);
        if ([self.footerView.commitBtn.titleLabel.text isEqualToString:@"下一题"]) {
            
            self.tableView.allowsSelection = YES;
            
            for (int i = 0; i < self.tableViewModel.answerlists.count; i ++) {
                
                if (self.tableViewModel.answerlists[i].isChoose) {
                    self->_isChooes = NO;
                    [self.footerView.commitBtn setTitle:@"提交" forState:UIControlStateNormal];
                    [self getNextQuestion];
                    return;
                }
            }
            
            [SVProgressHUD showErrorWithStatus:@"请做完本题"];
            [SVProgressHUD dismissWithDelay:1.5];
        }else{
            
            for (int i = 0; i < self.tableViewModel.answerlists.count; i ++) {
                
                if (self.tableViewModel.answerlists[i].isChoose) {
                    
                    [self.footerView.commitBtn setTitle:@"下一题" forState:UIControlStateNormal];
                    self.tableView.allowsSelection = NO;
                    //查看答案
                    self->_isChooes = YES;
                    [self getProcessCorrectAnswer];
                    return;
                }
            }
            
            [SVProgressHUD showErrorWithStatus:@"请做完本题"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    }];
}


#pragma mark ------------------------ 下一题 --------------------------------
- (void)getNextQuestion
{
    self.tableView.allowsSelection = YES;
    _currount ++ ;
    
    if (self.errorsArr.count > _currount) {
        
        self.tableViewModel =  [[EDSFourDataBase sharedDataBase] getFourSubjectQuestionWithID:self.errorsArr[_currount]];
        
        self.headerView.questionModel = self.tableViewModel;
        [self.tableView setTableHeaderView:self.headerView];
        [self getFooterViewModel];
        
        [self.tableView reloadData];
    }else
    {
        self.tableView.allowsSelection = NO;
        [SVProgressHUD showInfoWithStatus:@"已是最后一题"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
    
    if (self.tableViewModel.isMultiple) {
        
        [self.footerView.commitBtn setTitle:@"下一题" forState:UIControlStateNormal];
    }
}

#pragma mark ------------------------ 获取底部数据 --------------------------------
- (void)getFooterViewModel
{
    
    EDSFourPracticeViewModel *model = [[EDSFourPracticeViewModel alloc] init];
    model.ID = self.tableViewModel.ID;
    
    NSAttributedString *attStr = [NSString attributedStringWithColorTitle:[NSString stringWithFormat:@"/%lu",(unsigned long)self.errorsArr.count] normalTitle:@"" frontTitle:[NSString stringWithFormat:@"%ld",(long)_currount+1] diffentColor:ThirdColor];
    model.progressAttr = attStr;
    
    if (_isChooes) {
        
        model.correctStr = [NSString stringWithFormat:@"%ld",(_currount+1 - _errorsCount)];
    }else{
        
        model.correctStr = [NSString stringWithFormat:@"%ld",(_currount+1 - _errorsCount - 1)];
    }
    model.errorStr = [NSString stringWithFormat:@"%ld",(long)_errorsCount];
    
    model.isCollection = self.tableViewModel.isCollection;
    
    self.footerView.footerModel = model;
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
    if (self.tableViewModel.isMultiple) {
        
        dispatch_apply(self.tableViewModel.answerlists.count, dispatch_get_global_queue(0, 0), ^(size_t i) {
            
            self.tableViewModel.answerlists[i].isSubjectFour = YES;
            self.tableViewModel.answerlists[i].isSubjectFour = YES;
            if (i == indexPath.row) {
                
                self.tableViewModel.answerlists[i].isChoose = YES;
            }else{
                
                self.tableViewModel.answerlists[i].isChoose = NO;
            }
        });
        self.tableView.allowsSelection = NO;
        //查看答案
        self->_isChooes = YES;
        [self getProcessCorrectAnswer];
        
    }else{
        
        EDSAnswerModel *answerModel = self.tableViewModel.answerlists[indexPath.row];
        answerModel.isChoose = !answerModel.isChoose;
        answerModel.isSubjectFour = YES;
        [self.tableView reloadData];
    }
}


- (void)getProcessCorrectAnswer
{
    NSString *string = self.tableViewModel.answer;
    NSString *answeStr = @"";
    
    for (int i = 0; i < self.tableViewModel.answerlists.count; i ++) {
        
        self.tableViewModel.answerlists[i].isLook = YES;
        
        int index = i;
        
        index += 65;
        
        NSString *answerstr = [NSString stringWithFormat:@"%c",index];
        
        if ([string rangeOfString:answerstr].location != NSNotFound) {
            
            self.tableViewModel.answerlists[i].isCorrect = YES;
        }else{
            
            self.tableViewModel.answerlists[i].isCorrect = NO;
        }
        
        if (self.tableViewModel.answerlists[i].isChoose) {
            
            int index = i;
            index += 65;
            answeStr = [NSString stringWithFormat:@"%@%c",answeStr,index];
        }
    }
    
    if (![answeStr isEqualToString:string]) {
        //错题
//        [[EDSFourDataBase sharedDataBase] upDateFourSubjectErrorsWithID:self.tableViewModel.ID];
        _errorsCount ++ ;
    }
    
    [self getFooterViewModel];
    [self.tableView reloadData];
}



- (EDSQuestionModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        _tableViewModel =  [[EDSFourDataBase sharedDataBase] getFourSubjectQuestionWithID:self.errorsArr[_currount]];
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


- (EDSFourPracticeView *)footerView
{
    if (!_footerView) {
        
        _footerView = [[EDSFourPracticeView alloc] init];
        _footerView.clearBtn.hidden = YES;
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

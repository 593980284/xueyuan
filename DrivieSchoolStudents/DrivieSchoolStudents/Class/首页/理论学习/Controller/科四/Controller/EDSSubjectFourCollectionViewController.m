//
//  EDSSubjectFourCollectionViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/17.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubjectFourCollectionViewController.h"

#import "EDSClearRecordViewController.h"//清除
#import "PopAnimator.h"

#import "EDSPracticeHeaderView.h"
#import "EDSPracticeTableViewCell.h"
#import "EDSFourPracticeView.h"

#import "EDSFourDataBase.h"

#import "EDSQuestionModel.h"

@interface EDSSubjectFourCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isChooes;
    NSInteger _currentCount;
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

@implementation EDSSubjectFourCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.title = @"收藏";
    _isChooes = NO;
    
    _currentCount = 1;
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
    
    self.headerView.questionModel = self.tableViewModel;
    
    if (self.tableViewModel.ID.length == 0) {
        
        [self.tableView removeFromSuperview];
        [self.footerView removeFromSuperview];
        
        UILabel *label = [UILabel labelWithText:@"您还没有收藏题目" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.view];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(0);
        }];
    }
    
    [self.tableView setTableHeaderView:self.headerView];
    [self.tableView.tableHeaderView layoutIfNeeded];
    
    @weakify(self);
    self.footerView.practiceFooterViewDidSelectStringback = ^(NSString *titleStr) {
        @strongify(self);
        if ([titleStr isEqualToString:@"清除"]){
            
            DLog(@"11111");
            
            [self clearRecordQuestion];
        }
    };
    
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
            
//            [SVProgressHUD showErrorWithStatus:@"请做完本题"];
//            [SVProgressHUD dismissWithDelay:1.5];
            [self.view makeToast:@"请做完本题"];
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
            
//            [SVProgressHUD showErrorWithStatus:@"请做完本题"];
//            [SVProgressHUD dismissWithDelay:1.5];
            [self.view makeToast:@"请做完本题"];
        }
    }];
}

- (void)clearRecordQuestion
{
    CGFloat width = 300;
    
    CGFloat height = 180;
    
    CGRect coverFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    CGRect presentedFrame = CGRectMake((kScreenWidth - width)*0.5,175, width, height);
    
    self.popAnimator = [[PopAnimator alloc]initWithCoverFrame:coverFrame presentedFrame:presentedFrame startPoint:CGPointMake(0.5, 0.5) startTransform:CGAffineTransformMakeScale(0.5, 0.5) endTransform:CGAffineTransformMakeScale(0.0001, 0.0001)];
    
    self.popAnimator.isClose = YES;
    
    EDSClearRecordViewController *vc = [[EDSClearRecordViewController alloc] initWithNibName:@"EDSClearRecordViewController" bundle:[NSBundle mainBundle]];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    
    vc.view.layer.masksToBounds = YES;
    vc.view.layer.cornerRadius = 5;
    
    NSString *ID = [EDSSave account].firstSubjectID;
    
    NSInteger allcount = ID.length > 0 ? [ID intValue] : 1;
    vc.allCount =  _isChooes ? [NSString stringWithFormat:@"%ld",(long)allcount] : [NSString stringWithFormat:@"%ld",(long)allcount-1];
    NSInteger errCount = [[[EDSFourDataBase sharedDataBase] getOneFourSubjectErrorCount] intValue];
    vc.errorsCount = [NSString stringWithFormat:@"%ld",(long)errCount];
    if (_isChooes) {
        
        vc.correctCount = [NSString stringWithFormat:@"%ld",(allcount - errCount)];
    }else{
        
        vc.correctCount = [NSString stringWithFormat:@"%ld",(allcount - errCount - 1)];
    }
    
    @weakify(self);
    vc.clearRecordDidCommitBtn = ^{
        @strongify(self);
        [[EDSFourDataBase  sharedDataBase] clearFourSubjectAllWrongQuestions];
        EDSAccount *account = [EDSSave account];
        account.fourSubjectID = @"";
        [EDSSave save:account];
        [self getNextQuestion];
    };
    
    vc.transitioningDelegate = self.popAnimator;
    
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark ------------------------ 下一题 --------------------------------
- (void)getNextQuestion
{
    _currentCount ++ ;
    
    self.tableView.allowsSelection = YES;
    
    EDSQuestionModel *model = [[EDSFourDataBase sharedDataBase] getFourSubjectCollectionWithID:self.tableViewModel.ID];
    
    if (model.ID.length > 0) {
        
        self.tableViewModel = model;
        
        self.headerView.questionModel = self.tableViewModel;
        [self.tableView setTableHeaderView:self.headerView];
        
        [self getFooterViewModel];
        
        [self.tableView reloadData];
    }else
    {
        self.tableView.allowsSelection = NO;
//        [SVProgressHUD showInfoWithStatus:@"已是最后一题"];
//        [SVProgressHUD dismissWithDelay:1.5];
        [self.view makeToast:@"已是最后一题"];
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
    
    NSAttributedString *attStr = [NSString attributedStringWithColorTitle:[NSString stringWithFormat:@"/%@",[[EDSFourDataBase sharedDataBase] getFourSubjectCollectionCount]] normalTitle:@"" frontTitle:[NSString stringWithFormat:@"%ld",(long)_currentCount] diffentColor:ThirdColor];
    model.progressAttr = attStr;
    
    model.correctStr = [NSString stringWithFormat:@"%ld",_correctCount];
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
        _errorsCount ++ ;
        //错题
//        [[EDSFourDataBase sharedDataBase] upDateFourSubjectErrorsWithID:self.tableViewModel.ID];
    }else{
        
        //正确
        _correctCount ++ ;
        [self getFooterViewModel];
    }
    
    [self getFooterViewModel];
    [self.tableView reloadData];
}

- (EDSQuestionModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        _tableViewModel =  [[EDSFourDataBase sharedDataBase] getFourSubjectCollectionWithID:@""];
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
        [self getFooterViewModel];
        [self.view addSubview:_footerView];
        _footerView.clearBtn.hidden = YES;
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(120);
        }];
    }
    return _footerView;
}

@end

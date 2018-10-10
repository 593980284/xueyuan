//
//  EDSSubjectFourPracticeViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/15.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubjectFourPracticeViewController.h"
#import "EDSClearRecordViewController.h"//清除
#import "PopAnimator.h"

#import "EDSPracticeHeaderView.h"
#import "EDSPracticeTableViewCell.h"
#import "EDSFourPracticeView.h"

#import "EDSFourDataBase.h"

#import "EDSQuestionModel.h"

@interface EDSSubjectFourPracticeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isChooes;
}

@property (nonatomic, strong) PopAnimator *popAnimator;
/** 数据 */
@property (nonatomic, strong) EDSQuestionModel  *tableViewModel;
/** 头部试图 */
@property (nonatomic, strong) EDSPracticeHeaderView  *headerView;
/** 脚部试图 */
@property (nonatomic, strong) EDSFourPracticeView  *footerView;

@end

@implementation EDSSubjectFourPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.title = @"练习";
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
    
    @weakify(self);
    self.footerView.practiceFooterViewDidSelectStringback = ^(NSString *titleStr) {
        @strongify(self);
        if ([titleStr isEqualToString:@"清除"]){
            
            [self clearRecordQuestion];
        }else if ([titleStr isEqualToString:@"收藏"]){
            
            if (self.tableViewModel.isCollection) {
                
                if ([[EDSFourDataBase sharedDataBase] upDataFourSubjectunCollectionWithID:self.tableViewModel.ID]) {
                    
                    self.tableViewModel.isCollection = NO;
//                    [SVProgressHUD showSuccessWithStatus:@"取消收藏成功"];
//                    [SVProgressHUD dismissWithDelay:1.5];
                    [self.view makeToast:@"取消收藏成功"];
                }else{
                    
//                    [SVProgressHUD showSuccessWithStatus:@"请重试"];
//                    [SVProgressHUD dismissWithDelay:1.5];
                    [self.view makeToast:@"请重试"];
                }
            }else{
                
                if ([[EDSFourDataBase sharedDataBase] upDataFourSubjectCollectionWithID:self.tableViewModel.ID]) {
                    
                    self.tableViewModel.isCollection = YES;
//                    [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
//                    [SVProgressHUD dismissWithDelay:1.5];
                    [self.view makeToast:@"收藏成功"];
                }else{
                    
//                    [SVProgressHUD showSuccessWithStatus:@"请重试"];
//                    [SVProgressHUD dismissWithDelay:1.5];
                    [self.view makeToast:@"请重试"];
                }
            }
            
            [self getFooterViewModel];
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isChooes) {
        
        NSString *ID = [EDSSave account].fourSubjectID;
        NSInteger iD = ID.length > 0 ? [ID integerValue] + 1 : 1326;
        EDSAccount *account = [EDSSave account];
        account.fourSubjectID = [NSString stringWithFormat:@"%ld",(long)iD];
        [EDSSave save:account];
    }
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
    self.tableView.allowsSelection = YES;
    
    NSString *ID = [EDSSave account].fourSubjectID;
    NSInteger iD = ID.length > 0 ? [ID integerValue] + 1 : 1326;
    EDSAccount *account = [EDSSave account];
    account.fourSubjectID = [NSString stringWithFormat:@"%ld",(long)iD];
    [EDSSave save:account];
    
    self.tableViewModel =  [[EDSFourDataBase sharedDataBase] getFourSubjectQuestionWithID:account.fourSubjectID];
    
    if (self.tableViewModel.ID.length > 0) {
        
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
    NSString *ID = [EDSSave account].fourSubjectID;
    
    NSInteger allcount = ID.length > 0 ? [ID intValue] - 1325 : 1;
    
    EDSFourPracticeViewModel *model = [[EDSFourPracticeViewModel alloc] init];
    model.ID = self.tableViewModel.ID;
    
    NSAttributedString *attStr = [NSString attributedStringWithColorTitle:@"/1236" normalTitle:@"" frontTitle:[NSString stringWithFormat:@"%ld",(long)allcount] diffentColor:ThirdColor];
    model.progressAttr = attStr;
    
    NSInteger errCount = [[[EDSFourDataBase sharedDataBase] getOneFourSubjectErrorCount] intValue];
    if (_isChooes) {
        
        model.correctStr = [NSString stringWithFormat:@"%ld",(allcount - errCount)];
    }else{
        
        model.correctStr = [NSString stringWithFormat:@"%ld",(allcount - errCount - 1)];
    }
    model.errorStr = [NSString stringWithFormat:@"%ld",(long)errCount];
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
        [[EDSFourDataBase sharedDataBase] upDateFourSubjectErrorsWithID:self.tableViewModel.ID];
    }
    
    [self getFooterViewModel];
    [self.tableView reloadData];
}



- (EDSQuestionModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        NSString *ID = [EDSSave account].fourSubjectID;
        ID = ID.length > 0 ? ID : @"1326";
        EDSAccount *account = [EDSSave account];
        account.fourSubjectID = [NSString stringWithFormat:@"%@",ID];
        [EDSSave save:account];
        
        _tableViewModel =  [[EDSFourDataBase sharedDataBase] getFourSubjectQuestionWithID:ID];
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
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(120);
        }];
    }
    return _footerView;
}

@end

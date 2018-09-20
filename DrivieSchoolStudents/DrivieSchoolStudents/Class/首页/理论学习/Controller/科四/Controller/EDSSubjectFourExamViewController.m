//
//  EDSSubjectFourExamViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/19.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubjectFourExamViewController.h"
#import "EDSFirstSubjectResultsViewController.h"
#import "EDSTheirPapersBoxViewController.h"
#import "EDSFirstSubjectResultsViewController.h"

#import "EDSPracticeHeaderView.h"
#import "EDSFirstSubjectExamFooterView.h"
#import "EDSPracticeTableViewCell.h"
#import "ZQCountDownView.h"
#import "PopAnimator.h"

#import "EDSFourSubjectExamBase.h"
#import "EDSFourDataBase.h"

#import "EDSQuestionModel.h"

@interface EDSSubjectFourExamViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _currentCount;//当前多少题
    
    NSIndexPath *_indexPath;
    BOOL _isChooes;
}

@property (nonatomic, strong) PopAnimator *popAnimator;

@property (nonatomic, strong) UITableView  *tableView;
/** 倒计时 */
@property (nonatomic, strong) ZQCountDownView  *countDownView;
/** 交卷&提交答案&下一题 */
@property (nonatomic, strong) UIButton  *nextBtn;
/** 数据 */
@property (nonatomic, strong) EDSQuestionModel  *tableViewModel;
/** 头部试图 */
@property (nonatomic, strong) EDSPracticeHeaderView  *headerView;
/** 脚部试图 */
@property (nonatomic, strong) EDSFirstSubjectExamFooterView  *footerView;
/** 科目一id数组 */
@property (nonatomic, strong) NSMutableArray  *subjectMulIDArr;
/** 错题id数组 */
@property (nonatomic, strong) NSMutableArray  *errorsMulIDArr;

@end

@implementation EDSSubjectFourExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"考试";
    self.view.backgroundColor = WhiteColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = ClearColor;
    self.tableView.backgroundColor = WhiteColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.countDownView.mas_bottom);
        make.bottom.mas_equalTo(self.nextBtn.mas_top).mas_equalTo(-10);
    }];
    
    
    @weakify(self);
    [self.nextBtn  bk_whenTapped:^{
        @strongify(self);
        
        [self setFooterViewModel];
        
        if (self->_isChooes) {
            
            if (self->_currentCount == 50) {
                
                EDSFirstSubjectResultsViewController *vc = [[EDSFirstSubjectResultsViewController alloc] initWithNibName:@"EDSFirstSubjectResultsViewController" bundle:[NSBundle mainBundle]];
                
                EDSFirstSubjectExamResultModel *model = [[EDSFirstSubjectExamResultModel alloc] init];
                model.time = [NSString stringWithFormat:@"%f",self.countDownView.countDownTimeInterval];
                model.errors = [NSString stringWithFormat:@"%lu",(unsigned long)self.errorsMulIDArr.count];
                model.right = [NSString stringWithFormat:@"%lu",self->_isChooes ? self->_currentCount - self.errorsMulIDArr.count : self->_currentCount - self.errorsMulIDArr.count -1];
                model.isFour = YES;
                vc.errorsArr = [NSArray arrayWithArray:self.errorsMulIDArr];
                vc.resultModel = model;
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                
                [self getNextQuestion];
            }
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"请先做完本题"];
            [SVProgressHUD dismissWithDelay:1.5];
            return;
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.countDownView.countDownTimeInterval = 1800;
    [self.countDownView startCountDown];
    self.errorsMulIDArr = [[NSMutableArray alloc] init];
    _currentCount = 1;
    _indexPath = [NSIndexPath indexPathForItem:-1 inSection:-1];
    _isChooes = NO;
    self.tableView.allowsSelection = YES;
    self.subjectMulIDArr = [[NSMutableArray alloc] initWithArray:[[EDSFourSubjectExamBase sharedDataBase] getFourSubjectExam]];
    self.tableViewModel = [[EDSFourDataBase sharedDataBase] getFourSubjectQuestionWithID:self.subjectMulIDArr[_currentCount-1]];
    
    self.headerView.questionModel = self.tableViewModel;
    CGFloat height = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = self.headerView.bounds;
    frame.size.height = height;
    self.headerView.frame = frame;
    [self.tableView setTableHeaderView:self.headerView];
    [self setFooterViewModel];
    [self.tableView reloadData];
}

#pragma mark ------------------------ 设置底部数据 --------------------------------
- (void)setFooterViewModel
{
    
    EDSFirstSubjectExamFooterModel *model = [[EDSFirstSubjectExamFooterModel alloc] init];
    
    NSAttributedString *attStr = [NSString attributedStringWithColorTitle:@"/50" normalTitle:@"" frontTitle:[NSString stringWithFormat:@"%ld",(long)_currentCount] diffentColor:ThirdColor];
    
    model.attar = attStr;
    model.correctstr =  _isChooes ? [NSString stringWithFormat:@"%ld",(long)_currentCount - self.errorsMulIDArr.count] :  [NSString stringWithFormat:@"%ld",(long)_currentCount - self.errorsMulIDArr.count - 1];
    model.errorsstr = [NSString stringWithFormat:@"%ld",(long)self.errorsMulIDArr.count];
    
    self.footerView.footerModel = model;
}


#pragma mark ------------------------ 下一题 --------------------------------
- (void)getNextQuestion
{
    [self getProcessCorrectAnswer];
    _currentCount ++ ;
    
    _isChooes = NO;
    
    self.tableView.allowsSelection = YES;
    
    if (_currentCount == 50) {
        
        [self.nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    }else{
        
        [self.nextBtn setTitle:@"下一题" forState:UIControlStateNormal];
    }
    
    self.tableViewModel = [[EDSFourDataBase sharedDataBase] getFourSubjectQuestionWithID:self.subjectMulIDArr[_currentCount-1]];
    
    self.headerView.questionModel = self.tableViewModel;
    CGFloat height = [self.headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    CGRect frame = self.headerView.bounds;
    frame.size.height = height;
    self.headerView.frame = frame;
    [self.tableView setTableHeaderView:self.headerView];
    
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self.tableView reloadData];
    
    [self setFooterViewModel];
}

#pragma mark ------------------------ 交卷 --------------------------------
- (void)putTheirPapers
{
    [self.countDownView pauseCountDown];
    
    //方法一
    if (_isChooes) {
        
        [self getProcessCorrectAnswer];
    }
    [self setFooterViewModel];
    self.tableView.allowsSelection = _isChooes ? NO : YES;
    
    CGFloat width = 300;
    
    CGFloat height = 180;
    
    CGRect coverFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    CGRect presentedFrame = CGRectMake((kScreenWidth - width)*0.5, 175, width, height);
    
    self.popAnimator = [[PopAnimator alloc]initWithCoverFrame:coverFrame presentedFrame:presentedFrame startPoint:CGPointMake(0.5, 0.5) startTransform:CGAffineTransformMakeScale(0.5, 0.5) endTransform:CGAffineTransformMakeScale(0.0001, 0.0001)];
    
    self.popAnimator.isClose = YES;
    
    EDSTheirPapersBoxViewController *vc = [[EDSTheirPapersBoxViewController alloc] initWithNibName:@"EDSTheirPapersBoxViewController" bundle:[NSBundle mainBundle]];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    
    vc.view.layer.masksToBounds = YES;
    vc.view.layer.cornerRadius = 5;
    
    vc.isFour = YES;
    vc.correctCount = _isChooes ? _currentCount : _currentCount -1;
    vc.errortCount = self.errorsMulIDArr.count;
    
    vc.transitioningDelegate = self.popAnimator;
    @weakify(self);
    vc.theirPapersBoxViewBackDidBtnString = ^(NSString *string) {
        @strongify(self);
        if ([string isEqualToString:@"交卷"]) {
            
            EDSFirstSubjectResultsViewController *vc = [[EDSFirstSubjectResultsViewController alloc] initWithNibName:@"EDSFirstSubjectResultsViewController" bundle:[NSBundle mainBundle]];
            
            EDSFirstSubjectExamResultModel *model = [[EDSFirstSubjectExamResultModel alloc] init];
            model.time = [NSString stringWithFormat:@"%f",self.countDownView.countDownTimeInterval];
            //            model.errors = @"0";
            //            model.right = @"100";
            model.errors = [NSString stringWithFormat:@"%lu",(unsigned long)self.errorsMulIDArr.count];
            model.right = [NSString stringWithFormat:@"%lu",self->_isChooes ? self->_currentCount - self.errorsMulIDArr.count : self->_currentCount - self.errorsMulIDArr.count -1];
            model.isFour = YES;
            vc.errorsArr = [NSArray arrayWithArray:self.errorsMulIDArr];
            vc.resultModel = model;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else{
            
            [self.countDownView startCountDown];
        }
    };
    
    [self presentViewController:vc animated:YES completion:nil];
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
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView viewWithBackgroundColor:ClearColor superView:nil];
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
    for (int i = 0; i < self.tableViewModel.answerlists.count; i ++) {
        
        if (self.tableViewModel.answerlists[i].isChoose) {
            footerLbl.hidden = NO;
            break;
        }else{
            
            footerLbl.hidden = YES;
        }
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
            
            if (i == indexPath.row) {
                
                self.tableViewModel.answerlists[i].isChoose = YES;
                self.tableViewModel.answerlists[i].isCorrect = YES;
            }else{
                
                self.tableViewModel.answerlists[i].isChoose = NO;
                self.tableViewModel.answerlists[i].isCorrect = NO;
            }
        });
        //查看答案
        self->_isChooes = YES;
        [self.tableView reloadData];
        
    }else{
        
        EDSAnswerModel *answerModel = self.tableViewModel.answerlists[indexPath.row];
        answerModel.isChoose = !answerModel.isChoose;
        answerModel.isSubjectFour = NO;
        answerModel.isCorrect = YES;
        self->_isChooes = YES;
        [self.tableView reloadData];
    }
}

- (void)getProcessCorrectAnswer
{
    NSString *string = self.tableViewModel.answer;
    NSString *answeStr = @"";
    
    for (int i = 0; i < self.tableViewModel.answerlists.count; i ++) {
        
        int index = i;
        
        index += 65;
        
        if (self.tableViewModel.answerlists[i].isChoose) {
            
            int index = i;
            index += 65;
            answeStr = [NSString stringWithFormat:@"%@%c",answeStr,index];
        }
    }
    
    if (![answeStr isEqualToString:string]) {
        //错题
        if (![self.errorsMulIDArr containsObject:self.subjectMulIDArr[_currentCount]]) {
            
            [self.errorsMulIDArr addObject:self.subjectMulIDArr[_currentCount]];
        }
        //添加错题
        [[EDSFourDataBase sharedDataBase] upDateFourSubjectErrorsWithID:self.subjectMulIDArr[_currentCount]];
    }
    
    [self.tableView reloadData];
}


- (EDSQuestionModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        self.tableViewModel = [[EDSFourDataBase sharedDataBase] getFourSubjectQuestionWithID:self.subjectMulIDArr[_currentCount-1]];
    }
    return _tableViewModel;
}

- (NSMutableArray *)subjectMulIDArr
{
    if (!_subjectMulIDArr) {
        
        _subjectMulIDArr = [[NSMutableArray alloc] initWithArray:[[EDSFourSubjectExamBase sharedDataBase] getFourSubjectExam]];
    }
    return _subjectMulIDArr;
}

- (EDSPracticeHeaderView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[EDSPracticeHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    }
    return _headerView;
}

- (EDSFirstSubjectExamFooterView *)footerView
{
    if (!_footerView) {
        
        _footerView = [[EDSFirstSubjectExamFooterView alloc] init];
        [self.view addSubview:_footerView];
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(51);
        }];
        
        @weakify(self);
        [_footerView.commitBtn bk_whenTapped:^{
            @strongify(self);
            
            [self putTheirPapers];
        }];
    }
    return _footerView;
}

- (ZQCountDownView *)countDownView
{
    if (!_countDownView) {
        
        UIImageView *imageView = [UIImageView imageViewWithSuperView:self.view];
        imageView.image = [UIImage imageNamed:@"kscj_content_icon_time"];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        
        _countDownView = [[ZQCountDownView alloc] initWithFrame:CGRectMake(20, 6, 60, 30)];
        _countDownView.themeColor = WhiteColor;
        _countDownView.textColor = FirstColor;
        _countDownView.textFont = kFont(14);
        [self.view addSubview:_countDownView];
        [_countDownView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageView.mas_centerY);
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
    }
    return _countDownView;
}

- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        
        _nextBtn = [[UIButton alloc] init];
        [self.view addSubview:_nextBtn];
        [_nextBtn setTitle:@"下一题" forState:UIControlStateNormal];
        _nextBtn.backgroundColor = ThemeColor;
        _nextBtn.layer.masksToBounds = YES;
        _nextBtn.layer.cornerRadius = 5;
        _nextBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(105);
            make.right.mas_equalTo(-105);
            make.height.mas_equalTo(45);
            make.bottom.mas_equalTo(self.footerView.mas_top).mas_equalTo(-15);
        }];
    }
    return _nextBtn;
}

@end

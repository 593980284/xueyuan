//
//  EDSPracticeViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPracticeViewController.h"
#import "EDSClearRecordViewController.h"//清除
#import "PopAnimator.h"

#import "EDSPracticeHeaderView.h"
#import "EDSPracticeTableViewCell.h"
#import "EDSPracticeFooterView.h"

#import "EDSDataBase.h"

#import "EDSQuestionModel.h"

@interface EDSPracticeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isChooes;
}

@property (nonatomic, strong) PopAnimator *popAnimator;
/** 数据 */
@property (nonatomic, strong) EDSQuestionModel  *tableViewModel;
/** 头部试图 */
@property (nonatomic, strong) EDSPracticeHeaderView  *headerView;
/** 脚部试图 */
@property (nonatomic, strong) EDSPracticeFooterView  *footerView;

@end

@implementation EDSPracticeViewController

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
        if ([titleStr isEqualToString:@"下一题"]) {
            
            for (int i = 0; i < self.tableViewModel.answerlists.count; i ++) {
                
                if (self.tableViewModel.answerlists[i].isChoose) {
                    self->_isChooes = NO;
                    [self getNextQuestion];
                    return;
                }
            }
            
            [self.view makeToast:@"请做完本题"];
        }else if ([titleStr isEqualToString:@"收藏"]){
            
            if (self.tableViewModel.isCollection) {
                
                if ([[EDSDataBase sharedDataBase] upDataFirstSubjectunCollectionWithID:self.tableViewModel.ID]) {
                    
                    self.tableViewModel.isCollection = NO;
                    [self.view makeToast:@"取消收藏成功"];
                }else{
                    
                    [self.view makeToast:@"请重试"];
                }
            }else{
                
                if ([[EDSDataBase sharedDataBase] upDataFirstSubjectCollectionWithID:self.tableViewModel.ID]) {
                    
                    self.tableViewModel.isCollection = YES;
                    [self.view makeToast:@"收藏成功"];
                }else{
                    
                    [self.view makeToast:@"请重试"];
                }
            }
            [self getFooterViewModel];
            
        }else if ([titleStr isEqualToString:@"清除"]){
            
            DLog(@"11111");
            
            [self clearRecordQuestion];
        }
    };
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_isChooes) {
        
        NSString *ID = [EDSSave account].firstSubjectID;
        NSInteger iD = ID.length > 0 ? [ID integerValue] + 1 : 1;
        EDSAccount *account = [EDSSave account];
        account.firstSubjectID = [NSString stringWithFormat:@"%ld",(long)iD];
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
    NSInteger errCount = [[[EDSDataBase sharedDataBase] getOneFirstSubjectErrorCount] intValue];
    vc.errorsCount = [NSString stringWithFormat:@"%ld",(long)errCount];
    if (_isChooes) {
        
        vc.correctCount = [NSString stringWithFormat:@"%ld",(allcount - errCount)];
    }else{
        
        vc.correctCount = [NSString stringWithFormat:@"%ld",(allcount - errCount - 1)];
    }
    
    @weakify(self);
    vc.clearRecordDidCommitBtn = ^{
        @strongify(self);
        [[EDSDataBase  sharedDataBase] clearFirstSubjectAllWrongQuestions];
        EDSAccount *account = [EDSSave account];
        account.firstSubjectID = @"";
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
    
    NSString *ID = [EDSSave account].firstSubjectID;
    NSInteger iD = ID.length > 0 ? [ID integerValue] + 1 : 1;
    EDSAccount *account = [EDSSave account];
    account.firstSubjectID = [NSString stringWithFormat:@"%ld",(long)iD];
    [EDSSave save:account];
    
    self.tableViewModel = [[EDSDataBase sharedDataBase] getSubjectFirstQuestion];
    
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
}

#pragma mark ------------------------ 获取底部数据 --------------------------------
- (void)getFooterViewModel
{
    NSString *ID = [EDSSave account].firstSubjectID;
    
    NSInteger allcount = ID.length > 0 ? [ID intValue] : 1;
    
    EDSPractioceFooterModel *model = [[EDSPractioceFooterModel alloc] init];
    model.ID = self.tableViewModel.ID;
    
    NSAttributedString *attStr = [NSString attributedStringWithColorTitle:[NSString stringWithFormat:@"/%@",[[EDSDataBase sharedDataBase] getOneFirstSubjectCount]] normalTitle:@"" frontTitle:[NSString stringWithFormat:@"%ld",(long)allcount] diffentColor:ThirdColor];
    model.progressAttr = attStr;
    
    NSInteger errCount = [[[EDSDataBase sharedDataBase] getOneFirstSubjectErrorCount] intValue];
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
    _isChooes = YES;
    
    if (self.tableViewModel.isMultiple) {
        
        dispatch_apply(self.tableViewModel.answerlists.count, dispatch_get_global_queue(0, 0), ^(size_t i) {
            
            if (i == indexPath.row) {
                
                self.tableViewModel.answerlists[i].isChoose = YES;
            }else{
                
                self.tableViewModel.answerlists[i].isChoose = NO;
            }
        });
        self.tableView.allowsSelection = NO;
    }else{
        
        EDSAnswerModel *answerModel = self.tableViewModel.answerlists[indexPath.row];
        answerModel.isChoose = !answerModel.isChoose;
    }
    [self getProcessCorrectAnswerWithIndex:indexPath.row];
    [self.tableView reloadData];
}


- (void)getProcessCorrectAnswerWithIndex:(NSInteger)index
{
    
    for (int i = 0; i < self.tableViewModel.answerlists.count; i ++) {
        
        NSString *string = self.tableViewModel.answerlists[i].answerR;
        
        if ([string isEqualToString:self.tableViewModel.answer]) {
            
            self.tableViewModel.answerlists[i].isCorrect = YES;
            if (i != index) {
                //错题
                [[EDSDataBase sharedDataBase] upDateFirstSubjectErrorsWithID:self.tableViewModel.ID];
                [self getFooterViewModel];
            }else{
                
                [self getFooterViewModel];
            }
        }else{
            
            self.tableViewModel.answerlists[i].isCorrect = NO;
        }
    }
    
}

- (EDSQuestionModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        NSString *ID = [EDSSave account].firstSubjectID;
        ID = ID.length > 0 ? ID : @"1";
        EDSAccount *account = [EDSSave account];
        account.firstSubjectID = [NSString stringWithFormat:@"%@",ID];
        [EDSSave save:account];
        
        _tableViewModel =  [[EDSDataBase sharedDataBase] getSubjectFirstQuestion];
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


- (EDSPracticeFooterView *)footerView
{
    if (!_footerView) {
        
        _footerView = [[EDSPracticeFooterView alloc] init];
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

//
//  EDSEorrorsViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/8.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSEorrorsViewController.h"

#import "EDSPracticeHeaderView.h"
#import "EDSPracticeTableViewCell.h"
#import "EDSPracticeFooterView.h"

#import "EDSDataBase.h"

#import "EDSQuestionModel.h"

@interface EDSEorrorsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _currentCount;
    NSInteger _errorsCount;
    NSInteger _correctCount;
}

/** 数据 */
@property (nonatomic, strong) EDSQuestionModel  *tableViewModel;
/** 头部试图 */
@property (nonatomic, strong) EDSPracticeHeaderView  *headerView;
/** 脚部试图 */
@property (nonatomic, strong) EDSPracticeFooterView  *footerView;


@end

@implementation EDSEorrorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"错题回顾";

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
        
        UILabel *label = [UILabel labelWithText:@"您还没有错题" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.view];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(0);
        }];
    }
    
    [self.tableView setTableHeaderView:self.headerView];
    [self.tableView.tableHeaderView layoutIfNeeded];
    
    
    @weakify(self);
    self.footerView.practiceFooterViewDidSelectStringback = ^(NSString *titleStr) {
        @strongify(self);
        if ([titleStr isEqualToString:@"下一题"]) {
            
            for (int i = 0; i < self.tableViewModel.answerlists.count; i ++) {
                
                if (self.tableViewModel.answerlists[i].isChoose) {
                    [self getNextQuestion];
                    return;
                }
            }
            
            [SVProgressHUD showErrorWithStatus:@"请做完本题"];
            [SVProgressHUD dismissWithDelay:1.5];
        }else if ([titleStr isEqualToString:@"收藏"]){
            
            [[EDSDataBase sharedDataBase] getFirstSubjectErrorWithID:self.tableViewModel.ID];
        }
    };
}

#pragma mark ------------------------ 下一题 --------------------------------
- (void)getNextQuestion
{
    _currentCount ++ ;
    
    self.tableView.allowsSelection = YES;
    
    EDSQuestionModel *model = [[EDSDataBase sharedDataBase] getFirstSubjectErrorWithID:self.tableViewModel.ID];
    
    if (model.ID.length > 0) {
        
        self.tableViewModel = model;
        
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
    
}

#pragma mark ------------------------ 获取footerView数据 --------------------------------
- (void)getFooterViewModel
{
    EDSPractioceFooterModel *model = [[EDSPractioceFooterModel alloc] init];
    model.ID = self.tableViewModel.ID;
    
    NSAttributedString *attStr = [NSString attributedStringWithColorTitle:[NSString stringWithFormat:@"/%@",[[EDSDataBase sharedDataBase] getOneFirstSubjectErrorCount]] normalTitle:@"" frontTitle:[NSString stringWithFormat:@"%ld",(long)_currentCount] diffentColor:ThirdColor];
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
                _errorsCount ++ ;
                [[EDSDataBase sharedDataBase] upDateFirstSubjectErrorsWithID:[EDSSave account].firstSubjectID];
                [self getFooterViewModel];
            }else{
                //正确
                _correctCount ++ ;
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
        
        _tableViewModel = [[EDSDataBase sharedDataBase] getFirstSubjectErrorWithID:@""];
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

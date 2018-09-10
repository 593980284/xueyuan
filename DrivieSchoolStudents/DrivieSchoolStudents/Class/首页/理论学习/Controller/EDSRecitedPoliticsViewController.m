//
//  EDSRecitedPoliticsViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/10.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSRecitedPoliticsViewController.h"

#import "EDSPracticeHeaderView.h"
#import "EDSRecitedPoliticsFooterView.h"
#import "EDSPracticeTableViewCell.h"

#import "EDSDataBase.h"

#import "EDSQuestionModel.h"

@interface EDSRecitedPoliticsViewController ()<UITableViewDataSource,UITableViewDelegate>
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
@property (nonatomic, strong) EDSRecitedPoliticsFooterView  *footerView;

@end

@implementation EDSRecitedPoliticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.title = @"背题";
    
    
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
    self.tableView.allowsSelection = NO;
    
    self.headerView.questionModel = self.tableViewModel;
    
    if (self.tableViewModel.ID.length == 0) {
        
        [self.tableView removeFromSuperview];
        
        UILabel *label = [UILabel labelWithText:@"您还没有收藏题目" font:kFont(14) textColor:SecondColor backGroundColor:ClearColor superView:self.view];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(0);
        }];
    }
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
    _currentCount ++ ;
    
    NSString *firstSubjectRecitedPoliticeID = [EDSSave account].firstSubjectRecitedPoliticeID;
    NSInteger ID = [firstSubjectRecitedPoliticeID intValue];
    ID ++ ;
    
    EDSAccount *account = [EDSSave account];
    account.firstSubjectRecitedPoliticeID = [NSString stringWithFormat:@"%ld",(long)ID];
    [EDSSave save:account];
    
    EDSQuestionModel *model = [[EDSDataBase sharedDataBase] getFirstSubjectRecitePolitcsWithID:[NSString stringWithFormat:@"%ld",(long)ID]];
    
    if (model.ID.length > 0) {
        
        self.tableViewModel = model;
        
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
//                [self getFooterViewModel];
            }else{
                //正确
                _correctCount ++ ;
//                [self getFooterViewModel];
            }
        }else{
            
            self.tableViewModel.answerlists[i].isCorrect = NO;
        }
    }
    
}

- (EDSQuestionModel *)tableViewModel
{
    if (!_tableViewModel) {
        
        NSString *firstSubjectRecitedPoliticeID = [EDSSave account].firstSubjectRecitedPoliticeID;
        firstSubjectRecitedPoliticeID = firstSubjectRecitedPoliticeID.length > 0 ? firstSubjectRecitedPoliticeID : @"1";
        _tableViewModel = [[EDSDataBase sharedDataBase] getFirstSubjectRecitePolitcsWithID:firstSubjectRecitedPoliticeID];
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
        [self.view addSubview:_footerView];
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(120);
        }];
    }
    return _footerView;
}

@end

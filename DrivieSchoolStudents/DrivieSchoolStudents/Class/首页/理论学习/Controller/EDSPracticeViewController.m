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
/** 脚部试图 */
@property (nonatomic, strong) EDSPracticeFooterView  *footerView;

@end

@implementation EDSPracticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    
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
                    [self getNextQuestion];
                    return;
                }
            }
            
            [SVProgressHUD showErrorWithStatus:@"请做完本题"];
            [SVProgressHUD dismissWithDelay:1.5];
        }else if ([titleStr isEqualToString:@"收藏"]){
            
            [[EDSDataBase sharedDataBase] upDataFirstSubjectCollectionWithID:[EDSSave account].firstSubjectID];
        }
    };
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
    
    self.tableViewModel =  [[EDSDataBase sharedDataBase] getSubjectFirstQuestion];
    
    self.headerView.questionModel = self.tableViewModel;
    [self.tableView setTableHeaderView:self.headerView];
    
    self.footerView.isCollection = self.tableViewModel.isCollection;
    
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
                [[EDSDataBase sharedDataBase] upDateFirstSubjectErrorsWithID:[EDSSave account].firstSubjectID];
            }
        }else{
            
            self.tableViewModel.answerlists[i].isCorrect = NO;
        }
    }
    
}

- (EDSQuestionModel *)tableViewModel
{
    if (!_tableViewModel) {
        
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
        _footerView.isCollection = self.tableViewModel.isCollection;
        [self.view addSubview:_footerView];
        [_footerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(120);
        }];
    }
    return _footerView;
}

@end

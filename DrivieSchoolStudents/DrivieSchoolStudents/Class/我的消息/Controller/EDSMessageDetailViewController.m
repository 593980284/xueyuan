//
//  EDSMessageDetailViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMessageDetailViewController.h"

#import "EDSStudentMsgDetailRequest.h"

#import "EDSStudentMsgModel.h"
#import "EDSStudentMsgDetailModel.h"

#import "EDSMessageDetailTableViewCell.h"

@interface EDSMessageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) EDSStudentMsgDetailModel *detailModel;

@end

@implementation EDSMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的消息";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)setMsgModel:(EDSStudentMsgModel *)msgModel
{
    _msgModel = msgModel;
    
    EDSStudentMsgDetailRequest *request = [EDSStudentMsgDetailRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            self.detailModel = [[EDSStudentMsgDetailModel alloc] init];
            self.detailModel.problemTime = responseDict[@"date"];
            self.detailModel.problemTitle = responseDict[@"title"];
            self.detailModel.problemContent = responseDict[@"content"];
            self.detailModel.answerTime = responseDict[@"replyDate"];
            self.detailModel.answerTitle = responseDict[@"title"];
            self.detailModel.answerContent = responseDict[@"replyContent"];
            
            [self.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    request.msgId = msgModel.msgId;
    [request  startRequest];
}

-  (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.detailModel.answerContent.length > 0 ? 2 : 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"EDSMessageDetailTableViewCell";
    // 2.从缓存池中取
    EDSMessageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[EDSMessageDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        cell.titleLbl.text = self.detailModel.problemTitle;
        cell.descrpLbl.text = self.detailModel.problemContent;
        cell.timeLbl.text = self.detailModel.problemTime;
        
        if (self.detailModel.answerContent.length == 0) {
            
            [cell.typeLbl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(0, 0));
                make.left.mas_equalTo(0);
            }];
        }else{
            
            cell.isQuestion = YES;
        }
    }else
    {
        cell.titleLbl.text = self.detailModel.answerTitle;
        cell.descrpLbl.text = self.detailModel.answerContent;
        cell.timeLbl.text = self.detailModel.answerTime;
        
        cell.isQuestion = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
@end

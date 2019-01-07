//
//  EDSBeingPushedViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/20.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSBeingPushedViewController.h"
#import "EDSOnlineAboutClassDetailAppointmentViewController.h"
#import "EDSMessageSiginBoxViewController.h"
#import "PopAnimator.h"

#import "EDSStudentMsgDetailRequest.h"
#import "EDSOnlineClassListDetailRequest.h"

#import "EDSStudentMsgModel.h"
#import "EDSStudentMsgDetailModel.h"

#import "EDSMessageDetailTableViewCell.h"
#import "EDSOnlineClassListByDateModel.h"

@interface EDSBeingPushedViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) EDSStudentMsgDetailModel *detailModel;
@property (nonatomic, strong) PopAnimator *popAnimator;

@end

@implementation EDSBeingPushedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的消息";
    
}

- (void)setMsgID:(NSString *)msgID
{
    _msgID = msgID;
    @weakify(self);
    EDSStudentMsgDetailRequest *request = [EDSStudentMsgDetailRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        if (errCode == 1) {
            
            
            self.detailModel = [[EDSStudentMsgDetailModel alloc] init];
            self.detailModel.problemTime = responseDict[@"date"];
            self.detailModel.problemTitle = responseDict[@"title"];
            self.detailModel.problemContent = responseDict[@"content"];
            self.detailModel.answerTime = responseDict[@"replyDate"];
            self.detailModel.answerTitle = responseDict[@"title"];
            self.detailModel.answerContent = responseDict[@"replyContent"];
            self.detailModel.msdType = [NSString stringWithFormat:@"%@",responseDict[@"msgType"]];
            self.detailModel.appointmentId = responseDict[@"appointmentId"];
            self.detailModel.studentId = responseDict[@"studentId"];
            
            self.tableView.dataSource = self;
            self.tableView.delegate = self;
            [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            
            [self jumpPageViewWithtype];
            [self.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    request.msgId = msgID;
    [request  startRequest];
}

- (void)jumpPageViewWithtype
{
    if ([self.detailModel.msdType isEqual:@"4"]) {
        //签到提醒
        CGFloat width = 305;
        
        CGFloat height = 166;
        
        CGRect coverFrame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        
        CGRect presentedFrame = CGRectMake((kScreenWidth - width)*0.5,175, width, height);
        
        self.popAnimator = [[PopAnimator alloc]initWithCoverFrame:coverFrame presentedFrame:presentedFrame startPoint:CGPointMake(0.5, 0.5) startTransform:CGAffineTransformMakeScale(0.5, 0.5) endTransform:CGAffineTransformMakeScale(0.0001, 0.0001)];
        
        self.popAnimator.isClose = YES;
        
        EDSMessageSiginBoxViewController *vc = [[EDSMessageSiginBoxViewController alloc] initWithNibName:@"EDSMessageSiginBoxViewController" bundle:[NSBundle mainBundle]];
        
        vc.modalPresentationStyle = UIModalPresentationCustom;
        EDSStudentMsgModel *model = [[EDSStudentMsgModel alloc] init];
        model.msgId = self.msgID;
        vc.msgModel = model;
        
        vc.view.layer.masksToBounds = YES;
        vc.view.layer.cornerRadius = 5;
        
        vc.transitioningDelegate = self.popAnimator;
        
        @weakify(self);
        vc.messageSiginBoxViewControllerDidClick = ^(EDSOnlineClassListByDateModel *model2) {
            
            @strongify(self);
            
            EDSOnlineAboutClassDetailAppointmentViewController *vc = [[EDSOnlineAboutClassDetailAppointmentViewController alloc] init];
            vc.appointmentId = model2.appointmentId;
            vc.studentId = model2.studentId;
            [self.navigationController pushViewController:vc animated:YES];
        };
        
        [self presentViewController:vc animated:YES completion:nil];
    }else if ([self.detailModel.msdType isEqual:@"3"]){
        
        [self onlineClassListDetailRequestWithAppointmentId:self.detailModel.appointmentId studentId:self.detailModel.studentId];
    }
}


- (void)onlineClassListDetailRequestWithAppointmentId:(NSString *)appointmentId studentId:(NSString *)studentId
{
//    @weakify(self);
//    EDSOnlineClassListDetailRequest *request = [EDSOnlineClassListDetailRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
//        @strongify(self);
    
        EDSOnlineAboutClassDetailAppointmentViewController *vc = [[EDSOnlineAboutClassDetailAppointmentViewController alloc] init];
        vc.appointmentId = appointmentId;
       vc.studentId = studentId;
        [self.navigationController pushViewController:vc animated:YES];
        
//    } failureBlock:^(NSError *error) {
//
//    }];
//    request.showHUD = YES;
//    request.appointmentId = appointmentId;
//    request.studentId = studentId;
//    [request startRequest];
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

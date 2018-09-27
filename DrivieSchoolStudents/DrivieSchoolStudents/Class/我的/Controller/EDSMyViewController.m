//
//  EDSMyViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMyViewController.h"
#import "EDSSchoolMessageViewController.h"//学校信箱
#import "EDSPersonalSettingsViewController.h"//个人设置
#import "EDSCourseRecordViewController.h"//课程记录
#import "EDSLearningSituationViewController.h"//学习情况
#import "EDSPSWLogoViewController.h"
#import "EDSAboutUsViewController.h"//关于我们
#import "EDSDrivingShcoolDetailViewController.h"//驾校详情
#import <SDImageCache.h>

#import "EDSMyTableViewCell.h"
#import "EDSMyHeaderView.h"
#import "MyConstants.h"

#import "EDSGetStudentInfoRequest.h"
#import "EDSVersionUpdateRequest.h"

@interface EDSMyViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 数据 */
@property (nonatomic, strong) NSArray  *cellArr;
/** 头部试图 */
@property (nonatomic, strong)  EDSMyHeaderView *headerView;

@end

@implementation EDSMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, MyTableViewSeparatorLeft, 0, 0);
    
    @weakify(self);
    self.headerView.headerImgViewDidClick = ^{
        @strongify(self);
        EDSPersonalSettingsViewController *vc = [[EDSPersonalSettingsViewController alloc] initWithNibName:@"EDSPersonalSettingsViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView = self.headerView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    DLog(@"%@",[EDSSave account].userID);
    
    if ([EDSToolClass isBlankString:[EDSSave account].userID]) {
        
        EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        
        EDSGetStudentInfoRequest *request = [EDSGetStudentInfoRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            
            if (errCode == -2) {
                
                EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
                
            }else if (errCode == 1){
                
                DLog(@"%@",[EDSSave account].schoolId);
                NSString *string = [EDSToolClass isBlankString:[EDSSave account].schoolId]  ?  @"我的报名" : @"我的驾校";
                self.cellArr = @[
                                 @[
                                     @[string,@"wdbm_content_icon_default"],
                                     @[@"课程记录",@"kcjl_content_icon_default"],
                                     @[@"学习查询",@"xxcx_content_icon_default"],
                                     @[@"学校信箱",@"xxxx_content_icon_default"],
                                     ],
                                 @[
                                     @[@"刷新缓存",@"sxhc_content_icon_default" , [NSString stringWithFormat:@"%d",[self clearTmpPics]]],
                                     @[@"检查更新",@"jcgx_content_icon_default"],
                                     @[@"关于我们",@"gywm_content_icon_default"],
                                     ],
                                 ];
                
                self.headerView.headerArr = @[];
                [self.tableView reloadData];
            }
            
        } failureBlock:^(NSError *error) {
        
        }];
        request.phone = [EDSSave account].phone;
        [request startRequest];
    }
    
    NSString *string = [EDSToolClass isBlankString:[EDSSave account].schoolId]  ? @"我的驾校" : @"我的报名";
    self.cellArr = @[
                     @[
                         @[string,@"wdbm_content_icon_default"],
                         @[@"课程记录",@"kcjl_content_icon_default"],
                         @[@"学习查询",@"xxcx_content_icon_default"],
                         @[@"学校信箱",@"xxxx_content_icon_default"],
                         ],
                     @[
                         @[@"刷新缓存",@"sxhc_content_icon_default" , [NSString stringWithFormat:@"%d",[self clearTmpPics]]],
                         @[@"检查更新",@"jcgx_content_icon_default"],
                         @[@"关于我们",@"gywm_content_icon_default"],
                         ],
                     ];
    
    self.headerView.headerArr = @[];
    [self.tableView reloadData];
}



#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cellArr[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EDSMyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EDSMyTableViewCell"];
    if (!cell) {
        cell =  [[NSBundle mainBundle]loadNibNamed:@"EDSMyTableViewCell" owner:self options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.cellArr = self.cellArr[indexPath.section][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MyTableViewCellH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [UIView viewWithBackgroundColor:TableColor superView:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *string = self.cellArr[indexPath.section][indexPath.row][0];
    if ([string isEqualToString:@"学校信箱"]) {
        
        EDSSchoolMessageViewController *vc = [[EDSSchoolMessageViewController alloc] initWithNibName:@"EDSSchoolMessageViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"课程记录"]){
        
        if ([EDSSave account].schoolId.length > 0) {
            
            EDSCourseRecordViewController *vc = [[EDSCourseRecordViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"您还没有报名^_^!"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    }else if ([string isEqualToString:@"学习查询"]){
        
        if ([EDSSave account].schoolId.length > 0) {
            
            EDSLearningSituationViewController *vc = [[EDSLearningSituationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:@"您还没有报名^_^!"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    }else if ([string isEqualToString:@"关于我们"]){
        
        EDSAboutUsViewController *vc = [[EDSAboutUsViewController alloc] initWithNibName:@"EDSAboutUsViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"我的驾校"]){
        
        EDSDrivingShcoolDetailViewController *vc = [[EDSDrivingShcoolDetailViewController alloc] init];
        vc.schoolId = [EDSSave account].schoolId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([string isEqualToString:@"刷新缓存"]){
        
        [SVProgressHUD showWithStatus:@"正在清除缓存..."];
        //清理结果的信息
        NSString *message = nil;//提示文字
        BOOL clearSuccess = YES;//是否删除成功
        NSError *error = nil;//错误信息
        
        //构建需要删除的文件或文件夹的路径，这里以Documents为例
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        
        //拿到path路径的下一级目录的子文件夹
        NSArray *subPathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
        
        for (NSString *subPath in subPathArray)
        {
            //如果是数据库文件，不做操作
            if ([subPath isEqualToString:@"bank.db"] || [subPath isEqualToString:@"classify.db"] || [subPath isEqualToString:@"icon.db"] || [subPath isEqualToString:@"account.plist"])
            {
                continue;
            }
            
            NSString *filePath = [path stringByAppendingPathComponent:subPath];
            //删除子文件夹
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
            if (error)
            {
                message = [NSString stringWithFormat:@"%@这个路径的文件夹删除失败了",filePath];
                clearSuccess = NO;
            }
            else
            {
                message = @"清除缓存成功";
                [SVProgressHUD showSuccessWithStatus:@"清除缓存成功"];
                [SVProgressHUD dismissWithDelay:0.2];
            }
        }
        
    }else if ([string isEqualToString:@"检查更新"]){
        
        @weakify(self);
        EDSVersionUpdateRequest *request = [EDSVersionUpdateRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
            @strongify(self);
            
            [SVProgressHUD showSuccessWithStatus:@"您已经是最新版本不需要更新"];
            [SVProgressHUD dismissWithDelay:1];
        } failureBlock:^(NSError *error) {
        
        }];
        request.title = @"乐享学员APP版本(iOS)";
        [request startRequest];
    }else if ([string isEqualToString:@"我的报名"]){
        
        [SVProgressHUD showErrorWithStatus:@"您还没有报名"];
        [SVProgressHUD dismissWithDelay:1.5];
    }
}

#pragma 清理缓存图片

- (int)clearTmpPics
{
    //计算结果
    int totalSize = 0;
    
    // 构建需要计算大小的文件或文件夹的路径，这里以Documents为例
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir)//文件夹, 遍历文件夹里面的所有文件
    {
        //这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径),包括子文件夹下面的所有文件及文件夹
        NSArray *subPaths = [mgr subpathsAtPath:path];
        
        //遍历所有子路径
        for (NSString *subPath in subPaths)
        {
            //拼成全路径
            NSString *fullSubPath = [path stringByAppendingPathComponent:subPath];
            
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubPath isDirectory:&dir];
            if (!dir)//子路径是个文件
            {
//                //如果是数据库文件，不加入计算
                if ([subPath isEqualToString:@"bank.db"] || [subPath isEqualToString:@"classify.db"] || [subPath isEqualToString:@"icon.db"])
                {
                    continue;
                }
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubPath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        totalSize = totalSize / (1024 * 1024.0);//单位M
    }
    else//文件
    {
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        totalSize = [attrs[NSFileSize] intValue] / (1024 * 1024.0);//单位M
    }
    return totalSize;
}


#pragma mark ------------------------ 懒加载 --------------------------------
- (EDSMyHeaderView *)headerView
{
    if (!_headerView) {
        
        _headerView = [[EDSMyHeaderView alloc] init];
        _headerView.wz_size = CGSizeMake(kScreenWidth, MyTableViewHeaderViewH);
    }
    return _headerView;
}
@end

//
//  EDSBusInfoVC.m
//  DrivieSchoolStudents
//
//  Created by 胡玉峰 on 2018/12/22.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSBusInfoVC.h"
#import "EDSBusInfoTopView.h"
#import "EDSBusInfoLeftListView.h"
#import "EDSBusInfoRightListView.h"
#import "EDSBusInfoRequest.h"

@interface EDSBusInfoVC ()
@property (nonatomic,strong) UIScrollView *bgScrView;
@property (nonatomic,strong) EDSBusInfoTopView *topView;
@property (nonatomic,strong) EDSBusInfoLeftListView *leftListView;
@property (nonatomic,strong) EDSBusInfoRightListView *rightListView;

@end

@implementation EDSBusInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"班车详情";
    [self setUpView];
    [self requestData];
    
}
-(void)requestData{
    @weakify(self);
    EDSBusInfoRequest *request = [EDSBusInfoRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, NSArray* model) {
        @strongify(self);
        
        NSLog(@"-------%@",responseDict);
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        [self.tableView.mj_footer resetNoMoreData];
//        if (errCode == 1) {
//            if (model.count == 0) {
//                [self.tableView.mj_footer endRefreshingWithNoMoreData];
//            }
//            NSMutableArray *data = [NSMutableArray new];
//            if (self.page > 1) {
//                [data addObjectsFromArray:self.tableViewArr];
//                [data addObjectsFromArray:model];
//            }else{
//                data = [model copy];
//            }
//            self.tableViewArr = data;
//        }else if (errCode == -2){
//
//            //            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
//            //            [self presentViewController:vc animated:YES completion:nil];
//        }
//        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
    }];
    
    request.busInfoId = @"8";
    [request  startRequest];

}
-(void)setUpView{
    
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bgScrView];
    [self.bgScrView addSubview:self.leftListView];
    [self.bgScrView addSubview:self.rightListView];
    [self.bgScrView setContentSize:CGSizeMake(0, self.leftListView.wz_height)];
}
-(EDSBusInfoTopView *)topView{
    if (!_topView) {
        _topView = [[EDSBusInfoTopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        
    }
    return _topView;
}
-(UIScrollView *)bgScrView{
    if (!_bgScrView) {
        _bgScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.topView.wz_bottom, kScreenWidth, kScreenHeight - self.topView.wz_bottom)];
//        _bgScrView.backgroundColor = [UIColor redColor];
        
    }
    return _bgScrView;
}
-(EDSBusInfoLeftListView*)leftListView{
    if (!_leftListView) {
        _leftListView =[[EDSBusInfoLeftListView alloc]initWithFrame:CGRectMake(5, 0, 100, 0)];
        
    }
    return _leftListView;
}
-(EDSBusInfoRightListView *)rightListView{
    if (!_rightListView) {
        _rightListView = [[EDSBusInfoRightListView alloc]initWithFrame:CGRectMake(self.leftListView.wz_right, 0,kScreenWidth - self.leftListView.wz_right, 0)];
    }
    return _rightListView;
}
@end

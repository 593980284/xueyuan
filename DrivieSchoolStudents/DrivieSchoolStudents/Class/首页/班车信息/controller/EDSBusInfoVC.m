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
#import "EDSBusInfoListTopView.h"

@interface EDSBusInfoVC ()
@property (nonatomic,strong) UIScrollView *bgScrView;
@property (nonatomic,strong) EDSBusInfoTopView *topView;
@property (nonatomic,strong) EDSBusInfoLeftListView *leftListView;
@property (nonatomic,strong) EDSBusInfoRightListView *rightListView;
@property (nonatomic,strong) EDSBusInfoListTopView *listTopView;
//0 来 1 返程
@property (nonatomic,assign) NSInteger busInfoType;

@end

@implementation EDSBusInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"班车详情";
    self.busInfoType = 0;
    [self setUpView];
    [self requestData];
    
}
-(void)requestData{
    @weakify(self);
    EDSBusInfoRequest *request = [EDSBusInfoRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, NSArray* model) {
        @strongify(self);
        
        self.topView.dataDic = responseDict[@"shuttleBusData"];
        self.leftListView.dataArr = responseDict[@"list"];
        self.rightListView.dataArr = responseDict[@"list"];
        NSLog(@"-------%@",responseDict);
    } failureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    request.busInfoId =self.busInfoId;
    request.busInfoType = self.busInfoType;
    [request  startRequest];

}
-(void)viewDidLayoutSubviews{
    [self.bgScrView setContentSize:CGSizeMake(0, self.leftListView.wz_height)];
}
-(void)setUpView{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bgScrView];
    [self.bgScrView addSubview:self.leftListView];
    [self.bgScrView addSubview:self.rightListView];
    [self.bgScrView addSubview:self.listTopView];
    [self.bgScrView setContentSize:CGSizeMake(0, self.leftListView.wz_height)];
}
-(EDSBusInfoTopView *)topView{
    if (!_topView) {
        _topView = [[EDSBusInfoTopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        
        @weakify(self);
        _topView.refreshBtnClick = ^{
             @strongify(self);
            if (self.busInfoType == 0) {
                self.busInfoType = 1;
            }else{
                self.busInfoType = 0;
            }
            
            [self requestData];
        };
        
    }
    return _topView;
}
-(UIScrollView *)bgScrView{
    if (!_bgScrView) {
        _bgScrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.topView.wz_bottom, kScreenWidth, self.view.wz_height - self.topView.wz_bottom - SafeAreaTopHeight )];
//        _bgScrView.backgroundColor = [UIColor redColor];
        
    }
    return _bgScrView;
}
-(EDSBusInfoLeftListView*)leftListView{
    if (!_leftListView) {
        _leftListView =[[EDSBusInfoLeftListView alloc]initWithFrame:CGRectMake(5, self.listTopView.wz_bottom, 100, 0)];
        
    }
    return _leftListView;
}
-(EDSBusInfoRightListView *)rightListView{
    if (!_rightListView) {
        _rightListView = [[EDSBusInfoRightListView alloc]initWithFrame:CGRectMake(self.leftListView.wz_right, self.listTopView.wz_bottom,kScreenWidth - self.leftListView.wz_right, 0)];
        _rightListView.backgroundColor = [UIColor blueColor];
    }
    return _rightListView;
}
-(EDSBusInfoListTopView *)listTopView{
    if (!_listTopView) {
        _listTopView = [[EDSBusInfoListTopView alloc]initWithFrame:CGRectMake(0, 0,self.bgScrView.wz_width, 40)];
    }
    return _listTopView;
}
@end

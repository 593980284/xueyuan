//
//  EDSDrivingShcoolDetailViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDrivingShcoolDetailViewController.h"

#import "EDSEDSDrivingDetailsHeaderView.h"


#define kTopView_Height 200
#define kItemheight 100

@interface EDSDrivingShcoolDetailViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *bottomScrollView;
@property (strong, nonatomic) EDSEDSDrivingDetailsHeaderView *topView;


@end

@implementation EDSDrivingShcoolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bottomScrollView];
    [self.view addSubview:self.topView];
}


- (UIScrollView *)bottomScrollView
{
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _bottomScrollView.contentSize = CGSizeMake(kScreenWidth, 0);
        _bottomScrollView.showsVerticalScrollIndicator = NO;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.delegate = self;
        
//        [_bottomScrollView addSubview:self.firstTableView];
//        [_bottomScrollView addSubview:self.secondTableView];
    }
    return _bottomScrollView;
}


- (EDSEDSDrivingDetailsHeaderView *)topView
{
    if (!_topView) {
        _topView = [[EDSEDSDrivingDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kTopView_Height)];
        _topView.itemHeight = kItemheight;
    }
    return _topView;
}

@end

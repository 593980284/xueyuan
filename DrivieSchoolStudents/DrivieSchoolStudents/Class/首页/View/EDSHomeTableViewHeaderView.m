//
//  EDSHomeTableViewHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHomeTableViewHeaderView.h"
#import "EDSHomeFunctionBgView.h"

#import "HomeConstants.h"

@interface EDSHomeTableViewHeaderView ()<SDCycleScrollViewDelegate>
/** 轮播图 */
@property (nonatomic, strong) SDCycleScrollView  *cycleScrollView;
/** 按钮 */
@property (nonatomic, strong) EDSHomeFunctionBgView  *homeFunctionBgView;
@end

@implementation EDSHomeTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = TableColor;
        self.cycleScrollView.imageURLStringsGroup = @[
                                                      @"http://pic35.photophoto.cn/20150516/0005018639255973_b.jpg",
                                                      @"http://pic35.photophoto.cn/20150516/0005018639255973_b.jpg",
                                                      ];
        
        self.homeFunctionBgView.backgroundColor = WhiteColor;
        self.homeFunctionBgView.functionBtnArr = @[
                                                   @[@"预约报名",@"yybml_content_icon_default"],
                                                   @[@"报名流程",@"bmlc_content_icon_default"],
                                                   @[@"学车流程",@"xclc_content_icon_default"],
                                                   @[@"驾校信息",@"jxxx_content_icon_default"],
                                                   @[@"在线约课",@"zxyk_content_icon_default"],
                                                   @[@"在线约考",@"zxyk_content_icon_default-1"],
                                                   @[@"理论学习",@"llxx_content_icon_default"],
                                                   @[@"价格公示",@"jggs_content_icon_default"],             ];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}


- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:PLACEHOLDERGOODSIMAGE];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.showPageControl = YES;
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        [self addSubview:_cycleScrollView];
        _cycleScrollView.frame = CGRectMake(0, 0, kScreenWidth, EDSHomeTableViewHeaderSlideH);
    }
    return _cycleScrollView;
}

- (EDSHomeFunctionBgView *)homeFunctionBgView
{
    if (!_homeFunctionBgView) {
        
        _homeFunctionBgView = [[EDSHomeFunctionBgView alloc] init];
        [self addSubview:_homeFunctionBgView];
        [_homeFunctionBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.cycleScrollView.mas_bottom);
            make.height.mas_equalTo(EDSHomeTableViewHeaderButtonBgH);
        }];
    }
    return _homeFunctionBgView;
}
@end

//
//  EDSHomeTableViewHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHomeTableViewHeaderView.h"
#import "EDSHomeFunctionBgView.h"

#import "EDSHomeRollPictureRequest.h"

#import "HomeConstants.h"

@interface EDSHomeTableViewHeaderView ()<SDCycleScrollViewDelegate>
/** 轮播图 */
@property (nonatomic, strong) SDCycleScrollView  *cycleScrollView;
/** 按钮 */
@property (nonatomic, strong) EDSHomeFunctionBgView  *homeFunctionBgView;

@property (nonatomic , strong) NSArray *homeRollPictureArr;

@end

@implementation EDSHomeTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = TableColor;
        
    }
    return self;
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(homeHeaderViewCycleScrollViewBackDict:)]) {
        
        [self.delegate homeHeaderViewCycleScrollViewBackDict:self.homeRollPictureArr[index]];
    }
}

- (void)setHeaderArr:(NSArray *)headerArr
{
    _headerArr = headerArr;
    
    [self requestData];
    
    self.cycleScrollView.imageURLStringsGroup = @[
                                                  ];
    if (self.is) {
        return;
    }
    self.homeFunctionBgView.backgroundColor = WhiteColor;
    NSLog(@"schoolId: %@",[EDSSave account].userID);
    if ([EDSToolClass isBlankString:[EDSSave account].schoolId]) {
        
        self.homeFunctionBgView.functionBtnArr = @[
                                                   @[@"品牌驾校",@"1品牌驾校"],
                                                   @[@"驾校信息",@"2驾校信息"],
                                                   @[@"我要报名",@"3我要报名"],
                                                   @[@"报名流程",@"4报名流程"],
                                                   
                                                   @[@"乐享论坛",@"5我要约课"],
                                                   @[@"我要约考",@"6我要约考"],
                                                   @[@"理论学习",@"7理论学习"],
                                                   @[@"我要投诉",@"8我要投诉"],             ];
    }else{
        self.homeFunctionBgView.functionBtnArr = @[
                                                   @[@"品牌驾校",@"1品牌驾校"],
                                                   @[@"驾校信息",@"2驾校信息"],
                                                   @[@"我的驾校",@"3我要报名"],
                                                   @[@"报名流程",@"4报名流程"],
                                                   
                                                   @[@"乐享论坛",@"5我要约课"],
                                                   @[@"我要约考",@"6我要约考"],
                                                   @[@"理论学习",@"7理论学习"],
                                                   @[@"我要投诉",@"8我要投诉"],             ];
//        self.homeFunctionBgView.functionBtnArr = @[
//                                                   @[@"品牌驾校",@"ppjj_content_icon_default"],
//                                                   @[@"驾校信息",@"jxxx_content_icon_default"],
//                                                   @[@"我的报名",@"yybml_content_icon_default"],
//                                                   @[@"我要报名",@"bmlc_content_icon_default"],
//
//                                                   @[@"在线约课",@"zxyk_content_icon_default"],
//                                                   @[@"在线约考",@"zxyk_content_icon_default-1"],
//                                                   @[@"理论学习",@"llxx_content_icon_default"],
//                                                   @[@"我要投诉",@"suggest_content_icon_default22"],             ];
    }
}

- (void)requestData
{
    @weakify(self);
    EDSHomeRollPictureRequest *request = [EDSHomeRollPictureRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        self.cycleScrollView.imageURLStringsGroup = [model valueForKey:@"homeRollPicture"];
        
        self.homeRollPictureArr = model;
        
    } failureBlock:^(NSError *error) {
        
    }];
    request.is= _is;
    [request  startRequest];
    
}


- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage: bannerPlaceholderImage];
        _cycleScrollView.backgroundColor = [UIColor redColor];
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

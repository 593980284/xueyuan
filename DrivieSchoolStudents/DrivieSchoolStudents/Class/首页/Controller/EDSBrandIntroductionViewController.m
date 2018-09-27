//
//  EDSBrandIntroductionViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/26.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSBrandIntroductionViewController.h"

@interface EDSBrandIntroductionViewController ()

@property (nonatomic ,strong) UIScrollView *scView;
@property (nonatomic ,strong) UIImageView *showImg;
@end

@implementation EDSBrandIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"品牌介绍";
    self.view.backgroundColor = WhiteColor;
    
    //设置imageView的背景图
    self.showImg.image = [UIImage imageNamed:@"ppjs"];
}

#pragma mark - 显示图片的ImgView
-(UIImageView *)showImg{
    if (!_showImg) {
        CGFloat imgH = [self imgContentHeight];
        _showImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth , imgH)];
        //给imageView设置区域
        _showImg.contentMode = UIViewContentModeScaleAspectFill;
        //超出边界的剪切
        //        [_showImg setClipsToBounds:YES];
        //把视图添加到当前的滚动视图中
        [self.scView addSubview:_showImg];
    }
    return _showImg;
}


#pragma mark - scorllView
-(UIScrollView *)scView{
    if (!_scView) {
        //获取导航栏和状态栏的高度
        CGFloat barHeight = [self barHeight];
        _scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - barHeight)];
        CGFloat imgH = [self imgContentHeight];
        _scView.contentSize = CGSizeMake(0,imgH);//设置滚动视图的大小
        //        _scView.pagingEnabled = YES;//设置是否可以进行画面切换  分块显示
        _scView.bounces = NO;
        _scView.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
        _scView.showsVerticalScrollIndicator = NO;//
        [self.view addSubview:_scView];
    }
    return _scView;
}
#pragma mark - 内容的高度
-(CGFloat)imgContentHeight{
    //获取图片高度
    UIImage *img = [UIImage imageNamed:@"ppjs"];
    CGFloat imgHeight = img.size.height;
    CGFloat imgWidth = img.size.width;
    CGFloat imgH = imgHeight * (kScreenWidth / imgWidth);
    return imgH;
}


#pragma mark - 获取导航栏和状态栏的高度
-(CGFloat)barHeight{
    //获取导航栏和状态栏的高度
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    CGFloat barHeight = statusBarFrame.size.height + navBarFrame.size.height;
    return barHeight;
}

@end

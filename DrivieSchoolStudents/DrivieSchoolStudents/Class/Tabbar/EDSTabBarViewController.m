//
//  EDSTabBarViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSTabBarViewController.h"
#import "EDSNavigationViewController.h"

#import "EDSHomeViewController.h"//首页
#import "EDSStudentDriverStrategyViewController.h"//学车攻略
#import "EDSMessageViewController.h"//我的消息
#import "EDSMyViewController.h"//我的

#define TabbarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) // 适配iPhone x 底栏高度

@interface EDSTabBarViewController ()<UITabBarControllerDelegate>
@property (nonatomic, assign) NSUInteger selectItem;//选中的item

@end

@implementation EDSTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectItem = 0; //默认选中第一个
    self.delegate = self;
    
    // Do any additional setup after loading the view.
    [self addChildVc:[EDSHomeViewController new] title:@"首页" image:@"home_tab_icon_default" selectedImage:@"home_tab_icon_selected"];
    [self addChildVc:[EDSStudentDriverStrategyViewController new] title:@"学车攻略" image:@"xcgl_tab_icon_default" selectedImage:@"xcgl_tab_icon_selected"];
    //中间这个不设置东西，只占位
    [self addChildVc:[EDSMessageViewController new] title:@"我的消息" image:@"news_tab_icon_default" selectedImage:@"news_tab_icon_selected"];
    [self addChildVc:[EDSMyViewController new] title:@"我的" image:@"mine_tab_icon_default" selectedImage:@"mine_tab_icon_selected"];
}



/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = ThirdColor;
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = ThemeColor;
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    //    DDNavigationController *nav = [[DDNavigationController alloc] initWithRootViewController:childVc];
    
    EDSNavigationViewController *nav = [[EDSNavigationViewController alloc] initWithRootViewController:childVc];//侧滑
    
    // 添加为子控制器
    [self addChildViewController:nav];
}


@end

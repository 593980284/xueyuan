//
//  BHYBaseViewController.h
//  HuanYouth
//
//  Created by 卓森 on 2018/6/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BHYBaseViewController : UIViewController

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic, assign)UITableViewStyle tableViewStyle;

-(void)showPageLoadingProgress;
/**
 *  当加载数据失败时，显示重新加载数据的页面
 *  仅仅适用于非自动布局页面，自动布局页面建议使用: showHintPageWhenLoadFailedWithReloadTarget:action:
 *
 *  @param target 接收消息的对象
 *  @param action 事件处理方法
 */
-(void)showPageLoadingFailedWithReloadTarget:(id)target action:(SEL)action;

/**
 *  隐藏加载失败重新加载页面
 */
- (void)dismissHintPageWhenLoadFailed;

/**
 隐藏加载动画与失败页面
 */
- (void)endPageLoadingProgress;
/**
 *  添加导航栏左侧按钮
 *
 *  @param image  按钮图片
 *  @param target self
 *  @param action 按钮执行方法
 */
-(void)addNavigationBarLeftButtonItemWithInfo:(UIImage*)image target:(id)target action:(SEL)action;
-(void)addNavigationBarRightButtonItemWithInfo:(UIImage *)image target:(id)target action:(SEL)action;

- (void)userLogonFailureWithParentControl:(UIViewController *)parentControl;

@end

//
//  LXAlterPromptView.h
//  LXCoach
//
//  Created by GDD on 2018/9/12.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXAlterPromptViewDelegate <NSObject>
/// 取消按钮
- (void)lx_cancelClickButton;
/// 确认按钮
- (void)lx_enterClickButton;
@end

/**
 未保存的数据退出提示弹框
 */
@interface LXAlterPromptView : UIView
/// 提示语
@property (nonatomic, copy) NSString *alterString;
@property (nonatomic, assign) id <LXAlterPromptViewDelegate> delegate;
@end

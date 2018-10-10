//
//  UIView+LXToast.h
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LXToast)

// each makeToast method creates a view and displays it as toast
-(void)makeToast:(NSString*)message;
-(void)makeToast:(NSString *)message delay:(float)delay;
-(void)makeToast:(NSString *)message yOffset:(NSInteger)offset;
-(void)makeToast:(NSString *)message yOffset:(NSInteger)offset delay:(float)delay;

- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title image:(UIImage *)image;
- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position image:(UIImage *)image;

// displays toast with an activity spinner
- (void)makeToastActivity;
- (void)makeToastActivity:(id)position;
- (void)hideToastActivity;

// the showToast methods display any view as toast
- (void)showToast:(UIView *)toast;
- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point;

-(void)hideToast;

-(void)showIndicatorViewWithTitle:(NSString *)title content:(NSString *)content image:(UIImage *)image;

-(void)showIndicatorView;

-(void)hideIndicatorView;

#pragma mark - CustomIndicator Methods
- (void)showCustomIndicator;
- (void)showCustomIndicatorDelay;
- (void)showCustomIndicatorDuration:(CGFloat)interval;
- (void)hideCustomIndicator;

-(void)showCoverView;
-(void)hideCoverView;

- (void)showSimpleIndicator;
- (void)hideSimpleIndicator;


@end

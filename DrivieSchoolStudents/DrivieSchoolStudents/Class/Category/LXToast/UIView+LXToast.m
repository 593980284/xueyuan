//
//  UIView+LXToast.m
//  LXCoach
//
//  Created by tanghaiyang on 2018/9/8.
//  Copyright © 2018年 LeXiang. All rights reserved.
//

#import "UIView+LXToast.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIColor+LXColor.h"

/*
 *  CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 *  DISPLAY DURATION, ETC.
 */

// general appearance
static const CGFloat CSToastMaxWidth            = 0.8;      // 80% of parent view width
static const CGFloat CSToastMaxHeight           = 0.8;      // 80% of parent view height
static const CGFloat CSToastHorizontalPadding   = 10.0;
static const CGFloat CSToastVerticalPadding     = 10.0;
static const CGFloat CSToastCornerRadius        = 5.0;
static const CGFloat CSToastOpacity             = 0.7;
static const CGFloat CSToastFontSize            = 16.0;
static const CGFloat CSToastMaxTitleLines       = 0;
static const CGFloat CSToastMaxMessageLines     = 0;
static const CGFloat CSToastFadeDuration        = 0.2;

// shadow appearance
static const CGFloat CSToastShadowOpacity       = 0.8;
static const CGFloat CSToastShadowRadius        = 5.0;
static const CGSize  CSToastShadowOffset        = { 4.0, 4.0 };
static const BOOL    CSToastDisplayShadow       = NO;

// display duration and position
static const CGFloat CSToastDefaultDuration     = 1.0;
//static const NSString * CSToastDefaultPosition  = @"bottom";

static const NSString * CSToastDefaultPosition  = @"center";

// image view size
static const CGFloat CSToastImageViewWidth      = 80.0;
static const CGFloat CSToastImageViewHeight     = 80.0;

// activity
static const CGFloat CSToastActivityWidth       = 100.0;
static const CGFloat CSToastActivityHeight      = 100.0;
static const NSString * CSToastActivityDefaultPosition = @"center";
static const NSString * CSToastActivityViewKey  = @"CSToastActivityViewKey";
#define TIME_ONE_CIRCLE  0.7f  //Indicator转一圈的时间

@interface UIView (LXToastPrivate)

- (CGPoint)centerPointForPosition:(id)position withToast:(UIView *)toast;
- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image;

@end

@implementation UIView (LXToast)

#pragma mark - Toast Methods

- (void)makeToast:(NSString*)message{
    [self makeToast:message yOffset:0.f];
}

-(void)makeToast:(NSString *)message delay:(float)delay{
    [self tipHUDForTitle:message yOffset:0.f hideAfterDelay:delay];
}

-(void)makeToast:(NSString *)message yOffset:(NSInteger)offset{
    [self makeToast:message yOffset:offset delay:0.7f];
}

-(void)makeToast:(NSString *)message yOffset:(NSInteger)offset delay:(float)delay{
    [self tipHUDForTitle:message yOffset:offset hideAfterDelay:delay];
}

/*
 *@Function:生成一个提示框，并显示，对屏幕做任何操作则提示消失，否则在一定时间(duration)后消失
 *@Parameter:
 *                 superView：将提示框加到该view的subview中,例如self.view
 *                 title：提示内容
 *                 duration：提示框显示的时间
 *@Description:不要把返回值添加到你的view中，除非superView为nil；返回值可用来进一步定制提示框的属性, 如 yOffset (改变位置)
 */
- (void)tipHUDForTitle:(NSString *)title yOffset:(NSInteger)offset hideAfterDelay:(NSTimeInterval)duration
{
    if (title.length == 0) {
        return ;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    if (hud) {
        hud.bezelView.color = [UIColor lx_colorWithHexString:@"#000000" alpha:0.8]; // 设置字体大的颜色
        hud.contentColor = [UIColor whiteColor];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.mode = MBProgressHUDModeText;
        hud.bezelView.layer.cornerRadius = CSToastCornerRadius;//圆角半径
        hud.margin = 10.f;//文字与边界之间的距离
        hud.label.font = [UIFont systemFontOfSize:14.0f];//提示文字字体
        [hud setOffset:CGPointMake(hud.offset.x, offset)];
        hud.minSize = CGSizeMake(150,30);//外框尺寸下限
        hud.removeFromSuperViewOnHide = YES;
        hud.label.text = title;
        [hud hideAnimated:YES afterDelay:duration];
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
    }
    
}
- (void)show:(NSString *)text imageName:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    MBBackgroundView *hudView = [[MBBackgroundView alloc]init];
    hudView.color = [UIColor lx_colorWithHexString:@"#000000" alpha:0.5];
    hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:0.7];
}


- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position title:(NSString *)title {
    UIView *toast = [self viewForMessage:message title:title image:nil];
    [self showToast:toast duration:interval position:position];
}

- (void)makeToast:(NSString *)message duration:(CGFloat)interval position:(id)position image:(UIImage *)image {
    UIView *toast = [self viewForMessage:message title:nil image:image];
    [self showToast:toast duration:interval position:position];
}

- (void)makeToast:(NSString *)message duration:(CGFloat)interval  position:(id)position title:(NSString *)title image:(UIImage *)image {
    UIView *toast = [self viewForMessage:message title:title image:image];
    [self showToast:toast duration:interval position:position];
}

- (void)showToast:(UIView *)toast {
    [self showToast:toast duration:CSToastDefaultDuration position:CSToastDefaultPosition];
}

- (void)showToast:(UIView *)toast duration:(CGFloat)interval position:(id)point {
    toast.center = [self centerPointForPosition:point withToast:toast];
    toast.alpha = 0.0;
    [self addSubview:toast];
    toast.tag = 2876;
    
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:CSToastFadeDuration
                                               delay:interval
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              toast.alpha = 0.0;
                                          } completion:^(BOOL finished) {
                                              [toast removeFromSuperview];
                                          }];
                     }];
}

-(void)hideToast
{
    UIView *toast = [self viewWithTag:2876];
    if (toast) {
        [toast removeFromSuperview];
    }
}

#pragma mark - Toast Activity Methods

- (void)makeToastActivity {
    [self makeToastActivity:CSToastActivityDefaultPosition];
}

- (void)makeToastActivity:(id)position {
    // sanity
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &CSToastActivityViewKey);
    if (existingActivityView != nil) return;
    
    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CSToastActivityWidth, CSToastActivityHeight)];
    activityView.center = [self centerPointForPosition:position withToast:activityView];
    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:CSToastOpacity];
    activityView.alpha = 0.0;
    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    activityView.layer.cornerRadius = CSToastCornerRadius;
    
    if (CSToastDisplayShadow) {
        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
        activityView.layer.shadowOpacity = CSToastShadowOpacity;
        activityView.layer.shadowRadius = CSToastShadowRadius;
        activityView.layer.shadowOffset = CSToastShadowOffset;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = CGPointMake(activityView.bounds.size.width / 2, activityView.bounds.size.height / 2);
    [activityView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    // associate ourselves with the activity view
    objc_setAssociatedObject (self, &CSToastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self addSubview:activityView];
    
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         activityView.alpha = 1.0;
                     } completion:nil];
}

- (void)hideToastActivity {
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &CSToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:CSToastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [existingActivityView removeFromSuperview];
                             objc_setAssociatedObject (self, &CSToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}

#pragma mark - Private Methods

- (CGPoint)centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        // convert string literals @"top", @"bottom", @"center", or any point wrapped in an NSValue object into a CGPoint
        if([point caseInsensitiveCompare:@"top"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + CSToastVerticalPadding);
        } else if([point caseInsensitiveCompare:@"bottom"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - CSToastVerticalPadding);
        } else if([point caseInsensitiveCompare:@"center"] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    
    NSLog(@"Warning: Invalid position for toast.");
    return [self centerPointForPosition:CSToastDefaultPosition withToast:toast];
}

- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    
    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = CSToastCornerRadius;
    
    if (CSToastDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = CSToastShadowOpacity;
        wrapperView.layer.shadowRadius = CSToastShadowRadius;
        wrapperView.layer.shadowOffset = CSToastShadowOffset;
    }
    
    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:CSToastOpacity];
    
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(CSToastHorizontalPadding, CSToastVerticalPadding, CSToastImageViewWidth, CSToastImageViewHeight);
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = CSToastHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = CSToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:CSToastFontSize];
        //titleLabel.textAlignment = NSTextAlignmentLeft;
        //titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * CSToastMaxWidth) - imageWidth, self.bounds.size.height * CSToastMaxHeight);
        
        NSDictionary *attribute = @{NSFontAttributeName: titleLabel.font};
        
        CGSize expectedSizeTitle = [title boundingRectWithSize:maxSizeTitle options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        //        [title sizeWithFont:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = CSToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:CSToastFontSize];
        //messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * CSToastMaxWidth) - imageWidth, self.bounds.size.height * CSToastMaxHeight);
        NSDictionary *attribute = @{NSFontAttributeName: messageLabel.font};
        
        CGSize expectedSizeMessage = [message boundingRectWithSize:maxSizeMessage options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        //        [message sizeWithFont:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = CSToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + CSToastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + CSToastHorizontalPadding;
        messageTop = titleTop + titleHeight + CSToastVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (CSToastHorizontalPadding * 2)), (longerLeft + longerWidth + CSToastHorizontalPadding));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + CSToastVerticalPadding), (imageHeight + (CSToastVerticalPadding * 2)));
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
    
    return wrapperView;
}

-(UIView *)createIndicatorViewWithTitle{
    CGRect rcScreeno=[UIApplication sharedApplication].keyWindow.frame;
    CGRect rcScreen =CGRectMake(0, 0, rcScreeno.size.width, rcScreeno.size.height-65);
    UIView *m_viewTip=[[UIView alloc]initWithFrame:rcScreen];
    m_viewTip.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    m_viewTip.tag=2900;
    m_viewTip.backgroundColor=[UIColor clearColor];
    UIView *bgView=[[UIView alloc]initWithFrame:rcScreen];
    bgView.backgroundColor=[UIColor lightGrayColor];
    bgView.alpha=0.6;
    [m_viewTip addSubview:bgView];
    
    UIView *contentBGView=[[UIView alloc] initWithFrame:CGRectMake(30, (rcScreen.size.height-257)/2.0, rcScreen.size.width-60, 257)];
    contentBGView.backgroundColor=[UIColor whiteColor];
    contentBGView.layer.cornerRadius=10;
    
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(20, 36, rcScreen.size.width-100, 18)];
    titleLab.tag=100;
    titleLab.font=[UIFont systemFontOfSize:16];
    titleLab.textColor=[UIColor blackColor];
    titleLab.textAlignment=NSTextAlignmentCenter;
    titleLab.text=@"";
    [contentBGView addSubview:titleLab];
    
    UIImageView *classImageView=[[UIImageView alloc]initWithFrame:CGRectMake(contentBGView.frame.size.width/2.0-50, 87, 100, 100)];
    classImageView.tag=101;
    [contentBGView addSubview:classImageView];
    
    UILabel *classNameLab=[[UILabel alloc]initWithFrame:CGRectMake(20, 213, rcScreen.size.width-100, 14)];
    classNameLab.tag=102;
    classNameLab.font=[UIFont systemFontOfSize:13];
    classNameLab.textColor=[UIColor colorWithRed:80.0/255.0 green:80.0/255.0 blue:80.0/255.0 alpha:1.0];
    classNameLab.textAlignment=NSTextAlignmentCenter;
    classNameLab.text=@"";
    [contentBGView addSubview:classNameLab];
    
    UIActivityIndicatorView *activeInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activeInd setCenter:CGPointMake(contentBGView.frame.size.width/2.0, contentBGView.frame.size.height/2.0-20.0)];
    activeInd.tag=103;
    [contentBGView addSubview:activeInd];
    
    [m_viewTip addSubview:contentBGView];
    return m_viewTip;
}

-(UIView *)createIndicatorView{
    CGRect rcScreeno=[UIApplication sharedApplication].keyWindow.frame;
    CGRect rcScreen =CGRectMake(0, 0, rcScreeno.size.width, rcScreeno.size.height-65);
    UIView *m_viewTip=[[UIView alloc]initWithFrame:rcScreen];
    m_viewTip.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    m_viewTip.tag=2901;
    m_viewTip.backgroundColor=[UIColor clearColor];
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake((rcScreen.size.width-100.0)/2.0, (rcScreen.size.height-70.0)/2.0-32, 100, 70)];
    bgView.layer.cornerRadius=10.0;
    bgView.backgroundColor=[UIColor grayColor];
    bgView.alpha=0.6;
    [m_viewTip addSubview:bgView];
    
    UIActivityIndicatorView *activeInd=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activeInd setCenter:CGPointMake(rcScreen.size.width/2.0, (rcScreen.size.height-65)/2.0)];
    activeInd.tag=103;
    [m_viewTip addSubview:activeInd];
    return m_viewTip;
}

-(void)showIndicatorViewWithTitle:(NSString *)title content:(NSString *)content image:(UIImage *)image{
    UIView *m_viewTip=(UIView *)[self viewWithTag:2900];
    if (!m_viewTip) {
        m_viewTip=[self createIndicatorViewWithTitle];
    }
    if (title) {
        UILabel *labTitle=(UILabel *)[m_viewTip viewWithTag:100];
        labTitle.text=title;
    }
    if (content) {
        UILabel *labContent=(UILabel *)[m_viewTip viewWithTag:102];
        labContent.text=title;
    }
    if (image) {
        UIImageView *imageVInd=(UIImageView *)[m_viewTip viewWithTag:101];
        imageVInd.image=image;
    }
    UIActivityIndicatorView *active=(UIActivityIndicatorView *)[m_viewTip viewWithTag:103];
    [active startAnimating];
    //    [[UIApplication sharedApplication].keyWindow addSubview:m_viewTip];
    [self addSubview:m_viewTip];
}

-(void)showIndicatorView{
    UIView *m_viewTip=(UIView *)[self viewWithTag:2901];
    if (!m_viewTip) {
        m_viewTip=[self createIndicatorView];
    }
    UIActivityIndicatorView *active=(UIActivityIndicatorView *)[m_viewTip viewWithTag:103];
    [active startAnimating];
    [self addSubview:m_viewTip];
}

-(void)hideIndicatorView{
    UIView *m_viewTip=(UIView *)[self viewWithTag:2901];
    if (m_viewTip) {
        UIActivityIndicatorView * active = (UIActivityIndicatorView *)[m_viewTip viewWithTag:103];
        if (active) {
            [active stopAnimating];
        }
        [m_viewTip removeFromSuperview];
    }
}

#pragma mark - CustomIndicator Methods

-(UIView *)createCustomIndicatorView{
    CGRect rcScreeno=[UIApplication sharedApplication].keyWindow.frame;
    CGRect rcScreen =CGRectMake(0, 0, rcScreeno.size.width, rcScreeno.size.height-65);
    UIView *m_viewTip=[[UIView alloc]initWithFrame:rcScreen];
    m_viewTip.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    m_viewTip.tag=2903;
    m_viewTip.backgroundColor=[UIColor clearColor];//阻碍触摸效果
    
    UIImageView *indicator = [[UIImageView alloc] init];//通过图片
    indicator.tag = 104;
    indicator.image = [UIImage imageNamed:@"loading.png"];
    indicator.frame = CGRectMake(0.f, 0.f, indicator.image.size.width, indicator.image.size.height);
    
    indicator.center = CGPointMake(kScreenWidth * 0.5f, (kScreenHeight - 64) * 0.5f);//写死位置
    [m_viewTip addSubview:indicator];
    return m_viewTip;
}

- (void)showCustomIndicator
{
    [self hideCustomIndicator];
    UIView *m_viewTip=(UIView *)[self viewWithTag:2903];
    if (!m_viewTip) {
        m_viewTip=[self createCustomIndicatorView];
    }
    [self addSubview:m_viewTip];
    
    UIImageView *indicator=(UIImageView *)[m_viewTip viewWithTag:104];
    indicator.hidden = NO;
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat: M_PI * 2.f];
    rotation.duration = TIME_ONE_CIRCLE;
    rotation.repeatCount = MAXFLOAT;
    [indicator.layer addAnimation:rotation forKey:@"indicator"];//开始动画
}

- (void)showCustomIndicatorDelay
{
    [self showCustomIndicatorDuration:5];
}
- (void)showCustomIndicatorDuration:(CGFloat)interval
{
    [self showCustomIndicator];
    [self performSelector:@selector(hideCustomIndicator) withObject:nil afterDelay:interval];
}
- (void)hideCustomIndicator
{
    UIView *m_viewTip=(UIView *)[self viewWithTag:2903];
    if (m_viewTip) {
        UIImageView *indicator=(UIImageView *)[m_viewTip viewWithTag:104];
        
        [indicator.layer removeAnimationForKey:@"indicator"];//停止动画
        indicator.hidden = YES;
        [indicator removeFromSuperview];
        [m_viewTip removeFromSuperview];
    }
}
#pragma mark - 不影响UI

-(UIView *)createSimpleIndicatorView{
    CGRect rcScreeno=[UIApplication sharedApplication].keyWindow.frame;
    CGRect rcScreen =CGRectMake(0, 0, rcScreeno.size.width, rcScreeno.size.height-65);
    UIView *m_viewTip=[[UIView alloc]initWithFrame:rcScreen];
    m_viewTip.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    m_viewTip.tag=2904;
    m_viewTip.backgroundColor=[UIColor clearColor];//阻碍触摸效果
    
    UIImageView *indicator = [[UIImageView alloc] init];//通过图片
    indicator.tag = 105;
    indicator.image = [UIImage imageNamed:@"loading.png"];
    indicator.frame = CGRectMake(2.5f, 2.5f, indicator.image.size.width, indicator.image.size.height);
    [m_viewTip setFrame:CGRectMake((kScreenWidth - CGRectGetWidth(indicator.frame))/2, (kScreenHeight - 64 - CGRectGetHeight(indicator.frame))/2, CGRectGetWidth(indicator.frame)+5, CGRectGetHeight(indicator.frame)+5)];
    [m_viewTip addSubview:indicator];
    return m_viewTip;
}

- (void)showSimpleIndicator
{
    [self hideSimpleIndicator];
    UIView *m_viewTip=(UIView *)[self viewWithTag:2904];
    if (!m_viewTip) {
        m_viewTip=[self createSimpleIndicatorView];
    }
    
    [self addSubview:m_viewTip];
    
    UIImageView *indicator=(UIImageView *)[m_viewTip viewWithTag:105];
    indicator.hidden = NO;
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat: M_PI * 2.f];
    rotation.duration = TIME_ONE_CIRCLE;
    rotation.repeatCount = MAXFLOAT;
    [indicator.layer addAnimation:rotation forKey:@"indicator"];//开始动画
}

- (void)hideSimpleIndicator
{
    UIView *m_viewTip=(UIView *)[self viewWithTag:2904];
    if (m_viewTip) {
        UIImageView *indicator=(UIImageView *)[m_viewTip viewWithTag:105];
        
        [indicator.layer removeAnimationForKey:@"indicator"];//停止动画
        indicator.hidden = YES;
        [indicator removeFromSuperview];
        [m_viewTip removeFromSuperview];
    }
}


#pragma mark - CoverView Methods

-(UIView *)createCoverView{
    CGRect rcScreeno=[UIApplication sharedApplication].keyWindow.frame;
    CGRect rcScreen =CGRectMake(0, 0, rcScreeno.size.width, rcScreeno.size.height-65);
    UIView * viewCover =[[UIView alloc]initWithFrame:rcScreen];
    viewCover.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    viewCover.tag=2902;
    viewCover.backgroundColor=[UIColor grayColor];
    viewCover.alpha=0.4;
    return viewCover;
}


-(void)showCoverView
{
    UIView * viewCover =(UIView *)[self viewWithTag:2902];
    if (!viewCover) {
        viewCover=[self createCoverView];
    }
    [self addSubview:viewCover];
}

-(void)hideCoverView
{
    UIView * viewCover =(UIView *)[self viewWithTag:2902];
    if (viewCover) {
        [viewCover removeFromSuperview];
    }
}

@end

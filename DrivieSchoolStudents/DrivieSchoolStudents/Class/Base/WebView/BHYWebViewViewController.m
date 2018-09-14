//
//  BHYWebViewViewController.m
//  HuanYouth
//
//  Created by 卓森 on 2018/7/23.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "BHYWebViewViewController.h"

@interface BHYWebViewViewController ()<WKUIDelegate,WKNavigationDelegate>
{
    BOOL _isFinish;
}


@property (nonatomic,strong) UIProgressView *progress;


//返回按钮
@property (nonatomic, strong) UIBarButtonItem *backItem;
//关闭按钮
@property (nonatomic, strong) UIBarButtonItem *closeItem;
@end

@implementation BHYWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    //同时设置返回按钮和关闭按钮为导航栏左边的按钮
    self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //TODO:加载
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    
    //TODO:kvo监听，获得页面title和加载进度值
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
}

#pragma mark - 添加关闭按钮

- (void)addLeftButton
{
    self.navigationItem.leftBarButtonItem = self.backItem;
}

//点击返回的方法
- (void)backNative
{
    //判断是否有上一层H5页面
    if ([self.webView canGoBack]) {
        //如果有则返回
        [self.webView goBack];
        //同时设置返回按钮和关闭按钮为导航栏左边的按钮
        self.navigationItem.leftBarButtonItems = @[self.backItem, self.closeItem];
    } else {
        [self closeNative];
    }
}

//关闭H5页面，直接回到原生页面
- (void)closeNative
{
    [self.navigationController popViewControllerAnimated:YES];
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
//    JSJAccount *account = [JSJSave account];
//
//    NSString *jsString = [NSString stringWithFormat:@"localStorage.setItem('jsjToken', '%@')", account.access_token];
    
    // 移除localStorage
    // NSString *jsString = @"localStorage.removeItem('userContent')";
    // 获取localStorage
    // NSString *jsString = @"localStorage.getItem('userContent')";
//    [webView evaluateJavaScript:jsString completionHandler:nil];
    
    if (!_isFinish) {

        _isFinish = YES;

        [self.webView reload];
    }
}



#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        if (object == self.webView)
        {
            [self.progress setAlpha:1.0f];
            [self.progress setProgress:self.webView.estimatedProgress animated:YES];
            
//            if (!_isFinish) {
//            }
            if(self.webView.estimatedProgress >= 1.0f)
            {
                [UIView animateWithDuration:0.5f delay:0.3f options:UIViewAnimationOptionCurveEaseOut  animations:^{
                    [self.progress setAlpha:0.0f];
                    
                } completion:^(BOOL finished) {
                    [self.progress setProgress:0.0f animated:NO];
                    
                }];
//                if (!_isFinish) {
//
//                }
            }
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    //网页title
    else if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.webView)
        {
            self.navigationItem.title = self.webView.title;
        }
        else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark 移除观察者
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}



#pragma mark ------ 懒加载
- (WKWebView *)webView
{
    if (!_webView) {//初始化一个WKWebViewConfiguration对象
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        //初始化偏好设置属性：preferences
        config.preferences = [WKPreferences new];
        //The minimum font size in points default is 0;
        config.preferences.minimumFontSize = 10;
        //是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
        
        // 这行代码可以是侧滑返回webView的上一级，而不是根控制器（*只针对侧滑有效）
        [_webView setAllowsBackForwardNavigationGestures:true];
        _webView.UIDelegate = self;
        _webView.scrollView.scrollEnabled = YES;
        _webView.navigationDelegate = self;
        
        [self.view addSubview:_webView];
        
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _webView;
}

#pragma mark - WKNavigationDelegate
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    WKNavigationActionPolicy policy = WKNavigationActionPolicyAllow;
    NSURL *url = navigationAction.request.URL;
    if (WKNavigationTypeLinkActivated == navigationAction.navigationType && [url.scheme isEqualToString:@"https"]) {
        
        policy = WKNavigationActionPolicyCancel;
    }
    
    if ([navigationAction.request.URL.absoluteString isEqualToString:@"http://zhugujie.mxapp.cc./success"]) {
        
        [SVProgressHUD showSuccessWithStatus:@"添加地址成功"];
        [SVProgressHUD dismissWithDelay:1.5];
        sleep(1);
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    //允许跳转
    decisionHandler(policy);
}



- (UIProgressView *)progress
{
    if (!_progress) {
        
        _progress = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 5)];
        _progress.progressTintColor = ThemeColor;
        _progress.trackTintColor = TableColor;
        [self.view addSubview:_progress];
    }
    return _progress;
}



- (UIBarButtonItem *)backItem
{
    if (!_backItem) {
        _backItem = [[UIBarButtonItem alloc] init];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //这是一张“<”的图片，可以让美工给切一张
        UIImage *image = [UIImage imageNamed:@"goback"];
        [btn setImage:image forState:UIControlStateNormal];
        [btn setTitle:@" 返回" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(backNative) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setTitleColor:RGBCOLOR(31, 144, 230) forState:UIControlStateNormal];
        //字体的多少为btn的大小
        [btn sizeToFit];
        //左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //让返回按钮内容继续向左边偏移15，如果不设置的话，就会发现返回按钮离屏幕的左边的距离有点儿大，不美观
        //        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        btn.frame = CGRectMake(0, 0, 40, 50);
        _backItem.customView = btn;
        
        //        UILabel *lable = [UILabel labelWithText:@"关闭" font:kFont(15) textColor:RGBCOLOR(31, 144, 230) backGroundColor:ClearColor superView:nil];
        //
        //        lable.userInteractionEnabled=YES;
        //        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
        //
        //        [lable addGestureRecognizer:labelTapGestureRecognizer];
        //
        //        lable.size = CGSizeMake(31, 13);
        //
        //        UIBarButtonItem *item1 = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
        //        UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:lable];
        //
        //        NSArray *items = @[item1,item2];
        //        viewController.navigationItem.leftBarButtonItems = items;
    }
    return _backItem;
}

- (UIBarButtonItem *)closeItem
{
    if (!_closeItem) {
        //        _closeItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeNative)];
        UILabel *lable = [UILabel labelWithText:@"关闭" font:kFont(15) textColor:[UIColor blackColor] backGroundColor:ClearColor superView:nil];
        
        lable.userInteractionEnabled=YES;
        
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeNative)];
        
        [lable addGestureRecognizer:labelTapGestureRecognizer];
        
        lable.wz_size = CGSizeMake(31, 13);
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:lable];
        
        //        self.navigationItem.leftBarButtonItem = item;
        
        _closeItem = item;
    }
    return _closeItem;
}


@end

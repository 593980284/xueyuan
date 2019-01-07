//
//  EDSElegantDemeanourViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/21.
//  Copyright © 2018年 班文政. All rights reserved.
//#import "StyleDetailRequest.h"

#import "EDSElegantDemeanourViewController.h"
#import <WebKit/WebKit.h>
#import "StyleDetailRequest.h"
#import "ZanRequest.h"
@interface EDSElegantDemeanourViewController ()<WKNavigationDelegate>
@property(nonatomic, strong)WKWebView *webView;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)CAShapeLayer * progressLayer;
@property(nonatomic, strong)UILabel *titleLb;
@property(nonatomic, strong)UILabel *lookNumLb;
@property(nonatomic, strong)UILabel *zanLb;
@property(nonatomic, strong)UILabel *dateLb;
@property(nonatomic, strong)UIButton *zanBtn;
@property(nonatomic, strong)NSDictionary *dic;
@end

@implementation EDSElegantDemeanourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"驾校详情";
    _scrollView = [UIScrollView new];
    _scrollView.backgroundColor = [EDSToolClass getColorWithHexString:@"f5f5f5"];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-150*HC_750Ratio);
    }];
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    _webView = [WKWebView new];
    _webView.navigationDelegate = self;
    _webView.scrollView.scrollEnabled = NO;
    
    
   // [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    [_scrollView addSubview:view];
    [_scrollView addSubview:_webView];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(190*HC_750Ratio);
    }];
    _webView.frame = CGRectMake(0, 190*HC_750Ratio + 1, self.view.bounds.size.width, self.view.bounds.size.height- 190*HC_750Ratio);
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    
    _titleLb = [UILabel new];
    _titleLb.hcTextBlock([UIColor blackColor], [UIFont systemFontOfSize:18], 0);
    
    UIImageView *lookImgView =[UIImageView new];
    lookImgView.hcImageBlock(@"look");
    
    _lookNumLb = [UILabel new];
    _lookNumLb.hcTextBlock([EDSToolClass getColorWithHexString:@"666666"], [UIFont systemFontOfSize:14], 0);
    
    UIImageView *zanImgView =[UIImageView new];
    zanImgView.hcImageBlock(@"zan");
    
    _zanLb = [UILabel new];
    _zanLb.hcTextBlock([EDSToolClass getColorWithHexString:@"666666"], [UIFont systemFontOfSize:14], 0);
    
    _dateLb = [UILabel new];
    _dateLb.hcTextBlock([EDSToolClass getColorWithHexString:@"666666"], [UIFont systemFontOfSize:14], 2);
    
    [view addSubview:_titleLb];
    [view addSubview:lookImgView];
    [view addSubview:_lookNumLb];
    [view addSubview:_zanLb];
    [view addSubview:zanImgView];
    [view addSubview:_dateLb];
    
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-15);
    }];
    [lookImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(40*HC_750Ratio);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-15*HC_750Ratio);
    }];
    [_lookNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lookImgView.mas_right).offset(10);
        make.height.mas_equalTo(20*HC_750Ratio);
        make.centerY.mas_equalTo(lookImgView.mas_centerY);
        make.width.mas_equalTo(130*HC_750Ratio);
    }];
    [zanImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(40*HC_750Ratio);
        make.left.mas_equalTo(self.lookNumLb.mas_right);
        make.bottom.mas_equalTo(-15*HC_750Ratio);
    }];
    [_zanLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(zanImgView.mas_right).offset(10);
        make.height.mas_equalTo(20*HC_750Ratio);
        make.centerY.mas_equalTo(lookImgView.mas_centerY);
        make.width.mas_equalTo(130*HC_750Ratio);
    }];
    [_dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.zanLb.mas_right);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(lookImgView.mas_centerY);
    }];
    
    [self getData];
    
    _zanBtn = [UIButton new];
    [_zanBtn setBackgroundImage:[UIImage imageNamed:@"n点赞"] forState:0];
    [_zanBtn setBackgroundImage:[UIImage imageNamed:@"n已赞"] forState:UIControlStateSelected];
    [_zanBtn addTarget:self action:@selector(btnTap:) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:_zanBtn];
    [_zanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_bottom);
        make.right.mas_equalTo(-20);
        make.width.height.mas_equalTo(100*HC_750Ratio);
    }];
    [self btnTap:nil];//记录点击量
}

- (void)btnTap:(UIButton *)sender
{
    [self.view showIndicatorView];
    __weak typeof(self) weakSelf = self;
    ZanRequest *request = [ZanRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        [weakSelf.view hideIndicatorView];
        NSArray *array = responseDict[@"list"];
        NSDictionary *dic = @{};
        if (array) {
            dic = array.firstObject;
        };
        if (!dic) {
            dic = @{};
        }
            weakSelf.lookNumLb.text = [NSString stringWithFormat:@"%@",dic[@"clickCount"]];
            weakSelf.zanLb.text = [NSString stringWithFormat:@"%@",dic[@"likeCount"]];
            weakSelf.zanBtn.selected = !weakSelf.zanBtn.selected;
    } failureBlock:^(NSError *error) {
        [weakSelf.view hideIndicatorView];
    }];
    request.phone = [EDSSave account].phone;
    request.styleId = self.schoolId;
    if (sender) {
        request.type =sender.selected ? @"2" : @"1";
    }else{
        request.type = @"0";
    }
    [request startRequest];
}

- (void)getData
{
    __weak typeof(self) weakSelf = self;
    StyleDetailRequest *request = [StyleDetailRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        NSArray *array = responseDict[@"list"];
        NSDictionary *dic = @{};
        if (array) {
            dic = array.firstObject;
        };
        if (!dic) {
            dic = @{};
        }
        weakSelf.titleLb.text = dic[@"styleName"];
        weakSelf.lookNumLb.text = [NSString stringWithFormat:@"%@",dic[@"clickCount"]];
        weakSelf.zanLb.text = [NSString stringWithFormat:@"%@",dic[@"likeCount"]];
        weakSelf.dateLb.text = dic[@"creatTime"];
        weakSelf.zanBtn.selected = [dic[@"isLike"] boolValue];
        NSString *url = dic[@"styleContent"];
        url = [url  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        if (url) {
          //  url = @"https://www.jianshu.com/p/ccf3014ca6a6";
            [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        }
    } failureBlock:^(NSError *error) {
        
    }];
    request.styleId = self.schoolId;
    request.phone = [EDSSave account].phone;
    [request startRequest];
}

- (CAShapeLayer *)progressLayer
{
    if (!_progressLayer) {
        CGFloat width = self.view.bounds.size.width;
        _progressLayer = [CAShapeLayer new];
        _progressLayer.lineWidth = 2;
        _progressLayer.strokeColor = [UIColor blueColor].CGColor;
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointMake(0, 2)];
        [bezierPath addLineToPoint:CGPointMake(width, 2)];
        _progressLayer.path = bezierPath.CGPath;
        [self.view.layer addSublayer:_progressLayer];
        _progressLayer.frame =CGRectMake(0, 2, self.view.bounds.size.width, 10);
    }
    return _progressLayer;
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    //加载进度值
    
    
    if ([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.progressLayer.hidden = NO;
        NSNumber* value = change[@"new"];
        __weak typeof(self) weakSelf = self;
        CGFloat progress = value.floatValue;
        weakSelf.progressLayer.strokeEnd = progress;
        if (progress == 1) {
            [self performSelector:@selector(hide) withObject:nil afterDelay:0.3];
        }
        
    }else if ([keyPath isEqualToString:@"contentSize"]){
        NSValue* value = change[@"new"];
        CGSize size = [value CGSizeValue];
        CGFloat height = size.height;
        CGRect webFrame = _webView.frame;
        webFrame.size.height = height;
        _webView.frame = webFrame;
        self.scrollView.contentSize = CGSizeMake(0, height+ 100);
    }
}

- (void)hide
{
    self.progressLayer.hidden = YES;
    self.progressLayer.strokeEnd = 0;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation
{
    
}


- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

/*! @abstract Invoked when a main frame navigation completes.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation
{
    
}

/*! @abstract Invoked when an error occurs during a committed main frame
 navigation.
 @param webView The web view invoking the delegate method.
 @param navigation The navigation.
 @param error The error that occurred.
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self hide];
}



@end

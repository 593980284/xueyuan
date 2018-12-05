//
//  BHYWebViewViewController.h
//  HuanYouth
//
//  Created by 卓森 on 2018/7/23.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "BHYBaseViewController.h"
#import <WebKit/WebKit.h>

@interface BHYWebViewViewController : BHYBaseViewController
/** <#简介#> */
@property (nonatomic, copy) NSString *webUrl;

@property (nonatomic, strong) WKWebView  *webView;
@end

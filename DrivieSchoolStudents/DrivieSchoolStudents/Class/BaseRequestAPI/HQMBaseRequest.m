//
//  HQMBaseRequest.m
//  Buddy
//
//  Created by 小伴 on 2016/12/14.
//  Copyright © 2016年 huang qimeng. All rights reserved.
//

#import "HQMBaseRequest.h"
#import "Reachability.h"
#import "EDSPSWLogoViewController.h"
#import "XGPush.h"

//#import "BHYLoginWindow.h"

#if __has_include(<AFNetworking/AFNetworking.h>)
    #import <AFNetworking/AFNetworking.h>
#else
    #import "AFNetworking.h"
#endif

///< SSL证书名称，仅支持cer格式。本 Demo 没有导入HTTPS证书，如果有需要请导入自己的，HTTPS 证书验证的代码是正确的
#define kCertificateName @"httpsServerAuth"

#ifdef DEBUG //处于开发测试阶段

NSString * const HQMNetworkDomain = @"http://111.39.245.156:8087";

///< 关闭https SSL 验证
#define kOpenHttpsAuth NO

#else //处于发布正式阶段

NSString * const HQMNetworkDomain = @"http://111.39.245.156:8087";

///< 开启https SSL 验证
#define kOpenHttpsAuth NO

#endif

@interface HQMBaseRequest ()
{
    NSInteger _page;
    NSString *_url;
    NSString *_timestamp;
    NSTimeInterval _timeoutInterval;
    BOOL _networkIsError;
    AFHTTPSessionManager *_manager;
    NSURLSessionTask *_requestTask;
    dispatch_queue_t _processingQueue;
}

@end

@implementation HQMBaseRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initHttpSessionManager];
    }
    return self;
}

- (void)initHttpSessionManager {
    _networkIsError = NO;
    _page = 1;
    _showHUD = NO;
    _timeoutInterval = 10.;
    _manager = [AFHTTPSessionManager manager];

    //_processingQueue = dispatch_group_create();

    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/html",nil];
    if (kOpenHttpsAuth) {
        [_manager setSecurityPolicy:[self customSecurityPolicy]];
    }
    [_manager.requestSerializer setHTTPShouldHandleCookies:YES];
}

- (instancetype)initWithSuccessBlock:(HQMRequestSuccessBlock)successBlock
                        failureBlock:(HQMRequestFailureBlock)failureBlock
{
    if (self = [self init]) {
        self.successBlock = successBlock;
        self.failureBlock = failureBlock;
        self.uploadProgress = nil;
    }
    return self;
}

+ (instancetype)requestWithSuccessBlock:(HQMRequestSuccessBlock)successBlock failureBlock:(HQMRequestFailureBlock)failureBlock {
    return [[[self class] alloc] initWithSuccessBlock:successBlock failureBlock:failureBlock];
}

- (void)startCompletionBlockWithSuccess:(HQMRequestSuccessBlock)success failure:(HQMRequestFailureBlock)failure {
    self.successBlock = success;
    self.failureBlock = failure;
    self.uploadProgress = nil;
}


- (void)startUploadTaskWithSuccess:(HQMRequestSuccessBlock)success
                           failure:(HQMRequestFailureBlock)failure
                    uploadProgress:(AFURLSessionTaskProgressBlock)uploadProgress
{
    self.successBlock = success;
    self.failureBlock = failure;
    self.uploadProgress = uploadProgress;
}

- (void)startRequest {
    _networkIsError = [[Reachability reachabilityWithHostName:HQMNetworkDomain] currentReachabilityStatus] == NotReachable ? YES : NO;
    if (_networkIsError) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //处理
            [[self currentViewController].view makeToast:@"网络连接暂时不可用"];
        });
        return;
    }
    //拼接请求路径
    [self constructURL];

    //AFN 已经很强大了，不用手动拼接 URL 参数，AFN 可以帮你处理好 url 入参
    [self constructSessionTask];
}

- (void)constructURL {
    _url = [NSString stringWithFormat:@"%@%@", HQMNetworkDomain, [self requestURLPath]];
}

- (void)constructSessionTask {
    NSError * __autoreleasing requestSerializationError = nil;
    
    _requestTask = [self sessionTaskForError:&requestSerializationError];

    [_requestTask resume];
}

#warning 此处可以配置所有请求都需要的共同的参数 这里可以配置请求方式
- (NSURLSessionTask *)sessionTaskForError:(NSError *__autoreleasing *)error {
    HQMRequestMethod method = [self requestMethod];

    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[self requestArguments]];

//    //此处可以配置所有请求都需要的共同的参数，比如 token
    AFConstructingBodyBlock constructingBodyBlock = [self constructingBodyBlock];
    AFHTTPRequestSerializer *requestSerializer = [self requestSerializer];

    switch (method) {
        case HQMRequestMethodGET: {
            return [self dataTaskWithHTTPMethod:@"GET"
                              requestSerializer:requestSerializer
                                      URLString:_url
                                     parameters:params
                                 uploadProgress:nil
                               downloadProgress:nil
                      constructingBodyWithBlock:nil
                                          error:error];
        } break;
        case HQMRequestMethodPOST: {
            return [self dataTaskWithHTTPMethod:@"POST"
                              requestSerializer:requestSerializer
                                      URLString:_url
                                     parameters:params
                                 uploadProgress:self.uploadProgress
                               downloadProgress:nil
                      constructingBodyWithBlock:constructingBodyBlock
                                          error:error];
        } break;
    }
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                               requestSerializer:(AFHTTPRequestSerializer *)requestSerializer
                                       URLString:(NSString *)URLString
                                      parameters:(id)param
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                       constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData>formData))block
                                           error:(NSError * _Nullable __autoreleasing *)error
{
    NSMutableURLRequest *request = nil;

    
    if (block) {
        request = [requestSerializer multipartFormRequestWithMethod:method URLString:URLString parameters:param constructingBodyWithBlock:block error:error];
    } else {
        request = [requestSerializer requestWithMethod:method URLString:URLString parameters:param error:error];
    }

    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [_manager dataTaskWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        //AFN 返回的数据responseObject已经是字典了，不必再用NSJSONSerialization解析了
        [self handleRequestResult:dataTask response:response responseObject:responseObject error:error];
    }];

    if ([method isEqualToString:@"GET"]) {
        DLog(@"GET-->url:%@", dataTask.currentRequest.URL.absoluteString);
    } else {
        DLog(@"POST-->url:%@", dataTask.currentRequest.URL.absoluteString);
    }
    return dataTask;
}

- (AFHTTPRequestSerializer *)requestSerializer {
    AFHTTPRequestSerializer *requestSerializer = nil;
    switch ([self requestSerializerType]) {
        case HQMRequestSerializerTypeHTTP: {
            requestSerializer = [AFHTTPRequestSerializer serializer];
        } break;
        case HQMRequestSerializerTypeJSON: {
            requestSerializer = [AFJSONRequestSerializer serializer];
        } break;
    }

    requestSerializer.timeoutInterval = [self requestTimeoutInterval];
    requestSerializer.allowsCellularAccess = [self allowsCellularAccess];


    return requestSerializer;
}

- (void)requestDidFailWithRequest:(NSURLRequest *)request error:(NSError *)error {
//    DLog(@"Request %@ failed, status code = %ld, error = %@",
//           NSStringFromClass([request class]), (long)request.responseStatusCode, error.localizedDescription);
}


#pragma mark ------------------------ 数据处理以及回调 --------------------------------
- (void)handleRequestResult:(NSURLSessionDataTask *)dataTask
                   response:(NSURLResponse *)response
             responseObject:(id)responseObject
                      error:(NSError *)error
{
///< 当前处于开发模式、模拟器环境下,才显示 HTTP 返回的状态码,方便调试
#ifdef DEBUG //处于开发阶段
    #if TARGET_IPHONE_SIMULATOR
        //iPhone Simulator
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        NSInteger statusCode = res.statusCode;
        NSString *status_str = [NSHTTPURLResponse localizedStringForStatusCode:res.statusCode];
//        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"HTTP状态码:%ld-->状态码描述：%@", statusCode, status_str]];
//        [SVProgressHUD dismissWithDelay:3];
    #endif
#endif
    
    [self saveCookies];
    
    DLog(@"---------------%ld",(long)error.code);
    if (error) {
        NSString *errString = error.localizedFailureReason;
        DLog(@"+_+_+%@+_+_+%@", error, errString);

        if (error.code == -1011) {//请求超时情况的处理
            NSData *data = [error.userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
            errString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            DLog(@"_+_+%@+_+%@", data, errString);
            
            NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
            NSInteger statusCode = res.statusCode;
            if (statusCode == 401) {
                
//                [[BHYLoginWindow sharedInstance] show];
                [self handleData:@{} errCode:statusCode];
            }
        }

        _showHUD = YES;
        if (self.failureBlock) {
            self.failureBlock(error);
        }

        if (_delegate && [_delegate respondsToSelector:@selector(requestDidFailWithError:)]) {
            [_delegate requestDidFailWithError:error];
        }

        if (_showHUD) {
            NSString *errorStr = [responseObject valueForKey:@"error_msg"];
            if (errorStr.length > 0) {
                errorStr = errorStr;
            }else{
                errorStr = @"网络连接失败";
            }
            [[self currentViewController].view makeToast:errorStr];
        }
        _showHUD = NO;
    }
    else {
        
        NSInteger code = [[responseObject objectForKey:@"flg"] integerValue];
        if (code == 1) {
            
            id resultData = [responseObject objectForKey:@"data"];
            if (_showHUD) {
                
                [[UIApplication sharedApplication].keyWindow makeToast:[responseObject valueForKey:@"msg"]];
            }
            DLog(@"resultData:%@",resultData);
            [self handleData:resultData errCode:1];
            
        }else if (code == -2){
            
            [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:[EDSSave account].phone type:XGPushTokenBindTypeAccount];
            EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] initWithNibName:@"EDSPSWLogoViewController" bundle:[NSBundle mainBundle]];
            
            [[self currentViewController] presentViewController:vc animated:YES completion:nil];
            [self handleData:@{} errCode:-2];
        }
        else{
            
            id resultData = @{};
            DLog(@"resultData:%@",resultData);
            [[self currentViewController].view makeToast:[responseObject valueForKey:@"msg"]];
            [self handleData:resultData errCode:0];
        }
        
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self clearCompletionBlock];
    });
}

//

//保存Cookie
- (void)saveCookies
{
    NSData*cookiesData = [NSKeyedArchiver archivedDataWithRootObject:[[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cookiesData forKey:@"org.skyfox.cookie"];
    [defaults synchronize];
}

///< nil out to break the retain cycle.
- (void)clearCompletionBlock {
    self.successBlock = nil;
    self.failureBlock = nil;
}

- (NSTimeInterval)requestTimeoutInterval {
    return _timeoutInterval;
}

///< 允许使用蜂窝移动网
- (BOOL)allowsCellularAccess {
    return YES;
}

- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
    NSString *token = @"";//;[BHYSave account].token;
    token = token.length > 0 ? token : @"";
    return @{@"JSESSIONID":@"22A870EF293FE2C8A49E6A734AF935F6"};
//     return nil;
}

- (HQMRequestMethod)requestMethod {
    return HQMRequestMethodGET;
}

- (HQMRequestSerializerType)requestSerializerType {
    return HQMRequestSerializerTypeHTTP;
}

- (NSDictionary *)requestArguments {
    NSAssert([self isMemberOfClass:[HQMBaseRequest class]], @"子类必须实现requestArguments");
    return nil;
}

- (NSString *)requestURLPath {
    NSAssert([self isMemberOfClass:[HQMBaseRequest class]], @"子类必须实现requestURLPath");
    return nil;
}

- (AFConstructingBodyBlock)constructingBodyBlock {
    return nil;
}

- (void)handleData:(id)data errCode:(NSInteger)errCode {
    NSAssert([self isMemberOfClass:[HQMBaseRequest class]], @"子类必须实现handleData:data errCode:errCode");
}

/**
 *  新增的方法，用来验证https证书
 *
 *  @return 证书模式的SecurityPolicy，AFSecurityPolicy有3种安全验证方式
 *          具体看头文件的枚举
 */
- (AFSecurityPolicy *)customSecurityPolicy {
    //先导入证书到项目
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:kCertificateName ofType:@"cer" inDirectory:@"HttpsServerAuth.bundle"];//证书的路径
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];

    DLog(@"%@--%@", cerPath, cerData);

    //AFSSLPinningModeCertificate使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];

    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;

    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;

    //validatesCertificateChain 是否验证整个证书链，默认为YES
    //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
    //GeoTrust Global CA
    //    Google Internet Authority G2
    //        *.google.com
    //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
    //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证，因为整个证书链一一比对是完全没有必要（请查看源代码）；
//    securityPolicy.validatesCertificateChain = NO;

    NSSet *cerDataSet = [NSSet setWithArray:@[cerData]];
    securityPolicy.pinnedCertificates = cerDataSet;

    return securityPolicy;
}

@end

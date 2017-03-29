//
//  WJBaseAPI.m
//  DJHDecorate
//
//  Created by maoyuxiang on 16/5/25.
//  Copyright © 2016年 maoyuxiang. All rights reserved.
//

#import "YXBaseAPI.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface YXBaseAPI()

/**
 AFHTTPSessionManager对象
 */
@property(strong, nonatomic) AFHTTPSessionManager *manager;

/**
 网络请求队列
 */
@property(strong, nonatomic) NSMutableArray *requestQueue;

/**
 网络状态监测对象
 */
@property(strong, nonatomic) AFNetworkReachabilityManager *reachabilityManager;

@end


@implementation YXBaseAPI

- (instancetype)init
{
    self = [super init];
    if (self) {
        //检查网络状态的改变
        [self checkNetworkStatusState];
    }
    return self;
}

#pragma mark - 发起网络异步请求

- (void)sendRequest:(YXHttpRequest *)request{
    if (!request) {
        return;
    }
    if (!request.url) {
        return;
    }
    // 开启网络指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //防止循环引用
    __weak typeof(self) weakSelf = self;

    //发起请求
    NSURLSessionDataTask * task = nil;
    
    if(request.requestMethod == HttpRequestMethodGet){
        //GET请求
        task = [self.manager GET:request.url parameters:request.param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf responseSuccessWithResponseObject:responseObject request:request];
            [weakSelf removeTaskFromRequestQueue:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf responseFailedWithError:error request:request];
            [weakSelf removeTaskFromRequestQueue:task];
        }];
    }
    else if (request.requestMethod == HttpRequestMethodPost){
        //POST请求
        task = [self.manager POST:request.url parameters:request.param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf responseSuccessWithResponseObject:responseObject request:request];
            [weakSelf removeTaskFromRequestQueue:task];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf responseFailedWithError:error request:request];
            [weakSelf removeTaskFromRequestQueue:task];
        }];
    }
    else if (request.requestMethod == HttpRequestMethodDelete){
        //DELETE请求
        task = [self.manager DELETE:request.url parameters:request.param success:^(NSURLSessionDataTask *task, id responseObject) {
            [weakSelf responseSuccessWithResponseObject:responseObject request:request];
            [weakSelf removeTaskFromRequestQueue:task];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [weakSelf responseFailedWithError:error request:request];
            [weakSelf removeTaskFromRequestQueue:task];
        }];
    }
    else{
        return ;
    }
    
    //把task加进请求队列
    request.task = task;
    [self.requestQueue addObject:request];
    
    [self logForRequestQueue];
}


- (void)sendRequest:(YXHttpRequest *)request imageData:(NSData *)imageData{
    // 开启网络指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //防止循环引用
    __weak typeof(self) weakSelf = self;
    
    //发起请求
    NSURLSessionDataTask * task = [self.manager POST:request.url parameters:request.param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:imageData name:@"img" fileName:fileName mimeType:@"image/png"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf responseSuccessWithResponseObject:responseObject request:request];
        [weakSelf removeTaskFromRequestQueue:task];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf responseFailedWithError:error request:request];
        [weakSelf removeTaskFromRequestQueue:task];
    }];
    
    //把task加进请求队列
    request.task = task;
    [self.requestQueue addObject:request];
}


#pragma mark - 取消网络请求
- (void)cancelRequest:(YXHttpRequest *)request{
    if ([self.requestQueue containsObject:request]) {
        NSURLSessionDataTask * task = request.task;
        if (task) {
            [task cancel];
            [self.requestQueue removeObject:request];
        }
    }
}

- (void)cancelAllRequest{
    NSLog(@"*************************开始取消所有请求*************************");
    [self.manager.operationQueue cancelAllOperations];
    [self.requestQueue removeAllObjects];
    NSLog(@"*************************取消所有请求结束*************************\n");
    [self logForRequestQueue];
}

- (void)removeTaskFromRequestQueue:(NSURLSessionDataTask *)task{
    
    [self.requestQueue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YXHttpRequest * request = (YXHttpRequest *)obj;
        if ([task isEqual:request.task]) {
            [self.requestQueue removeObject:request];
            *stop = YES;
        }
    }];
    
    [self logForRequestQueue];
}

- (void)logForRequestQueue{
    NSLog(@"当前请求队列：\n");
    [self.requestQueue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"request%lu:%@",(unsigned long)idx,obj);
    }];
}


/**
 检查网络状态改变
 */
- (void)checkNetworkStatusState{
    //创建网络监听者管理者对象
    self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];

    //设置网络监听
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
//                [MBProgressHUD showError:@"未识别的网络"];
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
//                [MBProgressHUD showError:@"不可达的网络(未连接)"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
//                [MBProgressHUD showError:@"蜂窝数据"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
//                [MBProgressHUD showError:@"Wifi网络"];
                break;
            default:
                break;
        }
    }];
    //开始监听
    [self.reachabilityManager startMonitoring];
}

/**
 *  设置网络错误提示
 *
 *  @param error 错误参数
 */
- (void)showError:(NSError *)error
{
    if([error code] == NSURLErrorTimedOut){
        [MBProgressHUD showError:@"网络连接超时" toView:[[UIApplication sharedApplication]keyWindow]];
    }
    else if ([error code] == NSURLErrorNotConnectedToInternet){
        [MBProgressHUD showError:@"网络不可用" toView:[[UIApplication sharedApplication]keyWindow]];
    }
    else{
        [MBProgressHUD showError:@"网络连接错误" toView:[[UIApplication sharedApplication]keyWindow]];
    }
}

#pragma mark -处理网络请求回调结果
/**
   http请求成功之后，处理相关的返回数据
 */
- (void)responseSuccessWithResponseObject:(id)responseObject request:(YXHttpRequest *)request{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        YXHttpResponse * response = [[YXHttpResponse alloc]initWithRequest:request dictionary:responseObject];
        [self parseWithResponse:response];
    }
    else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestFailedWithResponse:)])
        {
            YXHttpResponse * response = [[YXHttpResponse alloc]init];
            response.request = request;
            response.message = @"数据解析格式不对";
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestFailedWithResponse:)]){
                [self.delegate requestFailedWithResponse:response];
            }
        }
    }
}


/**
 http请求失败的相关处理
 */
- (void)responseFailedWithError:(NSError *)error request:(YXHttpRequest *)request{
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestFailedWithResponse:)])
    {
        [self showError:error];
        YXHttpResponse * response = [[YXHttpResponse alloc]init];
        response.request = request;
        response.systemError = error;
        [self.delegate requestFailedWithResponse:response];
    }
}


/**
 解析成功返回的数据
 */
- (void)parseWithResponse:(YXHttpResponse *)response{
    // 关闭网络指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


/**
 回调代理方法
 */
- (void)invokeRequestFinishedDelegateWithResponse:(YXHttpResponse *)response{
    if (self.delegate && [self.delegate respondsToSelector:@selector(requestFinishedWithResponse:)])
    {
        [self.delegate requestFinishedWithResponse:response];
    }
}

#pragma mark - getter
- (NSMutableArray *)requestQueue{
    if (!_requestQueue) {
        _requestQueue = [[NSMutableArray alloc]init];
    }
    return _requestQueue;
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [[AFHTTPSessionManager alloc]init];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain",@"text/html", nil];
        // 设置超时时间
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = kNetTimeoutInterval;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _manager;
}

@end

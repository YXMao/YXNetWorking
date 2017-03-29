//
//  WJPoPAdAPI.m
//  Wujie
//
//  Created by maoyuxiang on 2017/3/22.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#import "YXPopAdAPI.h"

@implementation YXPopAdAPI

#pragma mark - 请求接口
- (YXHttpRequest *)requestPopAd{
    NSString *url = [NSString stringWithFormat:@"%@app=popads&act=getPopAds", [YXNetWorkConfig shareInstance].baseUrl];
    YXHttpRequest * request = [[YXHttpRequest alloc]init];
    request.url = url;
    request.identity = NET_POP_ADS_TAG;
    [self sendRequest:request];
    return request;
}


#pragma mark - 分解网络请求
- (void)parseWithResponse:(YXHttpResponse *)response{
    [super parseWithResponse:response];
    
    if ([response.request.identity isEqualToString:NET_POP_ADS_TAG]) {
        //检查登录是否成功
        [self parsePopAdsWithResponse:response];
    }
}


#pragma mark - 解析网络返回数据
- (void)parsePopAdsWithResponse:(YXHttpResponse *)response{
    NSLog(@"%@",response.data);
    
    NSString * string = [YXAPIParser parseToStringWithKey:nil response:response];
    response.parseResult = string;
    
    [self invokeRequestFinishedDelegateWithResponse:response];
    
}

@end

//
//  WJBaseAPI.h
//  DJHDecorate
//
//  Created by maoyuxiang on 16/5/25.
//  Copyright © 2016年 maoyuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXHttpRequest.h"
#import "YXHttpResponse.h"
#import "YXNetWorkConfig.h"
#import "YXHttpProtocol.h"
#import "YXAPIParser.h"

static const NSInteger kNetTimeoutInterval = 30;//网络超时时间


/**
 网络请求基类，用于实现网络的请求，响应和取消
 */
@interface YXBaseAPI : NSObject

@property(assign, nonatomic) id<YXHttpDelegate> delegate;

/**
 *  一般网络请求
 */
- (void)sendRequest:(YXHttpRequest *)request;

/**
 *  带图片上传的网络请求
 */
- (void)sendRequest:(YXHttpRequest *)request imageData:(NSData *)imageData;

/**
 取消某个特定的网络请求
 */
- (void)cancelRequest:(YXHttpRequest *)request;

/**
 取消所有的网络请求
 */
- (void)cancelAllRequest;

/**
 *  解析网络数据
 */
- (void)parseWithResponse:(YXHttpResponse *)response;

/**
 回调代理方法
 */
- (void)invokeRequestFinishedDelegateWithResponse:(YXHttpResponse *)response;

@end

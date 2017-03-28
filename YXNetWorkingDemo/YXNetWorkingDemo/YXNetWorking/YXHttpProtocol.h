//
//  YXHttpProtocol.h
//  Wujie
//
//  Created by maoyuxiang on 2017/3/21.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#ifndef YXHttpProtocol_h
#define YXHttpProtocol_h

#import "YXHttpResponse.h"
/**
 *  该类负责网络请求结果的回调代理
 */

@protocol YXHttpDelegate <NSObject>

@required

/**
 网络请求成功之后的回调
 @param response YXHttpResponse对象
 */
- (void)requestFinishedWithResponse:(YXHttpResponse *)response;

/**
 网络请求失败之后的回调（引起此方法的调用有两种情况：1.服务器范围的不是json对象 2.请求服务器失败）
 @param response YXHttpResponse对象
 */
- (void)requestFailedWithResponse:(YXHttpResponse *)response;

@end


#endif /* YXHttpProtocol_h */

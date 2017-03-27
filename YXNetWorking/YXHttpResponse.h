//
//  WJHttpResponse.h
//  Wujie
//
//  Created by maoyuxiang on 2017/3/20.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXHttpRequest.h"

typedef NS_ENUM(NSInteger, ErrorCodeType) {
    ErrorCodeTypeSuccess = 0,//成功
    ErrorCodeTypeNotLogin = 101,//您未登录
    ErrorCodeTypeWrongPassword = 102,//密码错误
    ErrorCodeTypeNotExistUser = 103,//该用户不存在
    ErrorCodeTypeWrongUserNameOrPassword = 104,//用户名密码不匹配
    ErrorCodeTypeConnectLoginFailed = 105,//连接登录失败
    ErrorCodeTypeHaveRegistered = 106,//用户名已被注册过
    ErrorCodeTypeNotExistRequestMethod = 201,//请求的方法不存在
    ErrorCodeTypeMissingRequestField = 202,//缺少请求字段
    ErrorCodeTypeWrongRequestFieldFormat = 203,//请求字段格式错误
    ErrorCodeTypeWrongRequest = 204,//非法请求（不匹配）
    ErrorCodeTypeRequestTimeout = 205,//请求超时
    ErrorCodeTypeRequestForbidden = 206,//请求被禁止
    ErrorCodeTypeOperationFast = 207,//您操作速度过快，请稍后重新尝试
    ErrorCodeTypeNoData = 208,//暂无数据
    ErrorCodeTypeOverLimitNumberToday = 209,//超过今日限制数量
    ErrorCodeTypeContainIllegalWord = 210,//包含违禁词汇
    ErrorCodeTypeCreditNotEnough = 211,//您的积分不足
    ErrorCodeTypeWrongVerifyCode = 212,//验证码不正确
    ErrorCodeTypeFailedOperation = 213,//操作失败
};

//通用key
#define codenumber @"code"
#define datas @"data"
#define msg @"msg"



/**
 网络请求响应类
 */
@interface YXHttpResponse : NSObject

/**
 服务器返回的状态码
 */
@property(assign, nonatomic) ErrorCodeType code;

/**
 提示信息
 */
@property(copy, nonatomic) NSString *message;

/**
 返回数据
 */
@property(strong, nonatomic) id data;

/**
 NSError
 */
@property(strong, nonatomic) NSError * systemError;

/**
 附带的信息
 */
@property(strong, nonatomic) NSDictionary *userInfo;


/**
 request请求对象
 */
@property(strong, nonatomic) YXHttpRequest *request;


/**
 解析后的数据
 */
@property(strong, nonatomic) id parseResult;

/**
 返回对应的YXHttpResponse对象
 */
- (instancetype)initWithRequest:(YXHttpRequest *)request dictionary:(NSDictionary *)dictionary ;


@end

//
//  WJRequest.h
//  Wujie
//
//  Created by maoyuxiang on 2017/3/20.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HttpRequestMethod) {
    HttpRequestMethodGet,
    HttpRequestMethodPost,
    HttpRequestMethodDelete,
};


/**
 网络请求类
 */
@interface YXHttpRequest : NSObject

/**
 请求地址的url
 */
@property(copy, nonatomic) NSString *url;

/**
 请求的参数
 */
@property(copy, nonatomic) NSDictionary *param;

/**
 请求对象的唯一标识
 */
@property(copy, nonatomic) NSString *identity;;

/**
 请求类型(默认为post)
 */
@property(assign, nonatomic) HttpRequestMethod requestMethod;

/**
 请求task
 */
@property(strong, nonatomic) NSURLSessionDataTask *task;



@end

//
//  YXAPIParser.h
//  Wujie
//
//  Created by maoyuxiang on 2017/3/21.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXHttpResponse.h"

#define NOTIFICATION_USERINFO_UPDATE_FAILED     @"NOTIFICATION_USERINFO_UPDATE_FAILED"
#define NOTIFICATION_USERINFO_UPDATE_SUCCESS    @"NOTIFICATION_USERINFO_UPDATE_SUCCESS"

#define ResponseKey @"ResponseKey"


/**
 此类负责解析网络响应数据
 */
@interface YXAPIParser : NSObject

#pragma mark 数据统一解析
/**
 返回字符串的数据统一解析,如
 data:{
 key: “123”;
 key1:[];
 key2:{};
 }
 @param key 所要解析json数据的key（如果key传nil，则默认取key=data对应的value值）
 @param response response对象
 @return 解析后的对象
 */
+ (NSString *)parseToStringWithKey:(NSString *)key response:(YXHttpResponse *)response;

/**
 返回object的数据统一解析,如
 data:{
 key: value;
 key1:[];
 key2:{};
 }
 @param modelName 解析后数组元素中的实体类名称（如果modelName为nil，则默认不做model对象化处理）
 @param key 所要解析json数据的key（如果key传nil，则默认取key=data对应的value值）
 @param response response对象
 @return 解析后的对象
 */
+ (id)parseToObjectWithModelName:(NSString *)modelName key:(NSString *)key response:(YXHttpResponse *)response;

/**
 返回数组的数据统一解析,如
 data:{
 key: value;
 key1:[];
 key2:{};
 }
 @param modelName 解析后数组元素中的实体类名称（如果modelName为nil，则默认不做model对象化处理）
 @param key 所要解析json数据的key（如果key传nil，则默认取key=data对应的value值）
 @param response response对象
 @return 解析后的数组
 */
+ (NSArray *)parseToArrayWithModelName:(NSString *)modelName key:(NSString *)key response:(YXHttpResponse *)response;

/**
 用户增删改的数据统一解析
 @param response response对象
 */
+ (void)handleUpdateResponse:(YXHttpResponse *)response;

@end

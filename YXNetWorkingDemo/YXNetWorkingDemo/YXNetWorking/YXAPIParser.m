//
//  YXAPIParser.m
//  Wujie
//
//  Created by maoyuxiang on 2017/3/21.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#import "YXAPIParser.h"
#import "MJExtension.h"

@interface YXAPIParser()

@end

@implementation YXAPIParser

+ (NSString *)parseToStringWithKey:(NSString *)key response:(YXHttpResponse *)response{
    if (response.code == ErrorCodeTypeSuccess) {
        //成功
        if (!key) {
            //如果key为nil，则返回根data的value
            NSString * string = response.data;
            if (string) {
                return string;
            }
            return @"";
        }
        else{
            //判断是否是有效的key
            BOOL isValidKey = [[response.data allKeys] containsObject:key];
            if (!isValidKey) {
                return @"";
            }
            NSString * string = response.data[key];
            if (string) {
                return string;
            }
            return @"";
        }
    }
    else{
        //失败
        return @"";
    }
}

#pragma mark - 返回Model的数据统一解析

+ (id)parseToObjectWithModelName:(NSString *)modelName key:(NSString *)key response:(YXHttpResponse *)response{
    
    if (!modelName) {
        if (response.code == ErrorCodeTypeSuccess) {
            //成功
            //modelName为nil，返回字典
            if (!key) {
                //如果modelName和key都为nil，则返回根data的value
                NSDictionary * dict = response.data;
                if (dict && [self isDictinary:dict]) {
                    return dict;
                }
                else{
                    return [NSDictionary dictionary];
                }
            }
            else{
                //判断是否是有效的key
                BOOL isValidKey = [[response.data allKeys] containsObject:key];
                if (!isValidKey) {
                    return [NSDictionary dictionary];
                }
                
                //如果modelName为nil,key有值，则返回对应key的value
                NSDictionary * dict = response.data[key];
                if (dict && [self isDictinary:dict]) {
                    return dict;
                }
                else{
                    return [NSDictionary dictionary];
                }
            }
        }
        else{
            //失败
             return [NSDictionary dictionary];
        }
    }
    else{
        //返回对象
        Class Model = NSClassFromString(modelName);
        
        if (response.code == ErrorCodeTypeSuccess) {
            //成功
            if (!key) {
                //如果key为nil，则返回根data的value
                NSDictionary * dict = response.data;
                if (dict && [self isDictinary:dict]) {
                    return [Model mj_objectWithKeyValues:dict];
                }
                else{
                    return [[Model alloc]init];
                }
            }
            else{
                //判断是否是有效的key
                BOOL isValidKey = [[response.data allKeys] containsObject:key];
                if (!isValidKey) {
                    return [[Model alloc] init];
                }
                
                //如果key有值，则返回对应key的value
                NSDictionary * dict = response.data[key];
                if (dict && [self isDictinary:dict]) {
                    return [Model mj_objectWithKeyValues:dict];;
                }
                else{
                    return [[Model alloc]init];
                }
            }
        }
        else{
            //失败
            return [[Model alloc]init];
        }
    }
}

#pragma mark - 返回数组的数据统一解析
+ (NSArray *)parseToArrayWithModelName:(NSString *)modelName key:(NSString *)key response:(YXHttpResponse *)response{
    
    if (!modelName) {
        if (response.code == ErrorCodeTypeSuccess) {
            //成功
            //modelName为nil，返回数组字典
            if (!key) {
                //如果modelName和key都为nil，则返回根data的value
                NSArray * array = response.data;
                if (array && [self isArray:array]) {
                    return array;
                }
                else{
                    return [NSArray array];
                }
            }
            else{
                //判断是否是有效的key
                BOOL isValidKey = [[response.data allKeys] containsObject:key];
                if (!isValidKey) {
                    return [NSArray array];
                }
                
                //如果modelName为nil,key有值，则返回对应key的value
                NSArray * array = response.data[key];
                if (array && [self isArray:array]) {
                    return array;
                }
                else{
                    return [NSArray array];
                }
            }
        }
        else{
            //失败
            return [NSArray array];
        }
    }
    else{
        //返回对象数组
        Class Model = NSClassFromString(modelName);
        
        if (response.code == ErrorCodeTypeSuccess) {
            //成功
            if (!key) {
                //如果key为nil，则返回根data的value
                NSArray * array = response.data;
                if (array && [self isArray:array]) {
                    NSArray * models = [Model mj_objectArrayWithKeyValuesArray:array];
                    return models;
                }
                else{
                    return [NSArray array];
                }
            }
            else{
                //判断是否是有效的key
                BOOL isValidKey = [[response.data allKeys] containsObject:key];
                if (!isValidKey) {
                    return [NSArray array];
                }
                //如果key有值，则返回对应key的value
                NSArray * array = response.data[key];
                if (array && [self isArray:array]) {
                    NSArray * models = [Model mj_objectArrayWithKeyValuesArray:array];
                    return models;
                }
                else{
                    return [NSArray array];
                }
            }
        }
        else{
            //失败
            return [NSArray array];
        }
    }
}

#pragma mark 用户增删改的数据统一解析
+ (void)handleUpdateResponse:(YXHttpResponse *)response
{
    if (response.code == ErrorCodeTypeSuccess) {
        //更新成功
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_USERINFO_UPDATE_SUCCESS object:self userInfo:@{ResponseKey:response}];
    }
    else{
        //更新失败
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_USERINFO_UPDATE_FAILED object:self userInfo:@{ResponseKey:response}];
    }
}

#pragma mark - 判断是否是某种类型
+ (BOOL)isDictinary:(NSDictionary *)dict
{
    return [dict isKindOfClass:[NSDictionary class]];
}

+ (BOOL)isArray:(NSArray *)array
{
    return [array isKindOfClass:[NSArray class]];
}


@end

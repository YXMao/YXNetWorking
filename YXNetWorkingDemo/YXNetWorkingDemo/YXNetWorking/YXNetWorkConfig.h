//
//  YXNetWorkConfig.h
//  Wujie
//
//  Created by maoyuxiang on 2017/3/21.
//  Copyright © 2017年 吴红珍. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SINGLE_INSTANCE_DECLARE(_ClassName_)  +(_ClassName_ *)shareInstance;
#define SINGLE_INSTANCE_IMPLEMENTION(_ClassName_)  static _ClassName_ * g_singleInstance = nil;\
+ (_ClassName_*)shareInstance\
{\
@synchronized(g_singleInstance)\
{\
if (nil == g_singleInstance)\
{\
g_singleInstance = [[_ClassName_ alloc] init];\
}\
return g_singleInstance;\
}\
}


/**
  此类负责相关网络基础参数的配置
 */
@interface YXNetWorkConfig : NSObject

SINGLE_INSTANCE_DECLARE(YXNetWorkConfig)

@property(copy, nonatomic) NSString *baseUrl;

@property(copy, nonatomic) NSString *baseHtmlUrl;


@end

//
//  WJPoPAdAPI.h
//  Wujie
//
//  Created by maoyuxiang on 2017/3/22.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#import "YXBaseAPI.h"

#define NET_POP_ADS_TAG             @"NET_POP_ADS_TAG"//首页弹窗广告

@interface YXPopAdAPI : YXBaseAPI

- (YXHttpRequest *)requestPopAd;


@end

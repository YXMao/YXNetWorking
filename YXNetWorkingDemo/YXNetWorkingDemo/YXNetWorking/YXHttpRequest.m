//
//  WJRequest.m
//  Wujie
//
//  Created by maoyuxiang on 2017/3/20.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#import "YXHttpRequest.h"

@implementation YXHttpRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.url = nil;
        self.param = nil;
        self.identity = nil;
        self.requestMethod = HttpRequestMethodPost;
    }
    return self;
}

//- (NSString *)description{
//    return [NSString stringWithFormat:@"%@:%p,url:%@,param:%@,identity:%@,method:%d",[self class],self,_url,_param,_identity,_requestMethod];
//}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@:%p,url:%@,identity:%@",[self class],self,_url,_identity];
}


@end

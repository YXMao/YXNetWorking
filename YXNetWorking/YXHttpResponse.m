//
//  WJHttpResponse.m
//  Wujie
//
//  Created by maoyuxiang on 2017/3/20.
//  Copyright © 2017年 maoyuxiang. All rights reserved.
//

#import "YXHttpResponse.h"

@implementation YXHttpResponse

- (instancetype)initWithRequest:(YXHttpRequest *)request dictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        self.code = (ErrorCodeType)[dictionary[codenumber] integerValue];
        self.message = dictionary[msg];
        self.data = dictionary[datas];
        self.systemError = nil;
        self.userInfo = nil;
        self.request = request;
        self.parseResult = nil;
        
    }
    return self;
}

@end

**YXNetWorking** 
==========

## YXNetWorking  是什么

**YXNetWorking**  是基于 [AFNetworking][AFNetworking] 封装的 iOS 网络库，其实现了一套简易的网络框架，容易集成，适合用在中小型项目中使用。

## YXNetWorking 的基本思想
**YXNetWorking** 的基本的思想是把每一个网络请求封装成对象YXHttpRequest,把每一个网络请求回来的数据也封装成对象YXHttpResponse,把每一类型的API对应放在XXXAPI类里面统一管理，使用YXAPIParser统一做服务器返回json的解析，并在XXXAPI类里做具体网络请求的再次数据解析。

## YXNetWorking 的使用
### 1.使用YXNetWorkingConfig统一配置网络请求的地址
```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //统一配置网络请求的地址
    [YXNetWorkConfig shareInstance].baseUrl = @"http://api.www.xxx";
    
    return YES;
}

```

### 2.创建对应的API类，如YXPopAdAPI
```objc
#define NET_POP_ADS_TAG             @"NET_POP_ADS_TAG"//首页弹窗广告

@interface YXPopAdAPI : YXBaseAPI

- (YXHttpRequest *)requestPopAd;

@end

```

```objc
@implementation YXPopAdAPI

#pragma mark - 请求接口
- (YXHttpRequest *)requestPopAd{
    NSString *url = [NSString stringWithFormat:@"%@app=popads&act=getPopAds", [YXNetWorkConfig shareInstance].baseUrl];
    YXHttpRequest * request = [[YXHttpRequest alloc]init];
    request.url = url;
    request.identity = NET_POP_ADS_TAG;
    [self sendRequest:request];
    return request;
}

#pragma mark - 分解网络请求
- (void)parseWithResponse:(YXHttpResponse *)response{
    [super parseWithResponse:response];
    if ([response.request.identity isEqualToString:NET_POP_ADS_TAG]) {
        //弹窗广告的返回数据解析
        [self parsePopAdsWithResponse:response];
    }
}

#pragma mark - 解析网络返回数据
- (void)parsePopAdsWithResponse:(YXHttpResponse *)response{
    NSString * string = [YXAPIParser parseToStringWithKey:nil response:response];
    response.parseResult = string;
    [self invokeRequestFinishedDelegateWithResponse:response];
}

```

### 3.在对应的ViewController中初始化并使用（注：XXXAPI必须为属性）
```objc
@property(strong, nonatomic) YXPopAdAPI * api;

```
```objc
//初始化API，并设置YXHttpDelegate代理
self.api = [[YXPopAdAPI alloc]init];
self.api.delegate = self;
    
[MBProgressHUD showMessage:@"开始加载..." toView:self.view];
[self.api requestPopAd];  
```

```objc
#pragma mark - YXHttpDelegate
- (void)requestFinishedWithResponse:(YXHttpResponse *)response{
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD showSuccess:@"请求成功"];
    NSLog(@"%@,result:%@",response.request.identity,response.parseResult);
}

- (void)requestFailedWithResponse:(YXHttpResponse *)response{
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD showError:@"请求失败"];
    NSLog(@"请求失败：%@ 原因：%@",response.request.identity,[response.systemError localizedDescription]);
} 
```

## 安装

你可以在 Podfile 中加入下面一行代码来使用 YXNetWorking 

```objc
pod 'YXNetWorking'
```
    

**YXNetWorking**  依赖于 AFNetworking，可以在 [AFNetworking README](https://github.com/AFNetworking/AFNetworking) 中找到更多关于依赖版本有关的信息。

## 相关的使用教程和 Demo

* 其使用方法可以在 YXNetWorkingDemo 中查看


## 协议

**YXNetWorking**  被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。

<!-- external links -->
[AFNetworking]:https://github.com/AFNetworking/AFNetworking

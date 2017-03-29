//
//  ViewController.m
//  YXNetWorkingDemo
//
//  Created by maoyuxiang on 2017/3/23.
//  Copyright © 2017年 YXMao. All rights reserved.
//

#import "ViewController.h"
#import "YXPopAdAPI.h"
#import "MBProgressHUD+MJ.h"

@interface ViewController ()<YXHttpDelegate>

@property(strong, nonatomic) YXPopAdAPI * api;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.api = [[YXPopAdAPI alloc]init];
    self.api.delegate = self;
    
    [MBProgressHUD showMessage:@"开始加载..." toView:self.view];
    [self.api requestPopAd];
    
}


#pragma mark - YXHttpDelegate

- (void)requestFinishedWithResponse:(YXHttpResponse *)response{
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD showSuccess:@"请求成功"];
    NSLog(@"返回结果:\n******************************************************************************************");
    NSLog(@"%@,result:%@",response.request.identity,response.parseResult);
    NSLog(@"******************************************************************************************\n");
}

- (void)requestFailedWithResponse:(YXHttpResponse *)response{
    [MBProgressHUD hideHUDForView:self.view];
    [MBProgressHUD showError:@"请求失败"];
    NSLog(@"请求失败：%@ 原因：%@",response.request.identity,[response.systemError localizedDescription]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

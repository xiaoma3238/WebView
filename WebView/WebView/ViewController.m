//
//  ViewController.m
//  WebView
//
//  Created by lanou3g on 15/7/25.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "ViewController.h"
#import "DataBaseHandle.h"
#import "DetailNews.h"
@interface ViewController ()
{
    UIWebView *webView;
}

@property(nonatomic,weak)DataBaseHandle *shareInstance;// 把数据库操作对象作为属性

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.shareInstance = [DataBaseHandle shareDataHandle];
    
    // 打开数据库
    [self.shareInstance openDB];
    
    // 创建表
    DetailNews *s = [[DetailNews alloc]init];
//    s.title = @"新浪";
//    s.imageUrl = @"sina.com";
//    s.videoUrl = @"baidu.com";
//    s.date = @"2015-4-20";
//    [[DataBaseHandle shareDataHandle]insertWithDetailNews:s];
//
    
    
// 查询所有信息
  NSArray *arr =[[DataBaseHandle shareDataHandle]selectAll];
    for (DetailNews *d in arr) {
        NSLog(@"title = %@, image = %@, describe = %@, date = %@",d.title,d.imageName,d.describe,d.date);
    }
    
    
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 50, 375, 667)];
    // self.view.backgroundColor = [UIColor redColor];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.view addSubview:webView];
    [webView loadRequest:request];
    
     UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 375, 50)];
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    
    
    UIButton *leftbutton = [UIButton buttonWithType:(UIButtonTypeSystem)];
   leftbutton.frame = CGRectMake(10, 20, 40, 30);
  //leftbutton.backgroundColor = [UIColor blueColor];
   [leftbutton setTitle:@"退出" forState:(UIControlStateNormal)];
    leftbutton.titleLabel.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:16];
//[leftbutton setImage:[UIImage imageNamed:@"3.png"] forState:(UIControlStateNormal)];
    [leftbutton addTarget:self action:@selector(leftButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:leftbutton];
    
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    rightButton.frame = CGRectMake(332, 20, 40, 30);
   // rightButton.backgroundColor = [UIColor blueColor];
    [rightButton setTitle:@"刷新" forState:(UIControlStateNormal)];
    rightButton.titleLabel.font = [UIFont fontWithName:@"Arial-MT" size:16];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:rightButton];
    

}

-(void)leftButtonAction:(UIButton *)sender
{
    if (webView.canGoBack) {
        [webView goBack];
    }
}


-(void)rightButtonAction:(UIButton *)sender
{
    [webView reload];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

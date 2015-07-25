//
//  DetailNews.h
//  WebView
//
//  Created by lanou3g on 15/7/25.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailNews : NSObject
// 标示数字
@property(nonatomic,assign)NSInteger number;

// 标题
@property(nonatomic,copy)NSString *title;

// 图片url
@property(nonatomic,copy)NSString *imageName;

// 视频url
@property(nonatomic,copy)NSString *describe;

// 日期
@property(nonatomic,copy)NSString *date;


@end

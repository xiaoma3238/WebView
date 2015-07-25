//
//  DataBaseHandle.h
//  WebView
//
//  Created by lanou3g on 15/7/25.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailNews.h"
@interface DataBaseHandle : NSObject

+(instancetype)shareDataHandle;


// 打开数据库

-(void)openDB;

// 关闭数据库

-(void)closeDB;

// 建表

-(void)createTable;

// 增加
-(void)insertWithDetailNews:(DetailNews *)aNews;

// 删除
-(void)deleteDetailNews;

// 改动
-(void)update;

// 查


// 1. 全查
-(NSArray *)selectAll;

// 2.条件查
-(NSArray *)selectWithTitle:(NSString *)Title;





@end

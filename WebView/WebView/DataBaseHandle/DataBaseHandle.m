//
//  DataBaseHandle.m
//  WebView
//
//  Created by lanou3g on 15/7/25.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "DataBaseHandle.h"
#import <sqlite3.h>
#import "DetailNews.h"
static DataBaseHandle *dataBase = nil;

@implementation DataBaseHandle

+(instancetype)shareDataHandle
{
    if (dataBase == nil) {
        dataBase = [[DataBaseHandle alloc]init];
    }
    return dataBase;
}


// 声明一个数据库指针
static sqlite3 *db = nil;

// 获取documents路径
-(NSString *)p_documentspath
{
    // 1. 存放数据库路径，在Caches文件夹下面
return NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES)[0];
}

// 打开数据库
-(void)openDB
{
    // 判断
    if (db != nil) {
        NSLog(@"数据库已经打开");
        return;
    }
    
    NSString *cachesPath = [self p_documentspath];
    //NSLog(@"%@",cachesPath);
    NSString *sqliteFilePath = [cachesPath stringByAppendingPathComponent:@"DetailNews.sqllite"];
    NSLog(@"数据库路径:%@",sqliteFilePath);
    
    // 2.打开数据库 创建数据库之后打开
    int result = sqlite3_open([sqliteFilePath UTF8String], &db);
    // 3.判断数据库是否打开成功
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
        //4、创建数据库表所使用的sql语句<如果发现同名的数据库表的话，创建表会失败>
        NSString *sql = @"create table DetailNews(number interger primary key not NULL,title text not NULL, imageName text not NULL,describe text not NULL, date text not NULL)";
        // 5. 执行 SQL 语句
        char *error = nil;
        int sqlResult = sqlite3_exec(db,[sql UTF8String], NULL, NULL, &error);
        // 6.判断sql 语句是否执行正确
        if (sqlResult == SQLITE_OK) {
            NSLog(@"数据库创建DetailNews表成功");
        }else{
            NSLog(@"创建失败 %s",error);
        }
        
    }else{
        NSLog(@"数据库打开失败");
    }
    
}

//#pragma mark -- 关闭数据库
//-(void)closeDB
//{
//    // 1. 执行关闭数据库方法
//    int result = sqlite3_close(db);
//    // 2. 判断是否关闭成功
//    if (result == SQLITE_OK) {
//        // 数据库关闭成功，把db置nil
//        db = nil;
//    }
//}

#pragma mark -- 插入数据
-(void)insertWithDetailNews:(DetailNews *)aNews
{
    // 1. 插入的SQL语句(insert into 表名(字段1，字段2,......) values(值1，值2,......))
    
    NSString *insertSQL = [NSString stringWithFormat:@"insert into DetailNews(number,title,imageName,describe,date) values('%ld','%@','%@','%@','%@')",aNews.number,aNews.title,aNews.imageName,aNews.describe,aNews.date];
    NSLog(@"SQL = %@",insertSQL);
    // 2.执行sql语句
    char *error = nil;
    int result = sqlite3_exec(db, [insertSQL UTF8String], NULL, NULL, &error);
    
    // 3. 判断
    if (result == SQLITE_OK) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败:%s",error);
    }
    
}


#pragma mark ---






















#pragma mark-- 查询数据库表中所有信息
// 1. 查询所有信息的SQL语句
-(NSArray *)selectAll
{
    NSString *selectAll= @"select * from DetailNews";
 // 2.创建跟随指针
    sqlite3_stmt *stmt = NULL;
 // 3.验证SQL 语句
    int result = sqlite3_prepare_v2(db,[selectAll UTF8String], -1, &stmt, NULL);
 // 4.判断是否验证成功
    NSMutableArray *array = [NSMutableArray array];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // 5、获取数据
            char *title_C = (char *)sqlite3_column_text(stmt, 1);
            int number = (int)sqlite3_column_int(stmt, 0);
            char *imageUrl_C = (char *)sqlite3_column_text(stmt, 2);
            char *videoUrl_C = (char *)sqlite3_column_text(stmt, 3);
            char *date_C = (char *)sqlite3_column_text(stmt, 4);
            // 6 把从数据库中取出的数据付给对象的属性
            DetailNews *detail = [[DetailNews alloc]init];
            detail.number = number;
            detail.title = [NSString stringWithUTF8String:title_C];
            detail.imageName = [NSString stringWithUTF8String:imageUrl_C];
            detail.describe = [NSString stringWithUTF8String:videoUrl_C];
            detail.date = [NSString stringWithUTF8String:date_C];
            [array addObject:detail];
        }
    }else{
        NSLog(@"验证失败");
    }
    // 释放所有权
    sqlite3_finalize(stmt);
    
    return array;
}



@end

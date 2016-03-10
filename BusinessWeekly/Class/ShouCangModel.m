//
//  ShouCangModel.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ShouCangModel.h"
#import <sqlite3.h>
#import "Information.h"
@implementation ShouCangModel
//创建一个静态 单利对象 初始值为空
static ShouCangModel  *dbManger =  nil;
+(ShouCangModel *)sharedInstance{
    if (dbManger == nil) {
        dbManger = [[ShouCangModel alloc]init];
    }
    return dbManger;
}
//创建一个静态数据库
static sqlite3 *database = nil;

//创建 1.引入数据库头文件
- (void)createDataBase{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    dataBasePath = [documentPath stringByAppendingPathComponent:@"Zhao.sqlite"];
    //1.dataBasePath数据库文件的路径，UTF8String编码格式
    //2.database数据库对象的地址
    //3.数据库存在打开操作  不存在重新创建
    
    
    
}
//打开数据库
- (void)openDataBase{
    if (database != nil) {
        return;
    }else {
        [self createDataBase];//创建数据库
    }
    
    sqlite3_open([dataBasePath UTF8String], &database);
    NSLog(@"%@",dataBasePath);
    int result = sqlite3_open([dataBasePath UTF8String], &database);
    if (result == SQLITE_OK) {
        NSLog(@"打开数据库成功");
        [self createDataBaseTable];
    }else{
        NSLog(@"打开数据库失败");
    }
}

//创建表
- (void)createDataBaseTable{
    NSString *sql = @"create table zhao(idString integer primary key autoincrement, imageString text not null,nameString text not null,timeString text not null ,contentString text not null)";
    //执行SQL语句 1.database数据库 2.SQL语句UTF8编码格式 3.函数回调 当这条语句执行完 会调用你提供的函数，可以是null 4.是你提供的指针变量 会最终传到你回调函数中去5.是错误信息 是指针类型 接收执行sqlite3错误信息 也可以null
    char *error = nil;
    sqlite3_exec(database, [sql UTF8String], NULL, NULL, &error);
    
}

//关闭
- (void)closeDataBase{
    if (sqlite3_close(database) == SQLITE_OK) {
        NSLog(@"关闭数据库成功");
        database = nil;
    }else{
        NSLog(@"关闭数据库失败");
    }
    
    
}
#pragma mark ---数据库常用操作
//添加
- (BOOL)insertIntoNewLinkMan:(Information *)information{
    //1.打开数据库
    [self openDataBase];
    //sqlite3_stmt SQL语句
    sqlite3_stmt *stmt = nil;
    //正在sql 语句
   
       NSString *sql = [NSString stringWithFormat:@"insert into zhao values ('%@','%@','%@','%@','%@')", information.idString ,information.imageString, information.nameString, information.timeString,information.contentString];
    //验证SQL语句 1.数据库 2.SQL语句 3. 4.指针
    int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"添加SQL语句没有问题成功");
                sqlite3_exec(database, sql.UTF8String, NULL, NULL, NULL);
        //执行
        
       
        return YES;
    }
    
    //删除释放
    sqlite3_finalize(stmt);
    return NO;
}
//id号删除
- (void)deleteLinkManWithPhoneNUmber:(NSString *)idString{
    //1.打开数据库
    [self openDataBase];
    //sqlite3_stmt SQL语句
    sqlite3_stmt *stmt = nil;
    //正真的SQL语句
    static char *sql = "delete from  zhao where idString = ?";
    int flag=sqlite3_prepare_v2(database,sql, -1, &stmt, NULL);//调用预处理函数将sql语句赋值给stmt对象
    
    //执行
    
    if (flag == SQLITE_OK)
    {
        NSLog(@"删除语句没有错误");
        sqlite3_bind_text(stmt, 4, [idString UTF8String] , -1, SQLITE_TRANSIENT);//给问号占位符赋值  1.语句2.占位符的序号3.给占位符赋得值
        if ( sqlite3_step(stmt) == SQLITE_ERROR) {
            NSLog(@"错误");
        }
        
    }else{
        NSLog(@"删除了第%@",idString);
    }
    sqlite3_finalize(stmt);
}
//删
- (BOOL)deleteInforWithId:(NSString *)idString{
    [self openDataBase];
    NSString * sql = [NSString stringWithFormat:@"delete from zhao where idString = '%@'",idString];
    if (sqlite3_exec(database, [sql UTF8String], NULL, NULL, NULL) == SQLITE_OK) {
        NSLog(@"根据发表的id删除成功");
        
        return 1;
    }else{
        NSLog(@"根据id删除失败");
        return 0;
    }

}
//查
- (NSMutableArray *)seleatAllInformation{
[self openDataBase];
NSString *sql = @"select *from zhao";
sqlite3_stmt *stmt = nil;
NSMutableArray *linkMansArray = [NSMutableArray array];
if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
    NSLog(@"查询所有人成功");
    //遍历数据库中每一行数据
    
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        //每一列数据
        const unsigned char *idString      = sqlite3_column_text(stmt, 0);
        const unsigned char *imageString   = sqlite3_column_text(stmt, 1);
        const unsigned char *nameString    = sqlite3_column_text(stmt, 2);
        const unsigned char *timeString    = sqlite3_column_text(stmt, 3);
        const unsigned char *contentString = sqlite3_column_text(stmt, 4);
        //将每一列数据进行转换
        NSString *infoId      = [NSString stringWithUTF8String:(const char *)idString];
        NSString *infoImage   = [NSString stringWithUTF8String:(const char *)imageString];
        NSString *infoName    = [NSString stringWithUTF8String:(const char *)nameString];
        NSString *infoTime    = [NSString stringWithUTF8String:(const char *)timeString];
        NSString *infoContent = [NSString stringWithUTF8String:(const char *)contentString];
        //给对象赋值 ，将对象放到数据里
        Information *info = [[Information alloc]init];
        info.idString      = infoId;
        info.imageString   = infoImage;
        info.nameString    = infoName;
        info.timeString    = infoTime;
        info.contentString = infoContent;
        
        [linkMansArray addObject:info];
        // NSLog(@"%@",linkMansArray);
        
        
    }
    
}else{
    NSLog(@"查询所有人失败");
}

sqlite3_finalize(stmt);
return linkMansArray;
}
@end

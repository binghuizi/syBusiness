//
//  ShouCangModel.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Information.h"
@interface ShouCangModel : NSObject
{
    NSString *dataBasePath;
}
//用单利创建数据管理对象
+(ShouCangModel *)sharedInstance;
#pragma mark 数据库基本操作
- (void)createDataBase; //创建
- (void)openDataBase;  //打开
- (void)createDataBaseTable;//表
- (void)closeDataBase;//关闭

#pragma mark -----增 删 改c

- (BOOL)insertIntoNewLinkMan:(Information *)information;//增
- (void)deleteLinkManWithPhoneNUmber:(NSString *)idString;//删除 根据编号
- (BOOL)deleteInforWithId:(NSString *)idString;
- (NSMutableArray *)seleatAllInformation;// 查
@end

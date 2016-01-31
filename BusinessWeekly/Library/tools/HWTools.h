//
//  HWTools.h
//  BusinessWeekly
//
//  Created by scjy on 16/1/29.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWTools : NSObject
+(NSString *)getDateFromString:(NSString *)timestamp;
//获取当前系统时间
+ (NSDate *)getSystemNowDate;

#pragma mark --- 根据文字  最大显示 返回高度
+(CGFloat )getTextHeightWithText:(NSString *)text    Bigsize:(CGSize)bigSize textFont:(CGFloat)font;
@end

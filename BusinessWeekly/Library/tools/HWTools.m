//
//  HWTools.m
//  BusinessWeekly
//
//  Created by scjy on 16/1/29.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "HWTools.h"

@implementation HWTools
#pragma mark ---时间转化相关的方法

+(NSString *)getDateFromString:(NSString *)timestamp{
    NSTimeInterval timeInterval = [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter *formater1 = [[NSDateFormatter alloc]init];
    
    [formater1 setDateFormat:@"yyyy.MM.dd"];
    
    NSString *showTime = [formater1 stringFromDate:date];
    
    return showTime;
    
}

+ (NSDate *)getSystemNowDate{
    //创建一个NSDataFormatter显示刷新时间
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [df stringFromDate:[NSDate date]];
    NSDate *date = [df dateFromString:dateStr];
    return date;
}


+(CGFloat )getTextHeightWithText:(NSString *)text   Bigsize:(CGSize)bigSize textFont:(CGFloat)font{
    
    CGRect textRect = [text boundingRectWithSize:bigSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return textRect.size.height;
}


+(NSMutableArray *)arrayWithString:(NSString *)colorString{
    
    NSMutableArray *numberArray = [NSMutableArray new];
    
    NSString *string = colorString;
    NSArray  *array = [string componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
    for (int i = 0; i < array.count; i++) {
        NSString *originalString = array[i];
        // Intermediate
        NSMutableString *numberString = [[NSMutableString alloc] init] ;
        NSString *tempStr;
        NSScanner *scanner = [NSScanner scannerWithString:originalString];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        while (![scanner isAtEnd]) {
            // Throw away characters before the first number.
            [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
            // Collect numbers.
            [scanner scanCharactersFromSet:numbers intoString:&tempStr];
            [numberString appendString:tempStr];
            tempStr = @"";
            
        }
        [numberArray addObject:numberString];
        
}
    return numberArray;
}



@end


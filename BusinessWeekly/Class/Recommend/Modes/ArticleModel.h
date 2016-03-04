//
//  ArticleModel.h
//  BusinessWeekly
//
//  Created by scjy on 16/1/29.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject
@property(nonatomic,strong) NSString *advUpdateTime;
@property(nonatomic,strong) NSString *catname;
@property(nonatomic,strong) NSString *color;
@property(nonatomic,strong) NSString *tagname;
- (instancetype) initWithDictionary:(NSDictionary *)dict;
@end

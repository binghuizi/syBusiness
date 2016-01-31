//
//  ArticleModel.m
//  BusinessWeekly
//
//  Created by scjy on 16/1/29.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.advUpdateTime = dict[@"advUpdateTime"];
        self.catname = dict[@"catname"];
        self.color = dict[@"phoneColumnProperty"][@"color"];
    }
    return self;
}
@end

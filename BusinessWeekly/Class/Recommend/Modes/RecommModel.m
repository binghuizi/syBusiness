//
//  RecommModel.m
//  BusinessWeekly
//
//  Created by scjy on 16/1/30.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "RecommModel.h"

@implementation RecommModel
- (instancetype) initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.title = dict[@"title"];
        self.desc = dict[@"desc"];
        self.groupdisplayname = dict[@"groupdisplayname"];
    }
    return self;
}
@end

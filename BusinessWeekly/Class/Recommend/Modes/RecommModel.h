//
//  RecommModel.h
//  BusinessWeekly
//
//  Created by scjy on 16/1/30.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommModel : NSObject
@property(nonatomic,strong) NSString *groupdisplayname;
@property(nonatomic,strong) NSString *url;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *desc;
- (instancetype) initWithDictionary:(NSDictionary *)dict;
@end

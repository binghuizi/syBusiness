//
//  Information.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "Information.h"

@implementation Information
-(id)initWithImage:(NSString *)image name:(NSString *)name time:(NSString *)time content:(NSString *)content idString:(NSString *)idString{
    self = [super init];
    if (self) {
        _imageString = image;
        _nameString = name;
        _timeString = time;
        _contentString = content;
        _idString      = idString;
        
    }
    return self;
}

+(instancetype)informationWithImage:(NSString *)image name:(NSString *)name time:(NSString *)time content:(NSString *)content  idString:(NSString *)idString{
    Information *infor = [[Information alloc]initWithImage:image name:name time:time content:content idString:idString];
    return infor;
}

@end

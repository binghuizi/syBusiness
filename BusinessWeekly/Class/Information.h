//
//  Information.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Information : NSObject
@property(nonatomic,strong) NSString *imageString;
@property(nonatomic,strong) NSString *nameString;
@property(nonatomic,strong) NSString *timeString;
@property(nonatomic,strong) NSString *contentString;
@property(nonatomic,strong) NSString *idString;
+(instancetype)informationWithImage:(NSString *)image
                                name:(NSString *)name
                                time:(NSString *)time
                             content:(NSString *)content
                            idString:(NSString *)idString;



-(id)initWithImage:(NSString *)image
              name:(NSString *)name
              time:(NSString *)time
           content:(NSString *)content
          idString:(NSString *)idString;

@end

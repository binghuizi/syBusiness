//
//  AppDelegate.h
//  BusinessWeekly
//
//  Created by scjy on 16/1/26.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *wbtoken;
@property(nonatomic,copy) NSString *userName;
@property(nonatomic,assign) BOOL isLogin;
@property(nonatomic,assign) BOOL switchIsOn;

@end


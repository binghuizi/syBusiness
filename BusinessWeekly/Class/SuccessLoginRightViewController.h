//
//  SuccessLoginRightViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 scjy. All rights reserved.
//
@protocol successLoginRightViewControllerDelagate <NSObject>

-(void)pushView;
-(void)pushDiscoverView;
@end
#import <UIKit/UIKit.h>

@interface SuccessLoginRightViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property(nonatomic,assign) id<successLoginRightViewControllerDelagate>succLoginRightDelagate;

@end

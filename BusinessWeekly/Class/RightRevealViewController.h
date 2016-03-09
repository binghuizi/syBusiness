//
//  RightRevealViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 scjy. All rights reserved.
//
@protocol RightRevealViewControlDelegate <NSObject>

-(void)popViewController;
-(void)pushDiscoverController;
@end
#import <UIKit/UIKit.h>

@interface RightRevealViewController : UIViewController
@property(nonatomic,assign) id<RightRevealViewControlDelegate> rightDelegate;
- (IBAction)loginViewButton:(id)sender;

@end

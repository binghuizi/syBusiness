//
//  RecommendViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/1/29.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendViewController : UIViewController
@property(nonatomic,strong) NSString *catString;
@property(nonatomic,strong) NSString *catName;

@property(nonatomic,retain) UIView *mainView;
@property(nonatomic,retain) UIView *leftView;
@property(nonatomic,retain) UIView *rightView;
@property(nonatomic,retain) UIView *contentView;

@end

//
//  LeftRevealViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 scjy. All rights reserved.
//
@protocol LeftRevealViewControllerDelegate <NSObject>

-(void)leftData:(NSString *)tageName cateName:(NSString *)catename number:(NSInteger)num;

@end
#import <UIKit/UIKit.h>
@interface LeftRevealViewController : UIViewController
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *leftColorArray;
@property(nonatomic,strong) NSArray *tageNameArray;
@property(nonatomic,assign) id<LeftRevealViewControllerDelegate>leftDelegate;

@end

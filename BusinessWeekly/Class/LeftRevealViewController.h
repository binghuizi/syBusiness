//
//  LeftRevealViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftRevealViewController : UIViewController
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *leftColorArray;
@end

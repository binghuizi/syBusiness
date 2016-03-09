//
//  DiscoverTableViewCell.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverModel.h"
#import "DiscUserModel.h"
@interface DiscoverTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentlabel;
@property(nonatomic,retain) DiscoverModel *discoverModel;
@property(nonatomic,retain) DiscUserModel *userModel;
@end

//
//  FeatureAndTVTableViewCell.h
//  BusinessWeekly
//
//  Created by scjy on 16/2/14.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommModel.h"
@interface FeatureAndTVTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property(nonatomic,strong) RecommModel *model;


@end

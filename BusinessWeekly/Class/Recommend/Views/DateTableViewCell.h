//
//  DateTableViewCell.h
//  BusinessWeekly
//
//  Created by scjy on 16/1/31.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommModel.h"
@interface DateTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *groupdisplaynameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewUrl;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property(nonatomic,strong) RecommModel *recomModel;




@end

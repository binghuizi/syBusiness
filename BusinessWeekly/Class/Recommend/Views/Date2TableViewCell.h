//
//  Date2TableViewCell.h
//  BusinessWeekly
//
//  Created by scjy on 16/2/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommModel.h"
@interface Date2TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@property(nonatomic,strong) RecommModel *recomModel;



@end

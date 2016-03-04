//
//  DingYueTableViewCell.h
//  BusinessWeekly
//
//  Created by scjy on 16/2/23.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommModel.h"
@interface DingYueTableViewCell : UITableViewCell
@property(nonatomic,retain) RecommModel *recomModel;
@property (weak, nonatomic) IBOutlet UIImageView *viewImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

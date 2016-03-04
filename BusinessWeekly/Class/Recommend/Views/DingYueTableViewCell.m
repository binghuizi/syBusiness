//
//  DingYueTableViewCell.m
//  BusinessWeekly
//
//  Created by scjy on 16/2/23.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DingYueTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation DingYueTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setRecomModel:(RecommModel *)recomModel{
    [self.viewImage sd_setImageWithURL:[NSURL URLWithString:recomModel.url] placeholderImage:nil];
    self.titleLabel.text = recomModel.title;
    self.detailLabel.text = recomModel.desc;
}
@end

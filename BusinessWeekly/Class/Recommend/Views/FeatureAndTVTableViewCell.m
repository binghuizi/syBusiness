//
//  FeatureAndTVTableViewCell.m
//  BusinessWeekly
//
//  Created by scjy on 16/2/14.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "FeatureAndTVTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation FeatureAndTVTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(RecommModel *)model{
    [self.imageViewLabel sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl] placeholderImage:nil];
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
    
}
@end

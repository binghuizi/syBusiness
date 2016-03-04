//
//  Date2TableViewCell.m
//  BusinessWeekly
//
//  Created by scjy on 16/2/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "Date2TableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation Date2TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setRecomModel:(RecommModel *)recomModel{
   
   
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:recomModel.url] placeholderImage:nil];
    self.titleLabel.text = recomModel.title;
    self.descLabel.text = recomModel.desc;
    
}
@end

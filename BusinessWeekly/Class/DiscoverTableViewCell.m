//
//  DiscoverTableViewCell.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DiscoverTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation DiscoverTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDiscoverModel:(DiscoverModel *)discoverModel{
    self.contentlabel.text = discoverModel.contents;
    self.timeLabel.text = [HWTools getHourFromString:discoverModel.time];
    
}
-(void)setUserModel:(DiscUserModel *)userModel{
    self.userNameLabel.text = userModel.nickname;
    
    //圆角设置
    
//    imageView.layer.cornerRadius
//    = 8;(值越大，角就越圆)
    
    self.headImageView.layer.masksToBounds
    = YES;
    self.headImageView.layer.cornerRadius = 15;
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userModel.avatar] placeholderImage:nil];
}


@end

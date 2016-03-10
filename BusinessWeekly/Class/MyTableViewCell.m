//
//  MyTableViewCell.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MyTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setInfo:(Information *)info{
    self.headImageView.layer.cornerRadius = 15;
    self.headImageView.layer.masksToBounds = YES;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:info.imageString] placeholderImage:nil];
    self.nameLabel.text = info.nameString;
    self.timeLabel.text = [HWTools getHourFromString:info.timeString];
    self.contentLabel.text = info.contentString;
    self.timeId = info.idString;
}
@end

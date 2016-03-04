//
//  DateTableViewCell.m
//  BusinessWeekly
//
//  Created by scjy on 16/1/31.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DateTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation DateTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setRecomModel:(RecommModel *)recomModel{
    
    
    [self.imageViewUrl sd_setImageWithURL:[NSURL URLWithString:recomModel.url] placeholderImage:nil];
    self.titleLabel.text = recomModel.title;
    
    self.descLabel.text = recomModel.desc;
    self.groupdisplaynameLabel.text = [NSString stringWithFormat:@"| %@ |",recomModel.groupdisplayname];
    NSArray *array = [HWTools arrayWithString:recomModel.groupdisplaycolor];
    
    CGFloat number1 = [array[0] floatValue];
    CGFloat number2 = [array[1] floatValue];
    CGFloat number3 = [array[2] floatValue];
    self.groupdisplaynameLabel.textColor = [UIColor colorWithRed:number1/255.0f green:number2/255.0f blue:number3/255.0f alpha:1.0];
    
    
}
@end

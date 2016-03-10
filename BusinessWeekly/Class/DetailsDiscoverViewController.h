//
//  DetailsDiscoverViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscoverModel.h"

@interface DetailsDiscoverViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property(nonatomic,retain) DiscoverModel *discoverModel;

@property(nonatomic,strong) NSString *imageString;
@property(nonatomic,strong) NSString *nameString;
@property(nonatomic,strong) NSString *timeString;
@property(nonatomic,strong) NSString *contentString;
@property(nonatomic,strong) NSString *idString;
@end

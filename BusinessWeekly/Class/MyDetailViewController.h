//
//  MyDetailViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Information.h"
@interface MyDetailViewController : UIViewController
@property(nonatomic,strong) NSString *imageString;
@property(nonatomic,strong) NSString *nameString;
@property(nonatomic,strong) NSString *timeString;
@property(nonatomic,strong) NSString *contentString;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *timLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property(nonatomic,strong) NSString *idString;
@property(nonatomic,retain) Information *info;
@end

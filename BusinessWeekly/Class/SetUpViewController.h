//
//  SetUpViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
- (IBAction)switchAction:(id)sender;

@end
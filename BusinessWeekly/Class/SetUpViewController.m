//
//  SetUpViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "SetUpViewController.h"
#import <SDImageCache.h>
#import <MessageUI/MessageUI.h>
#import <SDWebImage/SDImageCache.h>
@interface SetUpViewController ()<MFMailComposeViewControllerDelegate>
- (IBAction)huancunBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *huancunButton;
- (IBAction)userFanKui:(id)sender;

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    SDImageCache *cash = [SDImageCache sharedImageCache];
    NSInteger cashSize = [cash getSize];
     NSString *cashStr = [NSString stringWithFormat:@"缓存大小(%.02fM))",(float)cashSize/1024/1024];
    [self.huancunButton setTitle:cashStr forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






//清除缓存
- (IBAction)huancunBtn:(id)sender {

    SDImageCache *cleanCache=[SDImageCache sharedImageCache];
    //删除所有的缓存图片
    [cleanCache clearDisk];

    [self.huancunButton setTitle:@"清除缓存" forState:UIControlStateNormal];
    
}

- (IBAction)userFanKui:(id)sender {

    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
    picker.mailComposeDelegate = self;
    //设置主题
    [picker setSubject:@"用户反馈"];
    //设置收件人
    NSArray *toRecipients = [NSArray arrayWithObjects:@"1146623752@qq.com",
                             nil];
    
    [picker setToRecipients:toRecipients];
    
    
    // 设置邮件发送内容
    NSString *emailBody = @"请留下你宝贵的意见";
    [picker setMessageBody:emailBody isHTML:NO];
    
    //邮件发送的模态窗口
    // [self presentModalViewController:picker animated:YES];
    
    [self presentViewController:picker animated:YES completion:nil];



}
@end

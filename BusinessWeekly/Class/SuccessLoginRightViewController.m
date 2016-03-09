//
//  SuccessLoginRightViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "SuccessLoginRightViewController.h"
#import "SuccessRegisterViewController.h"

@interface SuccessLoginRightViewController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
- (IBAction)userButtonAction:(id)sender;
- (IBAction)loginDiscoverBtn:(id)sender;

@property(nonatomic, retain) NSString *path;
@property(nonatomic, retain) NSData *data;
@end

@implementation SuccessLoginRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.userNameLabel.text = myAppDelegate.userName;
    self.headImageView.layer.cornerRadius = 40;
    self.headImageView.clipsToBounds = YES;
    
}
#pragma mark ----将要显示的
-(void)viewWillAppear:(BOOL)animated{
    AppDelegate *myAppDelagete =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.userNameLabel.text = myAppDelagete.userName;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)string:(NSString *)path{
//    
//}
//-(void)data:(NSData *)data{
//    self.path=[NSString stringWithFormat:@"%@,%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],@"ol" ];
//    
//    [data writeToFile:self.path atomically:YES];
//    UIImage *readimage = [UIImage imageWithContentsOfFile:self.path];
//    self.headImageView.image = readimage;
//    
//    
//    
//}
- (IBAction)userButtonAction:(id)sender {
//    SuccessRegisterViewController *succReg = [[SuccessRegisterViewController alloc]init];
//    [self presentViewController:succReg animated:YES completion:nil];
    
    [self.succLoginRightDelagate pushView];
    
}

- (IBAction)loginDiscoverBtn:(id)sender {
    
    [self.succLoginRightDelagate pushDiscoverView];
}
@end

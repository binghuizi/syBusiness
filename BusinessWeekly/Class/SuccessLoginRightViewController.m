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
- (IBAction)setUpBtn:(id)sender;
@property(nonatomic, retain) NSData *data;
- (IBAction)myBtn:(id)sender;
- (IBAction)shouCangBtn:(id)sender;

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

//点击头像
- (IBAction)userButtonAction:(id)sender {

    
    [self.succLoginRightDelagate pushView];
    
}
//点击浏览发现
- (IBAction)loginDiscoverBtn:(id)sender {
    
    [self.succLoginRightDelagate pushDiscoverView];
}
//点击设置
- (IBAction)setUpBtn:(id)sender {
    [self.succLoginRightDelagate pushSetUpView];
}
//点击我的首页
- (IBAction)myBtn:(id)sender {
    [self.succLoginRightDelagate pushMyView];


}
//点击我的收藏
- (IBAction)shouCangBtn:(id)sender {
    [self.succLoginRightDelagate pushMyView];
}
@end

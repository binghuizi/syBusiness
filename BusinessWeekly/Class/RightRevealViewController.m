//
//  RightRevealViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "RightRevealViewController.h"
#import "LoginViewController.h"

#import "DiscoverLookViewController.h"
@interface RightRevealViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)headPhonBtnAction:(id)sender;
- (IBAction)DiscoverBtnAction:(id)sender;
- (IBAction)bookAndFisetBtn:(id)sender;
- (IBAction)myCollertBtn:(id)sender;

@end

@implementation RightRevealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (myDelegate.isLogin) {
        self.loginBtn.hidden = YES;
        self.userNameLabel.text = myDelegate.userName;
        self.imageView.image = [UIImage imageNamed:@"meimei.jpg"];
        self.imageView.layer.cornerRadius = 20;
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginViewButton:(id)sender {
    
    [self.rightDelegate popViewController];
}
- (IBAction)headPhonBtnAction:(id)sender {
    
    
    [self.rightDelegate popViewController];
    
    
    
}
#pragma mark -- 浏览发现
//点击浏览发现触发事件
- (IBAction)DiscoverBtnAction:(id)sender {
    NSLog(@"vddfd");
   // DiscoverViewController *discoverVc = [[DiscoverViewController alloc]initWithNibName:@"DiscoverViewController" bundle:nil];
    
//    DiscoverViewController *discoverVc = [[DiscoverViewController alloc]init];
//   // [self.navigationController pushViewController:discoverVc animated:YES];
//    [self presentViewController:discoverVc animated:YES completion:nil];
    [self.rightDelegate pushDiscoverController];
    
    
    
    
}
//点击商业笔记和我的首页进入登陆页面
- (IBAction)bookAndFisetBtn:(id)sender {
    
    [self.rightDelegate popViewController];
}
//点击我的收藏
- (IBAction)myCollertBtn:(id)sender {
  [self.rightDelegate popViewController];
}
@end

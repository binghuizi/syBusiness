//
//  RightRevealViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "RightRevealViewController.h"
#import "LoginViewController.h"
@interface RightRevealViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)headPhonBtnAction:(id)sender;

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
@end

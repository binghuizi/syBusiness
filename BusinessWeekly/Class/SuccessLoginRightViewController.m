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

@end

@implementation SuccessLoginRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.userNameLabel.text = myAppDelegate.userName;
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)userButtonAction:(id)sender {
//    SuccessRegisterViewController *succReg = [[SuccessRegisterViewController alloc]init];
//    [self presentViewController:succReg animated:YES completion:nil];
    
    [self.succLoginRightDelagate pushView];
    
}
@end

//
//  LoginViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "LoginViewController.h"
#import <BmobSDK/BmobObject.h>
#import <BmobSDK/BmobUser.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
//取消按钮
- (IBAction)cancelButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//注册按钮
- (IBAction)regsiterButton:(id)sender {
    if (![self cheakOut]) {
        return;
    }
    BmobUser *bUser = [[BmobUser alloc]init];
    [bUser setUsername:self.numberTextFiewld.text];
    [bUser setPassword:self.passwordTextField.text];
    [bUser signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"注册成功");
        }else{
            NSLog(@"%@",error);
        }
    }];
    
    
}
//登录按钮
- (IBAction)loginButton:(id)sender {
    
    
}
-(void) cheakOut{
    
    if (self.numberTextFiewld.text.length <= 0) {
        <#statements#>
    }
    
    
    
    
    
    
    
}
@end

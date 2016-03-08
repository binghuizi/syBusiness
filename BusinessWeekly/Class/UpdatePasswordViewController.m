//
//  UpdatePasswordViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "UpdatePasswordViewController.h"
#import <BmobSDK/BmobUser.h>
#import "LoginViewController.h"
@interface UpdatePasswordViewController ()<UITextFieldDelegate>
- (IBAction)cancelUpdatebtn:(id)sender;
- (IBAction)finishBtnActtion:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
- (IBAction)touchOnSwitchBtn:(id)sender;

@end

@implementation UpdatePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置键盘return样式  
    self.oldPasswordTextField.returnKeyType = UIReturnKeyNext;
    //两个textField进行加密
    self.oldPasswordTextField.secureTextEntry = YES;
    self.passNewTextField.secureTextEntry = YES;
    //switchButton 是否打开
    self.switchButton.on = NO;//不打开
    
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

- (IBAction)cancelUpdatebtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finishBtnActtion:(id)sender {
    
    BmobUser *user = [BmobUser getCurrentUser];
    [user updateCurrentUserPasswordWithOldPassword:self.oldPasswordTextField.text newPassword:self.passNewTextField.text block:^(BOOL isSuccessful, NSError *error) {
        
        if (isSuccessful) {
            LoginViewController *loginVc = [[LoginViewController alloc]init];
            
            [self presentViewController:loginVc animated:YES completion:nil];
            
        }else{
            NSLog(@"改变密码有错误：%@",error);
        }
        
    }];
    
    
    
}


//textField代理方法 待机return
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.oldPasswordTextField) {
        [self.passNewTextField becomeFirstResponder];//按return键 自动下一行成为焦点
        
    }else{
        [textField resignFirstResponder];
    }
    
    return YES;
}
//点击switchButton 打开
- (IBAction)touchOnSwitchBtn:(id)sender {
    if (self.switchButton.on == NO) {
        self.oldPasswordTextField.secureTextEntry = YES;
        self.passNewTextField.secureTextEntry = YES;
    }else{
        self.oldPasswordTextField.secureTextEntry = NO;
        self.passNewTextField.secureTextEntry = NO;
    }
}
@end
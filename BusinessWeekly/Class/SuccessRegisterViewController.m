//
//  SuccessRegisterViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "SuccessRegisterViewController.h"
#import "RecommendViewController.h"
#import "LoginViewController.h"
#import "UpdatePasswordViewController.h"
@interface SuccessRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
- (IBAction)cancelActionButton:(id)sender;
- (IBAction)updateUserBtnAction:(id)sender;
- (IBAction)leaveBtnAction:(id)sender;
- (IBAction)updatePasswordBtn:(id)sender;

@end

@implementation SuccessRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    AppDelegate *myAppdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.userNameTextField.text = myAppdelegate.userName;
    
    
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
//点击取消按钮
- (IBAction)cancelActionButton:(id)sender {
    NSLog(@"注册成功取消按钮");
    AppDelegate *appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDele.isLogin = YES;
   [self dismissViewControllerAnimated:YES completion:nil];
    
}
//点击修改用户名
- (IBAction)updateUserBtnAction:(id)sender {
    
    AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    myAppDelegate.userName = self.userNameTextField.text;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//点击退出登录
- (IBAction)leaveBtnAction:(id)sender {

    AppDelegate *myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    myAppDelegate.isLogin = NO;
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//修改密码
- (IBAction)updatePasswordBtn:(id)sender {
    UpdatePasswordViewController *updatepassvc =[[UpdatePasswordViewController alloc]init];
    [self presentViewController:updatepassvc animated:YES completion:nil];
    
}
#pragma mark --- 键盘回收
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//点击空白处键盘回收
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end

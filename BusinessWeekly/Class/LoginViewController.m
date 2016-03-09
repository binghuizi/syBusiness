//
//  LoginViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 scjy. All rights reserved.
//  /*-+~!@#$%^&()_+-=,./;'[]{}:<>?`
#define NMUBERS @"0123456789."
#define temp @" "
#import "LoginViewController.h"
#import <BmobSDK/BmobObject.h>
#import <BmobSDK/BmobUser.h>
#import "AppDelegate.h"
#import "SuccessRegisterViewController.h"
#import "RecommendViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>
- (IBAction)updatePasswordBtn:(id)sender;
@property(nonatomic,strong) NSString *userName;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
    
    //在输入手机号文本框  键盘return键变成下一行 next 键
    self.numberTextFiewld.returnKeyType = UIReturnKeyNext;
  //加密
    self.passwordTextField.secureTextEntry = YES;
    
    

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
#pragma mark ----注册功能
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

           //邮箱验证
            BmobUser *userEmail = [BmobUser getCurrentUser];
            //用户开启邮箱验证功能
            if ([userEmail objectForKey:@"emailVerified"]) {
                //用户没验证过邮箱
                if (![[userEmail objectForKey:@"emailVerified"] boolValue]) {
                    [userEmail verifyEmailInBackgroundWithEmailAddress:self.numberTextFiewld.text];
                }
            }
            
            
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功，5分钟之内将会给你发送一份邮件，请注意查收" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                AppDelegate *myAppdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                
                myAppdelegate.isLogin = YES;//登录成功
                
                NSString *stringName = self.numberTextFiewld.text;
                NSRange rang = [stringName rangeOfString:@"@"];
                
                myAppdelegate.userName =  [stringName substringToIndex:rang.location];;
                
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            
            [alertVc addAction:action];
            [self presentViewController:alertVc animated:YES completion:nil];
            
            
            
        }else{
            NSLog(@"%@",error);
            UIAlertController *alertcontroll = [UIAlertController alertControllerWithTitle:@"提示" message:@"该用户已经存在" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionAlert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alertcontroll addAction:actionAlert];
            [self presentViewController:alertcontroll animated:YES completion:nil];
            
            
        }
    }];
    
    
}
#pragma mark --- 登录功能
//登录按钮
- (IBAction)loginButton:(id)sender {
    
    
    [BmobUser loginWithUsernameInBackground:self.numberTextFiewld.text password:self.passwordTextField.text];
    
    [BmobUser loginWithUsernameInBackground:self.numberTextFiewld.text password:self.passwordTextField.text block:^(BmobUser *user, NSError *error) {
        if (user) {
            NSLog(@"登录成功 ");
            
            AppDelegate *appDele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            appDele.isLogin = YES;
           
            NSString *stringName = self.numberTextFiewld.text;
            NSRange rang = [stringName rangeOfString:@"@"];
         
                    
            appDele.userName =  [stringName substringToIndex:rang.location];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
        }else{
           
            UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码或邮箱有误" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
           
            [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(timerFireMethod:) userInfo:alertVc repeats:YES];
            
            
            [alertVc addAction:alertAction];
            [self presentViewController:alertVc animated:YES completion:nil];
            
        }
    }];
    
    
    
    
    
}
-(BOOL) cheakOut{
    //输入Email 不能为空
    if (self.numberTextFiewld.text.length <= 0 || [self.numberTextFiewld.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0 || ![self isValidateEmail:self.numberTextFiewld.text]) {
        
        NSLog(@"输入Email或电话号码无效");
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"输入Email或电话号码无效" preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:action];
        [NSTimer scheduledTimerWithTimeInterval:1.5F target:self selector:@selector(timerFireMethod:) userInfo:alertController repeats:YES];
       
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
        
    }
   
    
    //输入密码 不能为空
    if (self.passwordTextField.text.length <= 0 || [self.passwordTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length <= 0) {
        NSLog(@"密码不能为空格");
        return NO;
    }
    
    return YES;
  
}
//提示框 时间控制 几秒之后提示框自动消失
-(void)timerFireMethod:(NSTimer *)thTimer{
//    UIAlertView *promptAlert = (UIAlertView*)[thTimer userInfo];
//    
//    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
//    
//    promptAlert =NULL;
    
    
    UIAlertController *alertControl = (UIAlertController *)[thTimer userInfo];
    
    [alertControl dismissViewControllerAnimated:YES completion:nil];
    alertControl = NULL;
    
}
//判断邮箱格式
-(BOOL)isValidateEmail:(NSString *)email

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{3,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}
//判断手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//textField代理方法  实现弹出键盘时，输入框上移至不被隐藏
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"将要编辑");
    
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height + 216 + 150);
    NSLog(@"offset %f",offset);
    
    if (offset <= 0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    return YES;
}

////实现回收键盘时，输入框恢复原来的位置
//-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    NSLog(@"将要结束编辑");
//    
//   
//    
//    
//
//    return NO;
//}

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    //返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出first responder
//    //要想在用户结束编辑时阻止文本字段消失，可以返回NO
//    //这对一些文本字段必须始终保持活跃状态的程序很有用，比如即时消息
//    NSString *temp  =  [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    if ([temp length] != 0 ) {
//        return NO;
//    }
//    
//    return NO;
//}

//键盘回收
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField  == self.numberTextFiewld) {
        
      //点击换行  让下一个textField成为焦点
        [self.passwordTextField becomeFirstResponder];
        return YES;
    }else{
    //点击换行 键盘回收
        [textField resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            
            frame.origin.y = 0.0;
            
            self.view.frame = frame;
        }];
        return YES;
        
    }
        
    
  
}
//点击空白处键盘回收
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        
        frame.origin.y = 0.0;
        
        self.view.frame = frame;
    }];
    
    [self.view endEditing:YES];
}

//NSString *temp = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//if ([temp length] != 0) {
//    return NO;
//}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  //密码框内不能输入空格   http://www.cocoachina.com/bbs/read.php?tid=249995
    if ([textField isEqual:self.passwordTextField]) {
        //只能输入英文或中文
//        NSCharacterSet * charact;
//        charact = [NSCharacterSet whitespaceCharacterSet];
//        
//        NSString * filtered = [[string componentsSeparatedByCharactersInSet:charact]componentsJoinedByString:@""];
////        
//        BOOL canChange = [string isEqualToString:filtered];
//        if(!canChange) {
//            //        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入英文或中文"
//            //                                                        delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            //        [alert show];
//            return NO;
//        }
        
//        NSString *tem = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
        
//        if ([tem length] == 0) {
//            return NO;
//        }
        
        if (![string isEqualToString:tem]) {
            return NO;
        }
        
        
        

    }
        return YES;
}
#pragma mark --- 密码重置
//点击重置密码
- (IBAction)updatePasswordBtn:(id)sender {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"点击确定，重置密码的邮件将会发送到你的邮箱%@,点击取消不会发送",self.numberTextFiewld.text] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [BmobUser requestPasswordResetInBackgroundWithEmail:self.numberTextFiewld.text];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVc addAction:cancelAction];
    
    [alertVc addAction:alertAction];
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
    NSLog(@"密码重置");
}
@end

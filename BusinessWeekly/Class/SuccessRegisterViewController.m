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
@interface SuccessRegisterViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
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
    
    [self imageAction];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
        self.headImageView.image = self.image;
 
}
-(void)imageAction{
    self.headImageView.userInteractionEnabled = YES;
    //圆角设置
    self.headImageView.layer.cornerRadius = 20;
    self.headImageView.clipsToBounds = YES;
    //点击图片获取图片
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openImage)];
    [self.headImageView addGestureRecognizer:tap];
    
}

//打开系统相机
-(void)openImage{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        pickerImage.delegate = self;
        pickerImage.editing = YES;
        
        [self presentViewController:pickerImage animated:YES completion:nil];
        
    }
}
//获取原路径
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.image= info[UIImagePickerControllerOriginalImage];
    self.headImageView.image = self.image;//将图片显示在视图上；
    
    self.data = UIImageJPEGRepresentation(self.image, 0.5);
    self.path = [NSString stringWithFormat:@"%@/%@.png",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject,@"head"];
    
    [self.data writeToFile:self.path atomically:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if (self.path.length == 0) {
        self.isUpdateImage = NO;
    }else{
        self.isUpdateImage = YES;
    }
    
}
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
    
    if (self.isUpdateImage == NO) {
        self.headImageView.image = self.image;
         [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.succDelagate data:self.data :self.path];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
   
    
    
   
    
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
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        
        frame.origin.y = 0.0;
        
        self.view.frame = frame;
    }];

    return YES;
}
//textField代理方法  实现弹出键盘时，输入框上移至不被隐藏
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"将要编辑");
    
    CGFloat offset = self.view.frame.size.height - (textField.frame.origin.y + textField.frame.size.height +kWideth * 216/375 + kWideth * 150/375);
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
//点击空白处键盘回收
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        
        frame.origin.y = 0.0;
        
        self.view.frame = frame;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

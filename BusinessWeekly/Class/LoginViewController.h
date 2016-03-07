//
//  LoginViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)cancelButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *numberTextFiewld;


@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)regsiterButton:(id)sender;

- (IBAction)loginButton:(id)sender;

@end

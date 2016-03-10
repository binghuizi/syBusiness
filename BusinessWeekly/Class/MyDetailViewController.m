//
//  MyDetailViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "MyDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Information.h"
#import "ShouCangModel.h"
#import "MyViewController.h"
@interface MyDetailViewController ()

@end

@implementation MyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:self.imageString] placeholderImage:nil];
    self.nameLabel.text = self.nameString;
    self.timLabel.text = self.timeString;
    self.contentLabel.text = self.contentString;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(delegateAction)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = left;
   
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)delegateAction{
    ShouCangModel *model = [[ShouCangModel alloc]init];
    if ([model deleteInforWithId:self.idString] == 1) {
        NSLog(@"%@",self.idString);
        NSLog(@"删除成功");
       
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSLog(@"删除失败");
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

@end

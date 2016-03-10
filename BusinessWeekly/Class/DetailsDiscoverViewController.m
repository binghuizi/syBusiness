//
//  DetailsDiscoverViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/10.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DetailsDiscoverViewController.h"
#import <sdwebimage/UIImageView+WebCache.h>
#import "ShouCangModel.h"
#import "Information.h"
@interface DetailsDiscoverViewController ()
@property(nonatomic,strong) UIButton *lanmuButton;
@end

@implementation DetailsDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.headImage.layer.cornerRadius = 15;
    self.headImage.layer.masksToBounds = YES;
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.imageString] placeholderImage:nil];
    
    self.userNameLabel.text = self.nameString;
    self.timeLabel.text = [HWTools getHourFromString:self.timeString];
    self.contentLabel.text = self.contentString;
    
    
   self.lanmuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.lanmuButton.frame = CGRectMake(0, 0, 40, 40);
    [self.lanmuButton setImage:[UIImage imageNamed:@"wheltHeat"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:self.lanmuButton];
    self.navigationItem.rightBarButtonItem  = leftBarButton;
    [self.lanmuButton addTarget:self action:@selector(BarAction) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)BarAction{
    [self.lanmuButton setImage:[UIImage imageNamed:@"readHeat"] forState:UIControlStateNormal];
    ShouCangModel *model = [[ShouCangModel alloc]init];
    Information *information = [[Information alloc]initWithImage:self.imageString name:self.nameString time:self.timeString content:self.contentString idString:self.idString];
    NSLog(@"%@",self.idString);
    NSLog(@"%@",self.self.imageString);

    if ( [model insertIntoNewLinkMan:information] == 1) {
        NSLog(@"添加成功");
        
    }else{
        UIAlertController *alertcontrol = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        [alertcontrol addAction:action];
        [self presentViewController:alertcontrol animated:YES completion:nil];
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

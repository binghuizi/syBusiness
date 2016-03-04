//
//  AddsubScribeViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/2/21.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "AddsubScribeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SubScribleViewController.h"
@interface AddsubScribeViewController ()

@end

@implementation AddsubScribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订阅管理";
    //设置编辑按钮样式
    [self.editButton.layer setMasksToBounds:YES];//圆角半径不会被遮挡
    [self.editButton.layer setCornerRadius:8];
    [self.editButton.layer setBorderWidth:2];
    //按钮边界颜色
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGColorRef color              = CGColorCreate(colorSpaceRef, (CGFloat[]){0.8,0.5,0.5,1});
    [self.editButton.layer setBorderColor:color];
    
//控制控件是否能滚动
    self.scrollView.scrollEnabled = YES;
    
//imageView的宽度
    float width = 78.0f;
//高度
    float height = 100.0f;
//列间距，左右间隔
    float columnGap = (kWideth - width*4) / 5;
//行间距，即上下间隔
    float rowGap = 15.0f;
    NSInteger row;
    
//计算有多少张图片
  NSInteger  imageCount = self.addSubScribeArray.count + 2;
    if (imageCount % 4 == 0) {
        row = imageCount / 4;
    }else{
        row = imageCount / 4 + 1;
    }
    NSInteger index = 0;
    NSInteger number = 0;
    float hangHeight = 0;
    float gao = 0;
    float lane1Height = 0;
    for (int i = 0; i < row; i++) {
        for (int j = 0; j < 4; j++) {
            if (index >= imageCount-2 ) {
                break;
            }
            
            hangHeight = rowGap+(height + columnGap) * i + gao;
            
            
    UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(columnGap+(width+rowGap) * j, hangHeight, width, height)];
            imageButton.tag = number;
            
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(columnGap+(width+rowGap) * j,hangHeight , width, height)];
            if (number == 8) {
                imageView1.image = [UIImage imageNamed:@"daxuan"];
                index--;
            }else if (number == 16 ){
                imageView1.image = [UIImage imageNamed:@"tiyu"];
                index--;
            }else if (number > 10){
                gao = 60 ;
                [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.addSubScribeArray[index]] placeholderImage:nil];
               

            }else{
                [imageView1 sd_setImageWithURL:[NSURL URLWithString:self.addSubScribeArray[index]] placeholderImage:nil];
            }
            
//设置图片圆角
            imageView1.layer.cornerRadius = 8;
            imageView1.layer.masksToBounds = YES;
//边框宽度以及颜色设置
            [imageView1.layer setBorderWidth:1];
//保持图片的宽高比
            imageView1.contentMode = UIViewContentModeScaleAspectFit;

            index++;
            number++;
//为按钮添加touch事件
            [imageButton addTarget:self action:@selector(touchPhoto:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.scrollView addSubview:imageButton];
            [self.scrollView addSubview:imageView1];
        }
    }
//scrollView高度
    [self.scrollView setContentSize:CGSizeMake(kWideth, (height + rowGap) * row)];
//添加中间更多订阅栏目
    UIImageView *lineView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 405, kWideth, 2)];
    lineView1.image = [UIImage imageNamed:@"grayLine"];
    
    UIImageView *lineView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 348, kWideth, 2)];
    lineView2.image = [UIImage imageNamed:@"grayLine"];
    [self.scrollView addSubview:lineView1];
    [self.scrollView addSubview:lineView2];
//label 更多订阅栏目
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kWideth/6, 350, 180, 50)];
    label.text = @"更多订阅栏目";
    label.textColor = [UIColor lightGrayColor];
    [self.scrollView addSubview:label];
    
    
}
-(void)touchPhoto:(UIButton *)btn{
    
    
    SubScribleViewController *subScriView = [[SubScribleViewController alloc]init];
    
    subScriView.catString = self.tageNameArray[btn.tag];
    subScriView.cateNameString = self.cateNameArray[btn.tag];
    
    [self.navigationController pushViewController:subScriView animated:YES];
    
    
    
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

- (IBAction)editAction:(id)sender {
}
@end

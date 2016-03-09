//
//  RecommendViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/1/29.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuccessRegisterViewController.h"
@interface RecommendViewController : UIViewController<successRegisterViewControllerDelagate>
@property(nonatomic,strong) NSString *catString;
@property(nonatomic,strong) NSString *catName;

@property(nonatomic,retain) UIView *mainView;
@property(nonatomic,retain) UIView *leftView;
@property(nonatomic,retain) UIView *rightView;
@property(nonatomic,retain) UIView *contentView;
@property(nonatomic,assign) NSInteger cellHeight;
@property(nonatomic,assign) NSIndexPath *indexrow;
@property(nonatomic, retain) NSString *path;
@property(nonatomic, retain) NSData *data;
@property(nonatomic, retain) UIImage *readimage;
-(void)setmainViewX:(CGFloat)endX;
-(void)BarAction:(UIButton *)btn;

@property(nonatomic,assign) BOOL isImage;
@end

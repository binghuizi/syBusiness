//
//  SuccessRegisterViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/3/8.
//  Copyright © 2016年 scjy. All rights reserved.
//

@protocol successRegisterViewControllerDelagate <NSObject>


-(void)data:(NSData *)data:(NSString *)path;

@end

#import <UIKit/UIKit.h>

@interface SuccessRegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property(nonatomic, retain) NSData *data;

@property(nonatomic, retain) NSString *path;

@property(nonatomic,assign) id<successRegisterViewControllerDelagate> succDelagate;
@property(nonatomic,assign) BOOL isUpdateImage;
@property(nonatomic, retain)UIImage *image;
@property(nonatomic,strong) NSString *stringImage;
@end

//
//  AddsubScribeViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/2/21.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddsubScribeViewController : UIViewController
@property(nonatomic,retain) NSMutableArray *addSubScribeArray;
@property(nonatomic,retain) NSMutableArray *tageNameArray;
@property(nonatomic,strong) NSMutableArray *cateNameArray;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)editAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

//
//  DetailsViewController.h
//  BusinessWeekly
//
//  Created by scjy on 16/2/21.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "WXApi.h"
@interface DetailsViewController : UIViewController<WBHttpRequestDelegate>
@property(nonatomic,strong) NSString *htmlString;
@property(nonatomic,strong) NSString *shareTitle;

@end

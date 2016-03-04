//
//  DetailsViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/2/21.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DetailsViewController.h"
#import "ProgressHUD.h"
#import "AppDelegate.h"
@interface DetailsViewController ()<UIWebViewDelegate>
@property(nonatomic,retain) UIWebView  *webView;
@property(nonatomic,retain) UIActivityIndicatorView *activityView;
@property(nonatomic,strong) UIView *shareView;
@property(nonatomic,strong) UIView *grayView;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//自定义导航栏上右边按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self  action:@selector(touchAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
 
    
    //菊花
    self.activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.backgroundColor = [UIColor lightGrayColor];
    //菊花设置在中间
    self.activityView.center = self.view.center;
   // [self.activityView startAnimating];
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    //页面边界嫩否滑动
    self.webView.scrollView.bounces = NO;
    //网址
    NSString *urlString = self.htmlString;
    NSURL  *url = [NSURL URLWithString:urlString];
    //网络请求
   NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //请求超时
   // [request setTimeoutInterval:10.0];
    //网络请求内容
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.activityView];
    
}
//webview的代理方法
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //网页请求时显示菊花
    //[self.activityView startAnimating];
    [ProgressHUD show:@"努力在加载中"];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    //网页请求完毕菊花消失
   // [self.activityView stopAnimating];
    [ProgressHUD showSuccess:@"加载完成"];
}
//点击导航栏上右按钮触发事件
- (void)touchAction{
    UIWindow *windw = [[UIApplication sharedApplication].delegate window];
    //阴影
    self.grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWideth, kHeight)];
    self.grayView.backgroundColor = [UIColor darkGrayColor];
    self.grayView.alpha = 0.8;
    [windw addSubview:self.grayView];
    
    self.shareView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight/3 , kWideth, kHeight/2)];
    
    self.shareView.backgroundColor = [UIColor colorWithRed:233/255.0f green:243/255.0f blue:245/255.0f alpha:1.0];
    
    [windw addSubview:self.shareView];
    
    //微博
    
    
    UIButton *weiBoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    weiBoButton.frame = CGRectMake(50, 60, 35, 35);
    [weiBoButton setImage:[UIImage imageNamed:@"sina_normal"] forState:UIControlStateNormal];
    [weiBoButton addTarget:self action:@selector(weiboShareAction:) forControlEvents:UIControlEventTouchUpInside];
    weiBoButton.tag = 1;
    [self.shareView addSubview:weiBoButton];
    
    UILabel *weiBoLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 100, 80, 40)];
    weiBoLabel.font = [UIFont systemFontOfSize:13];
    weiBoLabel.text = @"新浪微博";
    [self.shareView addSubview:weiBoLabel];
    
    //微信
    
    UIButton *weiXinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    weiXinButton.frame = CGRectMake(150, 60, 35, 35);
    [weiXinButton setImage:[UIImage imageNamed:@"wx_normal"] forState:UIControlStateNormal];
    [weiXinButton addTarget:self action:@selector(weixinShareAction:) forControlEvents:UIControlEventTouchUpInside];
    weiXinButton.tag = 2;
    
    UILabel *weixinLabel = [[UILabel alloc]initWithFrame:CGRectMake(155, 100, 80, 40)];
    weixinLabel.font = [UIFont systemFontOfSize:13];
    weixinLabel.text = @"微信";
    [self.shareView addSubview:weixinLabel];
    [self.shareView addSubview:weiXinButton];
    
    
    //盆友圈
    
    
    UIButton *friendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    friendButton .frame = CGRectMake(250, 60, 35, 35);
    [friendButton  setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    
    UILabel *friendLabel = [[UILabel alloc]initWithFrame:CGRectMake(252, 100, 80, 40)];
    friendLabel.font = [UIFont systemFontOfSize:13];
    friendLabel.text = @"朋友圈";
    
    [friendButton addTarget:self action:@selector(friendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.shareView addSubview:friendLabel];
    
    [self.shareView addSubview:friendButton];
    
    //清除
    
    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    removeButton .frame = CGRectMake(20, 160,kWideth - 40, 44);
    
    [removeButton setTitle:@"取消" forState:UIControlStateNormal];
    [removeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    removeButton.backgroundColor = [UIColor colorWithRed:227/255.0f green:218/255.0f blue:183/255.0f alpha:1.0];
    [self.shareView addSubview:removeButton];
    
    
    
    [UIView animateWithDuration:1.0 animations:^{
        
        
    }];

}
-(void)cancelAction{
 //隐藏
    self.shareView.hidden = YES;
    self.grayView.hidden = YES;
}
//点击微博分享
-(void)weiboShareAction:(UIButton *)bth{
    self.shareView.hidden = YES;//隐藏
    self.grayView.hidden = YES;
    AppDelegate *myDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //授权
    WBAuthorizeRequest *autharaequest = [WBAuthorizeRequest request];
    autharaequest.redirectURI = kRedirectURI;
    autharaequest.scope = @"all";
    //第三方向微博发送请求
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:autharaequest access_token:myDelegate.wbtoken];
    request.userInfo = nil;
    [WeiboSDK sendRequest:request];
}
-(WBMessageObject *)messageToShare{
    WBMessageObject *message = [WBMessageObject message];
    message.text = [NSString stringWithFormat:@"%@%@",self.shareTitle,self.htmlString];
    return message;
}
//微信分享
#pragma mark ----微信分享-----
-(void)weixinShareAction:(UIButton *)btn{
    
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    //取消授权
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"1"];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.text = self.htmlString;
    req.bText = YES;
    //微信
    req.scene = WXSceneSession;
    [WXApi sendReq:req];
    
    
    
}

//朋友圈
-(void)friendAction{
 
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    //取消授权
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"1"];
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.text = self.htmlString;
    req.bText = YES;
    //朋友圈
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];



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

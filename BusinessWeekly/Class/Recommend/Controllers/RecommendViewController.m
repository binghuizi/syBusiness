//
//  RecommendViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/1/29.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "RecommendViewController.h"
#import "PullingRefreshTableView.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "ArticleModel.h"
#import "ProgressHUD.h"
#import "RecommModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DateTableViewCell.h"
#import "Date2TableViewCell.h"
#import "FeatureAndTVTableViewCell.h"
#import "DetailsViewController.h"
#import "AddsubScribeViewController.h"
#import "LeftRevealViewController.h"
#import "RightRevealViewController.h"
#import "LoginViewController.h"
#import "SuccessLoginRightViewController.h"

@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate,LeftRevealViewControllerDelegate,RightRevealViewControlDelegate>{
     NSInteger _pageCount;//定义请求页码
    LeftRevealViewController *_leftVc;
    RightRevealViewController *_rightVc;
    SuccessLoginRightViewController *_succLoginRightVc;
    
    
}
@property(nonatomic,strong) PullingRefreshTableView *tableView;
@property(nonatomic,strong) UITableView *headTableView;
@property(nonatomic,assign) BOOL refreshing;
@property(nonatomic,strong) NSArray *articleArray;
@property(nonatomic,strong) NSMutableArray *headTitleArray;
@property(nonatomic,strong) NSArray *numberArray;
@property(nonatomic,strong) NSMutableArray *recomDataArray;
@property(nonatomic,strong) NSMutableArray *allRecomDataArray;
@property(nonatomic,strong) NSMutableArray *bigPictureArray;
@property(nonatomic,strong) NSMutableArray *allBigPictureArray;
@property(nonatomic,strong) NSMutableArray *smalPictureArray;
@property(nonatomic,strong) NSMutableArray *allSmalPictureArray;
@property(nonatomic,strong) NSMutableArray *pictureTitleArray;
@property(nonatomic,strong) NSMutableArray *addSubscriptArray;
@property(nonatomic,strong) NSMutableArray *tageNameArray;
@property(nonatomic,strong) NSMutableArray *cateNameArray;
@property(nonatomic,strong) NSMutableArray *webUrlArray;
@property(nonatomic,strong) NSMutableArray *allWebUrlArray;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) NSTimer *timer;//定时器用于图片滚动
@property(nonatomic,strong) UIButton *addButton;
@property(nonatomic,strong) NSMutableArray *colorArray;



@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"推荐";
//设置 navigationController 左右按钮
    [self navigationAction];
    
    
//标题网络请求数据
    [self heardTitle];
    //多余的tableView内容
    self.automaticallyAdjustsScrollViewInsets = NO;
//抽屉效果 三个View
    
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightView];
    [self.view addSubview:self.mainView];
    
    [self.leftView addSubview:_leftVc.view];
    [self.rightView addSubview:_rightVc.view];
    
    [self.mainView addSubview:self.headTableView];
    [self.mainView addSubview:self.tableView];
    [self.mainView addSubview:self.addButton];
    
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DateTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Date2TableViewCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FeatureAndTVTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    
    [self startTimer];
    self.catString = @"cat_15";
    self.catName = @"推荐";
    [self loadData];
   
    
   
    
    
  
    
//添加按钮
    
}

#pragma mark ---navigationController  左右按钮设置
-(void)navigationAction{
    //导航栏上的颜色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    UIButton *lanmuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *personButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lanmuButton.frame = CGRectMake(0, 0, 40, 40);
    personButton.frame = CGRectMake(0, 0, 40, 40);
    
    [lanmuButton setImage:[UIImage imageNamed:@"lanmu"] forState:UIControlStateNormal];
    [personButton setImage:[UIImage imageNamed:@"person"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:lanmuButton];
    
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:personButton];
   
    
    self.navigationItem.rightBarButtonItem = rightBarButton;
    self.navigationItem.leftBarButtonItem  = leftBarButton;
    
    [lanmuButton addTarget:self action:@selector(BarAction:) forControlEvents:UIControlEventTouchUpInside];
    lanmuButton.tag = 1;
    [personButton addTarget:self action:@selector(BarAction:) forControlEvents:UIControlEventTouchUpInside];
    
    personButton.tag = 2;
    
}

//点击导航栏上的添加按钮
-(void)BarAction:(UIBarButtonItem *)btn{
    if (btn.tag == 1) {
        
#pragma mark --- 点击左按钮 抽象视图出现
        _leftVc.titleArray = self.cateNameArray;
        _leftVc.leftColorArray = self.colorArray;
        
        _leftVc.tageNameArray = self.tageNameArray;
        
        
        [_leftVc.tableView reloadData];
        
        
        CGFloat startX = _mainView.frame.origin.x;
        
        //为mainView添加阴影效果
        [self addShadowFormainViewWithEndX:1];
        // 定义一个临时变量
        CGFloat tempEndX = 0;
        _leftView.hidden = NO;
        _rightView.hidden = YES;
        if (startX == 0) {
            tempEndX = kLeftWidth;
            
        }else if (startX == kLeftWidth){
            tempEndX = 0;
        }
        
        //最后设置mainView的x
        [self setmainViewX:tempEndX];
        
    }else if (btn.tag == 2){
        
         CGFloat startX = _mainView.frame.origin.x;
        //为mainView添加阴影效果
        [self addShadowFormainViewWithEndX:-1];
        // 定义一个临时变量
        CGFloat tempEndX = 0;
        _leftView.hidden = YES;
        _rightView.hidden = NO;
        
        if (startX == 0) {
            tempEndX = - kRightWidth;
        }else if (startX == - kRightWidth){
            tempEndX = 0;
        }
        
        [self setmainViewX:tempEndX];
        
        
        
        
        
        
    }else{
        AddsubScribeViewController *addSubScribeView= [[AddsubScribeViewController alloc]initWithNibName:@"AddsubViewController" bundle:nil];
        //传值 获取网络图片路径 传值给 页面
        addSubScribeView.addSubScribeArray = self.addSubscriptArray;
        //网上解析数据根据tagename 将tagename传值给页面  进行解析
        addSubScribeView.tageNameArray = self.tageNameArray;
        addSubScribeView.cateNameArray = self.cateNameArray;
        [self.navigationController pushViewController:addSubScribeView animated:YES];
    }
    
    
}
//
// 抽取出来的公共代码,设置mainView的x,参数是endX
-(void)setmainViewX:(CGFloat)endX{
    CGRect frame = self.mainView.frame;
    frame.origin.x = endX;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.mainView.frame=frame;
    }];
}
//添加阴影图层
-(void)addShadowFormainViewWithEndX:(CGFloat)endX{
    // 1,点击工程,加号,导入第3方框架 #import <QuartzCore/QuartzCore.h>
    
    // 2,拿到mainView所在的图层,设置阴影 参数
    
    // NSLog(@"调用频率很高---");
    _mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    _mainView.layer.shadowOpacity = 0.5;
    
    if (endX >= 0) {
        _mainView.layer.shadowOffset = CGSizeMake(-5, 0);
    } else {
        _mainView.layer.shadowOffset = CGSizeMake(5, 0);
    }
}
#pragma mark --- 遵循leftRevealViewController 代理方法
-(void)leftData:(NSString *)tageName cateName:(NSString *)catename number:(NSInteger)num{
//main视图推出
    [self setmainViewX:0];
//颜色消失
    [self.headTableView deselectRowAtIndexPath:self.indexrow animated:YES];
//重新设置self.headTableView位置
    [UIView animateWithDuration:1.0 animations:^{
        self.headTableView.contentOffset =  CGPointMake(0, num * self.cellHeight);
        
        
    }];
    
//加载数据 时传递catstring
    self.catString = tageName;
//传递   ...加载成功
    self.catName = catename;
    self.navigationItem.title = self.catName;
//重新加载数据 解析
    [self loadData];
}
-(void)pushAddSubviweController{
   AddsubScribeViewController *addSubScribeView= [[AddsubScribeViewController alloc]initWithNibName:@"AddsubViewController" bundle:nil];
    //传值 获取网络图片路径 传值给 页面
    addSubScribeView.addSubScribeArray = self.addSubscriptArray;
    //网上解析数据根据tagename 将tagename传值给页面  进行解析
    addSubScribeView.tageNameArray = self.tageNameArray;
    addSubScribeView.cateNameArray = self.cateNameArray;
    
    [self.navigationController pushViewController:addSubScribeView animated:YES];
}
//右边的抽屉页面遵循代理
-(void)popViewController{
    LoginViewController *loginView = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    
    [self  presentViewController:loginView animated:YES completion:nil];
  
}
#pragma mark ------网络请求解析 获得数据
//解析标题 推荐 金融 科技 特写......
-(void)heardTitle{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];//  text/html
    [sessionManager GET:kHeadTitle parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // ZJHLog(@"%@",responseObject);
        //解析成功
        NSDictionary *resultDic = responseObject;
        self.articleArray = resultDic[@"articletag"];
     //   AddsubScribeViewController *addSubScribe = [[AddsubScribeViewController alloc]init];
      //订阅管理
        
        
        
        for (NSDictionary *dic in self.articleArray) {
            ArticleModel *model = [[ArticleModel alloc]initWithDictionary:dic];
            [self.colorArray addObject:model.color];
            [self.headTitleArray addObject:model];
//标题加入数组
            [self.cateNameArray addObject:model.catname];
//tagname加入数组
            [self.tageNameArray addObject:dic[@"tagname"]];
            NSArray *addSubScriptArray =dic[@"phoneColumnProperty"][@"subscriptPicture_l"];
          //将订阅管理的图片存入数组中
            for (NSDictionary *subDic in addSubScriptArray) {
                [self.addSubscriptArray addObject:subDic[@"url"]];
            }
            
        }
       
        
        
        [self.headTableView reloadData];//刷新数据
   
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
}
#pragma mark  
- (void)configTableView{
    UIView *tableHeaderView = [[UIView alloc]init];
    tableHeaderView.frame = CGRectMake(0, 0, kWideth, 240);
    [tableHeaderView addSubview:self.scrollView];
    
    
//判断需要几张图片
   NSInteger numberCount;
    if ([self.catString isEqualToString:@"cat_15"]) {
        numberCount = self.allBigPictureArray.count;
    }else{
        numberCount = 1;
    }
    //圆点个数
    self.pageControl.numberOfPages = numberCount;
    [tableHeaderView addSubview:self.pageControl];
#pragma mark ---给scrollView 添加图片
    self.scrollView.contentSize = CGSizeMake(numberCount * kWideth, 240);

    for (int i = 0; i < numberCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kWideth * i, 0, kWideth, 240)];
        //图片上的文字
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kWideth * i, 200, kWideth, 40)];
        titleLabel.backgroundColor = [UIColor blackColor];
        titleLabel.alpha = 0.6;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.tintColor = [UIColor redColor];
        
        titleLabel.text = self.pictureTitleArray[i];
        NSLog(@"%@",self.pictureTitleArray[i]);
       
        
    
        imageView.userInteractionEnabled = YES;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.allBigPictureArray[i]] placeholderImage:nil];
       
        [self.scrollView addSubview:imageView];
        //[imageView addSubview:titleLabel];
        [self.scrollView addSubview:titleLabel];
        
        UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        touchButton.frame = imageView.frame;
        touchButton.tag = i;
        [touchButton addTarget:self action:@selector(adTouchAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:touchButton];
        
    }
    
    //区头添加
    self.tableView.tableHeaderView = tableHeaderView;

}
//首页轮番
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //scrollView宽度
    CGFloat pageWidth = self.scrollView.frame.size.width;
    //偏移量
    CGPoint offSet = self.scrollView.contentOffset;
    //偏移量除以宽度就是圆点的个数
    NSInteger pageNumber = offSet.x /pageWidth;
    self.pageControl.currentPage = pageNumber;
    
    
    
}
#pragma mark --- 圆点动视图也动
-(void)touchActionPage:(UIPageControl *)pageControl{
    //当前圆点的个数
    NSInteger pageNumber = pageControl.currentPage;
    //scrollView的宽度
    CGFloat pageWidth = self.scrollView.frame.size.width;
    //scrollView的偏移量
    self.scrollView.contentOffset = CGPointMake(pageNumber *pageWidth, 0);
}
#pragma mark --- 开始定时轮番
-(void)startTimer{
    if (self.timer != nil) {
        return;
    }
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
//每两秒执行该方法
-(void)updateTimer{
    //当self.adArray.count数据组元素个数为0当对0取于时候没有意义
    if (self.allBigPictureArray.count > 0) {
        //当前页数加1
        NSInteger page = self.pageControl.currentPage + 1;
        CGFloat offSex = page % self.allBigPictureArray.count;
        self.pageControl.currentPage = offSex;
        [self touchActionPage:self.pageControl];
    }
}

//挡手动滑动scrollView的时候定时器依然在计算事件可能我们刚刚滑动到那  定时器有高好书法导致当前也停留的事件补不够两秒
//解决方案 scroll开始移动时 结束定时器在scroll在移动完毕时候  在启动定时器
//将要开始拖拽  定时器取消
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;//定时器停止，niu
}
//拖拽完毕
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self startTimer];
}
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.headTableView]) {
       
        return self.articleArray.count - 13;
    }else if ([tableView isEqual:self.tableView]){
        if ([self.catName isEqualToString:@"cat_15"]) {
            
           // return self.allRecomDataArray.count - self.bigPictureArray.count;
            return self.allRecomDataArray.count - self.allBigPictureArray.count;
            
        }else{
            return self.allRecomDataArray.count - 1;
        }
      
    }
    return 0;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.headTableView ]) {
        static NSString *iden = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
            
        }
        //cell顺时针旋转90度       -(M_PI + M_PI_2)
        cell.transform = CGAffineTransformMakeRotation(M_PI / 2);
        ArticleModel *model = self.headTitleArray[indexPath.row];
        cell.textLabel.text = model.catname;
        
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
       
        return cell;

    }else if ([tableView isEqual:self.tableView]){
        
       
        RecommModel *model = self.allRecomDataArray[indexPath.row];
        
        if ([model.fromtagname isEqualToString:@"cat_15"]) {
             DateTableViewCell *dateCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
//            dateCell.recomModel = self.allRecomDataArray[indexPath.row+self.allBigPictureArray.count];
//            dateCell.recomModel.url = self.allSmalPictureArray[indexPath.row+self.allBigPictureArray.count];
            
            dateCell.recomModel = self.allRecomDataArray[indexPath.row+self.allBigPictureArray.count];
            dateCell.recomModel.url = self.allSmalPictureArray[indexPath.row+self.allBigPictureArray.count];
            
            
//            dateCell.recomModel = self.allRecomDataArray[indexPath.row];
//            dateCell.recomModel.url = self.allSmalPictureArray[indexPath.row];
           
            NSLog(@"cell = %ld",self.allRecomDataArray.count);
            
            
            return dateCell;
        }else if ([model.fromtagname isEqualToString:@"cat_18"]||[model.fromtagname isEqualToString:@"cat_14"]){
            FeatureAndTVTableViewCell *featureCell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
            featureCell.model = self.allRecomDataArray[indexPath.row + 1];
            featureCell.model.pictureUrl = self.allBigPictureArray[indexPath.row + 1];
            
            NSLog(@"%ld",self.allRecomDataArray.count);
            return featureCell;
            
            
            
        }else{
            Date2TableViewCell *date2Cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            date2Cell.recomModel     = self.allRecomDataArray[indexPath.row + 1];
            date2Cell.recomModel.url = self.allSmalPictureArray[indexPath.row + 1];
            
            return date2Cell;
        }
        
    }
    return nil;
    
}
//自定义高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.headTableView]) {
        ArticleModel *model = self.headTitleArray[indexPath.row];
       CGFloat height = [HWTools getTextHeightWithText:model.catname Bigsize:CGSizeMake(20,900) textFont:13.0];
        self.cellHeight = height + 20;
        return height + 20;
    }else if ([tableView isEqual:self.tableView]){
        if ([self.catString isEqualToString:@"cat_15"]) {
            return 125;
        }else if ([self.catString isEqualToString:@"cat_18"]|| [self.catString isEqualToString:@"cat_14"]){
            return 260;
        }else{
        return 105;
        }}
    return 40;
    
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    ArticleModel *model = self.headTitleArray[indexPath.row];
    
    if ([tableView isEqual:self.headTableView]) {
        
        self.indexrow = indexPath;
    
    self.numberArray = [HWTools arrayWithString:model.color];
        
        
         //设置选中时tableview的颜色
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGFloat number  = [self.numberArray[0] floatValue];
        CGFloat number1 = [self.numberArray[1] floatValue];
        CGFloat number2 = [self.numberArray[2] floatValue];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:number/255.0f green:number1/255.0f blue:number2/255.0f alpha:0.78];
        // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
      //改变标题
        self.navigationItem.title = model.catname;
    
//网络请求传值
        self.catString = model.tagname;
        self.catName = model.catname;
        [self loadData];
        
      
  
        

    }else if ([tableView isEqual:self.tableView]){
        
        
     DetailsViewController *detailsView = [[DetailsViewController alloc]init];
        
        if ([self.catName isEqualToString:@"推荐"]) {
             RecommModel *recomModel = self.allRecomDataArray[indexPath.row+self.allBigPictureArray.count];
            
            
            detailsView.htmlString = self.allWebUrlArray[indexPath.row + self.allBigPictureArray.count];
            detailsView.shareTitle = recomModel.title;
           
            
        }else{
            RecommModel *recomModel = self.allRecomDataArray[indexPath.row+1];
           
            detailsView.htmlString = self.allWebUrlArray[indexPath.row + 1];
          //  detailsView.htmlString = recomModel.webUrl;
            detailsView.shareTitle = recomModel.title;
        }
        
        [self.navigationController pushViewController:detailsView animated:YES];
        
        
    }
    
}




#pragma mark --- pullingdelagate
//tableview开始算新的时候调用 //下拉
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount = 1;
    self.refreshing = YES;
    // [self loadData];//加载数据
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.0];
    
}
//上拉  Implement this method if headerOnly is false
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _pageCount +=1;
    self.refreshing = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}
//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate{
    
    return [HWTools getSystemNowDate];
}
//手指开始拖动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView tableViewDidScroll:scrollView];
}
//上拉
//手指结束拖动方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableView tableViewDidEndDragging:scrollView];
}
#pragma mark ---网络请求 主页数据
//解析数据
-(void)loadData{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]init];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [ProgressHUD show:[NSString stringWithFormat:@"%@加载中",self.catName]];
   
   //解析数据
    [sessionManager GET:[NSString stringWithFormat:@"%@%@%@",kRecommend,self.catString,@"/articlelist?updatetime=1454062401"] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog("%@",responseObject);
        [ProgressHUD showSuccess:[NSString stringWithFormat:@"%@加载成功",self.catName]];
        
        NSDictionary *resultdic = responseObject;
        NSArray *arctiyArray = resultdic[@"articletag"];
        NSDictionary *dic = arctiyArray[0];
        NSArray *dataArray = dic[@"article"];
        if (self.allRecomDataArray.count > 0) {
            [self.allRecomDataArray   removeAllObjects];
            [self.allSmalPictureArray removeAllObjects];
            [self.allBigPictureArray  removeAllObjects];
            [self.allWebUrlArray removeAllObjects];
        }
        if (self.refreshing) {
            if (self.allRecomDataArray.count > 0) {
                [self.allRecomDataArray   removeAllObjects];
                [self.allSmalPictureArray removeAllObjects];
                [self.allBigPictureArray  removeAllObjects];
                [self.allWebUrlArray removeAllObjects];
            }
        }
       
        for (NSDictionary *dataDic in dataArray) {
            RecommModel *recomModel = [[RecommModel alloc]initWithDictionary:dataDic];
            [self.recomDataArray addObject:recomModel];
            [self.pictureTitleArray addObject:recomModel.title];
            
//详情内容web地址
            
            NSArray *phonepageArray = dataDic[@"phonepagelist"];
            for (NSDictionary *phoneDic in phonepageArray) {
                recomModel.webUrl = phoneDic[@"url"];
                [self.webUrlArray addObject:phoneDic[@"url"]];
            }
            
            
            
            
            
            NSArray *bigArray = dataDic[@"picture"];
//将大图片添加到数组中
            for (NSDictionary *bigDic in bigArray) {
                
                [self.bigPictureArray addObject:bigDic[@"url"]];
                recomModel.pictureUrl = bigDic[@"url"];
            }
            NSArray *smalArray = dataDic[@"thumb"];
//将小图片添加到数组中
            for (NSDictionary *smalDic in smalArray) {
                recomModel.url = smalDic[@"url"];
                [self.smalPictureArray addObject:smalDic[@"url"]];
            }

            
        }
        
        [self reloadAction];

      

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
        
    }];
    
}
-(void)reloadAction{
    
        self.allRecomDataArray   = self.recomDataArray;
        self.allSmalPictureArray = self.smalPictureArray;
        self.allBigPictureArray  = self.bigPictureArray;
             self.allWebUrlArray = self.webUrlArray;
    
    [self.tableView tableViewDidFinishedLoading];//完成加载
   
    //刷新数据
        [self.tableView reloadData];
        //刷新数据 重新加载该方法configTableView
        [self configTableView];
    
    

}
#pragma mark --- 给图片触发点击事件
//点击图片触发事件
-(void)adTouchAction:(UIButton *)btn{
    DetailsViewController *detailView = [[DetailsViewController alloc]init];
    detailView.htmlString = self.allWebUrlArray[btn.tag];
    detailView.shareTitle = self.pictureTitleArray[btn.tag];
    NSLog(@"%@",detailView.shareTitle);
       [self.navigationController pushViewController:detailView animated:YES];

}
#pragma mark --懒加载
//懒加载
-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 120, kWideth, kHeight)];
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.backgroundColor = [UIColor lightGrayColor];
        self.tableView.rowHeight = 50;
        
    }
    return _tableView;
}
-(UITableView *)headTableView{
    if (_headTableView == nil) {
        self.headTableView = [[UITableView alloc]initWithFrame:CGRectMake(140, -80, kWideth - 300, kWideth - 20) style:UITableViewStylePlain];
        
       // self.headTableView.backgroundColor = [UIColor redColor];
        
        self.headTableView.dataSource = self;
        self.headTableView.delegate = self;
       // self.headTableView.backgroundColor = [UIColor magentaColor];
        ///tableview逆时针旋转90度。  -M_PI / 2
        self.headTableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        self.headTableView.bounces = NO;//上啦下拉禁止
        self.headTableView.showsVerticalScrollIndicator = NO;//滚动条隐藏
    //    self.headTableView.rowHeight = 50;
    }
    
    return _headTableView;
}
//标题懒加载
-(NSMutableArray *)headTitleArray{
    if (_headTitleArray == nil) {
        self.headTitleArray = [NSMutableArray new];
    }
    return _headTitleArray;
}
-(NSMutableArray *)recomDataArray{
    if (_recomDataArray == nil) {
        self.recomDataArray = [NSMutableArray new];
    }
    return _recomDataArray;
}
-(NSMutableArray *)allRecomDataArray{
    if (_allRecomDataArray == nil) {
        self.allRecomDataArray = [NSMutableArray new];
    }
    return _allRecomDataArray;
}

-(NSMutableArray *)bigPictureArray{
    if (_bigPictureArray == nil) {
        self.bigPictureArray = [NSMutableArray new];
    }
    return _bigPictureArray;
}
-(NSMutableArray *)allBigPictureArray{
    if (_allBigPictureArray == nil) {
        self.allBigPictureArray = [NSMutableArray new];
    }
    return _allBigPictureArray;
}
-(NSMutableArray *)smalPictureArray{
    if (_smalPictureArray == nil) {
        self.smalPictureArray = [NSMutableArray new];
    }
    return _smalPictureArray;
}
-(NSMutableArray *)allSmalPictureArray{
    if (_allSmalPictureArray == nil) {
        self.allBigPictureArray = [NSMutableArray new];
    }
    return _allSmalPictureArray;
}
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWideth, 240)];
        self.scrollView.delegate = self;
        //可以添加图片的个数
        self.scrollView.contentSize = CGSizeMake(self.bigPictureArray.count * kWideth, 240);
        //整屏滑动
        self.scrollView.pagingEnabled = YES;
        //垂直方向的滚动条no不显示
        self.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}
//pageControl
-(UIPageControl *)pageControl{
    if (_pageControl == nil) {
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(80, 186 - 30, kWideth, 30)];
        //当前选中的颜色
        self.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        //点击圆点触发事件
        [self.pageControl addTarget:self action:@selector(touchActionPage:) forControlEvents:UIControlEventValueChanged];
        //分页初始化页数
        self.pageControl.currentPage = 0;
    }
    return _pageControl;
}
//轮番图片上的标题
-(NSMutableArray *)pictureTitleArray{
    if (_pictureTitleArray == nil) {
        self.pictureTitleArray = [NSMutableArray new];
    }
    return _pictureTitleArray;
}
//点击导航栏上的添加   数组懒加载
-(NSMutableArray *)addSubscriptArray{
    if (_addSubscriptArray == nil) {
        self.addSubscriptArray = [NSMutableArray new];
    }
    return _addSubscriptArray;
}
//给订阅传递解析网址的tageName
-(NSMutableArray *)tageNameArray{
    if (_tageNameArray == nil) {
        self.tageNameArray = [[NSMutableArray alloc]init];
    }
    return _tageNameArray;
}
//大图片点击是  网上数据路径 数组懒加载
-(NSMutableArray *)webUrlArray{
    if (_webUrlArray == nil) {
        self.webUrlArray = [[NSMutableArray alloc]init];
    }
    return _webUrlArray;
}
//cateName标题数组
-(NSMutableArray *)cateNameArray{
    if (_cateNameArray == nil) {
        self.cateNameArray = [[NSMutableArray alloc]init];
        
    }
    return _cateNameArray;
}
//webAllArray
-(NSMutableArray *)allWebUrlArray{
    if (_webUrlArray == nil) {
        self.webUrlArray = [NSMutableArray new];
    }
    return _webUrlArray;
}
//颜色数组
-(NSMutableArray *)colorArray{
    if (_colorArray == nil) {
        self.colorArray = [NSMutableArray new];
    }
    
    return _colorArray;
}
////点击添加按钮
-(UIButton *)addButton{
    if (_addButton == nil) {
        self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addButton.frame = CGRectMake(328,self.headTableView.frame.size.height-40, 50 , 102);
        //self.addButton.backgroundColor = [UIColor redColor];
        [self.addButton setImage:[UIImage imageNamed:@"addButton2"] forState:UIControlStateNormal];
        
        [self.addButton addTarget:self action:@selector(BarAction:) forControlEvents:UIControlEventTouchUpInside];
        self.addButton.tag = 3;
    }
    return _addButton;
}
#pragma mark ---- 抽屉视图加载

-(UIView *)mainView{
    if (_mainView == nil) {
        self.mainView = [[UIView alloc]initWithFrame:self.view.frame];
    }
    return _mainView;
}

//
-(UIView *)leftView{
    if (_leftView == nil) {
        self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWideth-100, kHeight)];
        _leftVc = [[LeftRevealViewController alloc]init];
        
        //_leftVc.view.frame = self.leftView.bounds;
        
        _leftVc.view.frame = self.leftView.bounds;
        
        _leftVc.leftDelegate = self;
    }
    
    
    
    return _leftView;
}

-(UIView *)rightView{
    if (_rightView == nil) {
        self.rightView = [[UIView alloc]initWithFrame:CGRectMake(kWideth/3, 0, kWideth - 100, kHeight)];
        
        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        
        if (myDelegate.isLogin == NO) {
            _rightVc = [[RightRevealViewController alloc]initWithNibName:@"RightRevealViewController" bundle:nil];
            
            _rightVc.view.frame = self.rightView.bounds;
            _rightVc.rightDelegate = self;
        }else{
            
            _succLoginRightVc = [[SuccessLoginRightViewController alloc]initWithNibName:@"SuccessLoginRightViewController" bundle:nil];
            _succLoginRightVc.view.frame = self.rightView.bounds;
            
            
        }
        
       
        
        
        
        
    }
    return _rightView;
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

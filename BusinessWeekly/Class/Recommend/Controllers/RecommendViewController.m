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
@interface RecommendViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
     NSInteger _pageCount;//定义请求页码
}
@property(nonatomic,strong) PullingRefreshTableView *tableView;
@property(nonatomic,strong) UITableView *headTableView;
@property(nonatomic,assign) BOOL refreshing;
@property(nonatomic,strong) NSArray *articleArray;
@property(nonatomic,strong) NSMutableArray *headTitleArray;
@property(nonatomic,strong) NSMutableArray *numberArray;
@property(nonatomic,strong) NSMutableArray *recomDataArray;
@property(nonatomic,strong) NSMutableArray *bigPictureArray;
@property(nonatomic,strong) NSMutableArray *smalPictureArray;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) NSTimer *timer;//定时器用于图片滚动
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"推荐";

//网络请求数据
    [self heardTitle];
    //多余的tableView内容
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.headTableView];
    [self.view addSubview:self.tableView];
    
    //自定义头部cell
    [self configTableView];

    //网络数据
    [self loadData];
    [self startTimer];
}
#pragma mark ------网络请求解析 获得数据
//解析标题 推荐 金融 科技 特写......
-(void)heardTitle{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];//  text/html
    [sessionManager GET:kHeadTitle parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog(@"%@",responseObject);
        //解析成功
        NSDictionary *resultDic = responseObject;
        self.articleArray = resultDic[@"articletag"];
        for (NSDictionary *dic in self.articleArray) {
            ArticleModel *model = [[ArticleModel alloc]initWithDictionary:dic];
            [self.headTitleArray addObject:model];
        }
        [self.headTableView reloadData];//刷新数据
   
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
}
#pragma mark ------自定义tableView头部
- (void)configTableView{
    UIView *tableHeaderView = [[UIView alloc]init];
    tableHeaderView.frame = CGRectMake(0, 0, kWideth, 240);
    [tableHeaderView addSubview:self.scrollView];
    //圆点个数
    self.pageControl.numberOfPages = self.bigPictureArray.count;
    [tableHeaderView addSubview:self.pageControl];
#pragma mark ---给scrollView 添加图片
    self.scrollView.contentSize = CGSizeMake(self.bigPictureArray.count * kWideth, 240);

    for (int i = 0; i < self.bigPictureArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kWideth * i, 0, kWideth, 240)];
    
        imageView.userInteractionEnabled = YES;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.bigPictureArray[i]] placeholderImage:nil];
        [self.scrollView addSubview:imageView];
        
        
        
        UIButton *touchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        touchButton.frame = imageView.frame;
        touchButton.tag = 200 + i;
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
    if (self.bigPictureArray.count > 0) {
        //当前页数加1
        NSInteger page = self.pageControl.currentPage + 1;
        CGFloat offSex = page % self.bigPictureArray.count;
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
       
        return self.articleArray.count - 14;
    }else if ([tableView isEqual:self.tableView]){
      return 26;
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
        //NSLog(@"%@",self.headTitleArray[indexPath.row]);
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
       
        return cell;

    }else if ([tableView isEqual:self.tableView]){
        static NSString *idenPull = @"idenPullCell";
        UITableViewCell *cellPull = [tableView dequeueReusableCellWithIdentifier:idenPull];
        if (cellPull == nil) {
            cellPull = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:idenPull];
        }
        return cellPull;
    }
    return nil;
    
}
//自定义高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.headTableView]) {
        ArticleModel *model = self.headTitleArray[indexPath.row];
       CGFloat height = [HWTools getTextHeightWithText:model.catname Bigsize:CGSizeMake( 5 ,900) textFont:13.0];
       
        return height + 20;
    }else if ([tableView isEqual:self.tableView]){
        return 40;
    }
    return 40;
    
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.headTableView]) {
        
  
    self.numberArray = [NSMutableArray new];
    ArticleModel *model = self.headTitleArray[indexPath.row];
    
    NSString*string =model.color;
    NSArray *array = [string componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组
    for (int i = 0; i < array.count; i++) {
        NSString *originalString = array[i];
        // Intermediate
        NSMutableString *numberString = [[NSMutableString alloc] init] ;
        NSString *tempStr;
        NSScanner *scanner = [NSScanner scannerWithString:originalString];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        while (![scanner isAtEnd]) {
            // Throw away characters before the first number.
            [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
            // Collect numbers.
            [scanner scanCharactersFromSet:numbers intoString:&tempStr];
            [numberString appendString:tempStr];
            tempStr = @"";
           
        }
        [self.numberArray addObject:numberString];
    }
     //设置选中时tableview的颜色
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGFloat number = [self.numberArray[0] floatValue];
        CGFloat number1 = [self.numberArray[1] floatValue];
        CGFloat number2 = [self.numberArray[2] floatValue];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:number/255.0f green:number1/255.0f blue:number2/255.0f alpha:0.78];
        // [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
      //改变标题
        self.navigationItem.title = model.catname;

    }else if ([tableView isEqual:self.tableView]){
        
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
    [ProgressHUD show:@"推荐加载中"];
    [sessionManager GET:[NSString stringWithFormat:@"%@updatetime=%@",kRecommend,@"1454062401"] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog("%@",responseObject);
        [ProgressHUD showSuccess:@"推荐加载成功"];
        NSDictionary *resultdic = responseObject;
        NSArray *arctiyArray = resultdic[@"articletag"];
        NSDictionary *dic = arctiyArray[0];
        NSArray *dataArray = dic[@"article"];
       // NSArray *thumbArray = dataArray [@"thumb"];
        for (NSDictionary *dataDic in dataArray) {
            RecommModel *recomModel = [[RecommModel alloc]initWithDictionary:dataDic];
            [self.recomDataArray addObject:recomModel];
            NSArray *bigArray = dataDic[@"picture"];
//将大图片添加到数组中
            for (NSDictionary *bigDic in bigArray) {
                [self.bigPictureArray addObject:bigDic[@"url"]];
            }
            NSArray *smalArray = dataDic[@"thumb"];
//将小图片添加到数组中
            for (NSDictionary *smalDic in smalArray) {
                [self.smalPictureArray addObject:smalDic[@"url"]];
            }
        }
        NSLog(@"%ld %ld",self.bigPictureArray.count,self.smalPictureArray.count);

        
        //刷新数据 重新加载该方法configTableView
        [self configTableView];
      

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
        
    }];
    
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
        self.headTableView = [[UITableView alloc]initWithFrame:CGRectMake(200, -80, kWideth - 400, kWideth - 20) style:UITableViewStylePlain];
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
-(NSMutableArray *)headTitleArray{
    if (_headTitleArray == nil) {
        self.headTitleArray = [NSMutableArray new];
    }
    return _headTitleArray;
}
-(NSMutableArray *)bigPictureArray{
    if (_bigPictureArray == nil) {
        self.bigPictureArray = [NSMutableArray new];
    }
    return _bigPictureArray;
}
-(NSMutableArray *)smalPictureArray{
    if (_smalPictureArray == nil) {
        self.smalPictureArray = [NSMutableArray new];
    }
    return _smalPictureArray;
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

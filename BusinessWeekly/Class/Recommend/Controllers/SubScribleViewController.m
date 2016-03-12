//
//  SubScribleViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/2/22.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "SubScribleViewController.h"
#import "RecommModel.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "DingYueTableViewCell.h"
#import "PullingRefreshTableView.h"
#import "DingYueTableViewCell.h"
#import "DetailsViewController.h"
#import "ProgressHUD.h"
@interface SubScribleViewController ()<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>{
   NSInteger _pageCount;//定义请求页码;
}
@property(nonatomic,strong) NSMutableArray *recomDataArray;
@property(nonatomic,strong) NSMutableArray *smalPictureArray;
@property(nonatomic,strong) NSMutableArray *webUrlArray;
@property(nonatomic,strong) PullingRefreshTableView *tableView;
@property(nonatomic,assign) BOOL refreshing;

@end

@implementation SubScribleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.cateNameString;
    [self loadDataAction];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DingYueTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView launchRefreshing];

//自定义导航栏上右边button
    UIButton *dingyueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dingyueButton.frame = CGRectMake(0, 0, 100, 40);
    [dingyueButton setTitle:@"订阅" forState:UIControlStateNormal];
    [dingyueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dingyueButton addTarget:self action:@selector(dingyueAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithCustomView:dingyueButton];
  //  self.navigationItem.rightBarButtonItem = rightButton;
    
}
#pragma mark --- tableView代理方法
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.recomDataArray.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   DingYueTableViewCell *dingyueCell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    RecommModel *model  = self.recomDataArray[indexPath.row];
    
    dingyueCell.recomModel = model;
    dingyueCell.recomModel.url = self.smalPictureArray[indexPath.row];
    return dingyueCell;
}
#pragma mark --- pullingdelagate
//tableview开始算新的时候调用 //下拉
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount = 1;
    self.refreshing = YES;
    // [self loadData];//加载数据
    [self performSelector:@selector(loadDataAction) withObject:nil afterDelay:1.0];
    
}

//上拉  Implement this method if headerOnly is false
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    _pageCount +=1;
    self.refreshing = YES;
    [self performSelector:@selector(loadDataAction) withObject:nil afterDelay:1.f];
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
#pragma mark --- 解析数据
-(void)loadDataAction{
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    [ProgressHUD show:@"加载中....."];
    [sessionManager GET:[NSString stringWithFormat:@"%@%@%@",kRecommend,self.catString,@"/articlelist?updatetime=1454062401"] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [ProgressHUD showSuccess:@"加载完成......"];
        ZJHLog(@"%@",responseObject);
        
        if (self.refreshing) {
            if (self.recomDataArray.count > 0) {
                [self.recomDataArray removeAllObjects];
                [self.smalPictureArray removeAllObjects];
            }
        }
        
        
        NSDictionary *resultdic = responseObject;
        NSArray *arctiyArray = resultdic[@"articletag"];
        NSDictionary *dic = arctiyArray[0];
        NSArray *dataArray = dic[@"article"];
        
        
        for (NSDictionary *dataDic in dataArray) {
            RecommModel *recomModel = [[RecommModel alloc]initWithDictionary:dataDic];
            [self.recomDataArray addObject:recomModel];
            
            NSArray *smalArray = dataDic[@"thumb"];
    //将小图片添加到数组中
            for (NSDictionary *smalDic in smalArray) {
                recomModel.url = smalDic[@"url"];
                [self.smalPictureArray addObject:smalDic[@"url"]];
            }
            
            NSArray *phoneArray = dataDic[@"phonepagelist"];
      //将webUrl的地址
            for (NSDictionary *phoneDic in phoneArray) {
                recomModel.webUrl = phoneDic[@"url"];
                [self.webUrlArray addObject:phoneDic[@"url"]];
                
                
                
            }
            
            
        }
        
        [self.tableView tableViewDidFinishedLoading];//完成加载
        self.tableView.reachedTheEnd = NO;
        //刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *detailCell = [[DetailsViewController alloc]init];
    RecommModel *model = self.recomDataArray[indexPath.row];
    
    detailCell.htmlString = self.webUrlArray[indexPath.row];
    [self.navigationController pushViewController:detailCell animated:nil];
    
}
//点击订阅触发事件
-(void)dingyueAction{
    NSLog(@"订阅触发事件");
}
#pragma mark ----- 懒加载
//懒加载
//数据
-(NSMutableArray *)recomDataArray{
    if (_recomDataArray == nil) {
        self.recomDataArray = [NSMutableArray new];
    }
    return _recomDataArray;
}
//小图片
-(NSMutableArray *)smalPictureArray{
    if (_smalPictureArray == nil) {
        self.smalPictureArray = [NSMutableArray new];
    }
    return _smalPictureArray;
}
//tableView
-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0,60, kWideth, kHeight - 64) pullingDelegate:self];
        //设置代理
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        self.tableView.rowHeight = 107;
        
    }
    return _tableView;
}
-(NSMutableArray *)webUrlArray{
    if (_webUrlArray == nil) {
        self.webUrlArray = [NSMutableArray new];
    }
    return _webUrlArray;
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

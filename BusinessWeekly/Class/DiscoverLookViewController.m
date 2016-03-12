//
//  DiscoverLookViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/9.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "DiscoverLookViewController.h"
#import "PullingRefreshTableView.h"
#import "DiscoverTableViewCell.h"
#import <AFHTTPSessionManager.h>
#import "DiscoverModel.h"
#import "DiscUserModel.h"
#import "MJRefresh.h"
#import "DetailsDiscoverViewController.h"
#import "LoginViewController.h"
@interface DiscoverLookViewController ()<PullingRefreshTableViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSInteger _pageCount;//定义请求页码;
    AppDelegate *_myAppdelegate;
}
@property(nonatomic,strong) PullingRefreshTableView *tableView;
@property(nonatomic,assign) BOOL refreshing;
@property(nonatomic,strong) NSMutableArray *cardArray;
@property(nonatomic,strong) NSMutableArray *userArray;

@property(nonatomic,strong) NSString *data;

@end

@implementation DiscoverLookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DiscoverTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _myAppdelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
   // myAppdelegate.isLogin = NO;
    if (_myAppdelegate.isLogin) {
       
         self.data = succLoginDiscoverData;
       
        
    }else{
        self.data = discoverData;
     
        
    }
    
    [self loadDataAction];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = left;

}
-(void)viewWillAppear:(BOOL)animated{
    if (_myAppdelegate.isLogin == NO) {
         self.navigationController.title = @"浏览发现";
        
    }else{
         self.navigationController.title = @"我的首页";
    }
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cardArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DiscoverTableViewCell *discoverCell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    discoverCell.discoverModel = self.cardArray[indexPath.row];
   
    for (int i = 0; i <= indexPath.row; i++) {
        for (int j = 0; j < self.userArray.count; j++) {
            
            DiscoverModel *model = self.cardArray[i];
            DiscUserModel *userModel = self.userArray[j];
            
            NSString *userId = model.uid;
            NSString *userId2 = userModel.uid;
            
           
            if ([userId isEqualToString:userId2]) {
                discoverCell.userModel = self.userArray[j];
                break;
            }
        }
    }
    
    
    
    return discoverCell;
}
//点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_myAppdelegate.isLogin == NO) {
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        [self presentViewController:loginVc animated:YES completion:nil];
    }else{
        DetailsDiscoverViewController *detailVc = [[DetailsDiscoverViewController alloc]init];
        DiscoverModel *model = self.cardArray[indexPath.row];
        detailVc.timeString = model.time;
        detailVc.contentString = model.contents;
        detailVc.idString = model.timelineid;
        for (int i = 0; i < self.userArray.count; i++) {
            DiscUserModel *userModel = self.userArray[i];
            if ([model.uid isEqualToString:userModel.uid]) {
                detailVc.nameString = userModel.nickname;
                detailVc.imageString = userModel.avatar;
                break;
            }
        }
        
        [self.navigationController pushViewController:detailVc animated:YES];
    }
    
    
    
}
//自定义高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
#pragma mark --- 解析
-(void)loadDataAction{
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]init];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [sessionManager GET:self.data parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        ZJHLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZJHLog(@"%@",responseObject);
        
        NSDictionary *rootDic = responseObject;
        NSArray *cardArray = rootDic[@"card"];
        if (self.refreshing == NO) {
            if (self.cardArray.count > 0) {
                [self.cardArray removeAllObjects];
                [self.userArray removeAllObjects];
            }
        }
        
        for (NSDictionary *dic in cardArray) {
            DiscoverModel *model = [[DiscoverModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.cardArray addObject:model];
        }
        
        NSDictionary *userList = rootDic[@"userList"];
        NSArray *userArray = userList[@"user"];
        for (NSDictionary *userDic in userArray) {
            DiscUserModel *model = [[DiscUserModel alloc]init];
            [model setValuesForKeysWithDictionary:userDic];
            [self.userArray addObject:model];
            
        }
        
        
        
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ZJHLog(@"%@",error);
    }];
    
}

#pragma mark ---- pull代理方法
#pragma mark --- pullingdelagate
//tableview开始算新的时候调用 //下拉
-(void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    _pageCount = 1;
    self.refreshing =YES;
    // [self loadData];//加载数据
    [self performSelector:@selector(loadDataAction) withObject:nil afterDelay:1.0];
    
}

//上拉  Implement this method if headerOnly is false
//- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
////    _pageCount +=1;
////    self.refreshing = NO;
////    [self performSelector:@selector(loadDataAction) withObject:nil afterDelay:1.f];
//    
//}

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

#pragma mark --- 懒加载

-(PullingRefreshTableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[PullingRefreshTableView alloc]initWithFrame:CGRectMake(0, 10, kWideth, kHeight) pullingDelegate:self];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
    }
    return _tableView;
}
//内容数组
-(NSMutableArray *)cardArray{
    if (_cardArray == nil) {
        self.cardArray = [NSMutableArray new];
    }
    return _cardArray;
}
//用户信息
-(NSMutableArray *)userArray{
    if (_userArray == nil) {
        self.userArray = [NSMutableArray new];
    }
    return _userArray;
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

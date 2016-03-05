//
//  LeftRevealViewController.m
//  BusinessWeekly
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 scjy. All rights reserved.
//

#import "LeftRevealViewController.h"
#import "LeftRevealTableViewCell.h"
@interface LeftRevealViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *number;

@end

@implementation LeftRevealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kWideth/6, kWideth, 140)];
    imageView.image = [UIImage imageNamed:@"bloo"];
    [self.view addSubview:imageView];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LeftRevealTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    NSLog(@"%@",self.titleArray);
    NSLog(@"进来标题数组个数%ld",self.titleArray.count);

}
#pragma mark --- 代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count - 14;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LeftRevealTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.titleNameLabel.text = self.titleArray[indexPath.row];
    
    self.number = [HWTools arrayWithString:self.leftColorArray[indexPath.row]];
    
    CGFloat num1 = [self.number [0]floatValue];
    CGFloat num2 = [self.number [1]floatValue];
    CGFloat num3 = [self.number [2]floatValue];
    cell.colorImageView.backgroundColor = [UIColor colorWithRed:num1/255.0f green:num2/255.0f blue:num3/255.0f alpha:0.78];
    
    
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.leftColorArray[indexPath.row]);
}
//懒加载
-(UITableView *)tableView{
    if (_tableView == nil) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWideth/6 + 140, kWideth, kHeight) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    return _tableView;
}
-(NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        self.titleArray = [NSMutableArray new];
    }
    return _titleArray;
}
-(NSMutableArray *)leftColorArray{
    if (_leftColorArray == nil) {
        self.leftColorArray = [NSMutableArray new];
    }
    return _leftColorArray;
}
-(NSArray *)number{
    if (_number == nil) {
        self.number = [NSArray new];
    }
    return _number;
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

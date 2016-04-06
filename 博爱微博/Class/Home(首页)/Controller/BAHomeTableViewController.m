//
//  BAHomeTableViewController.m
//  博爱微博
//
//  Created by 孙博岩 on 15/8/1.
//  Copyright © 2015年 boai. All rights reserved.
//

#import "BAHomeTableViewController.h"

#import "UIBarButtonItem+Item.h"
#import "BATitleButton.h"

#import "BAPopMenu.h"
#import "BACover.h"
#import "BAOneTableViewController.h"

#import "BAAccountTool.h"
#import "BAAccount.h"

#import "BAStatus.h"
#import "BAUser.h"

#import "MJExtension.h"
#import "UIImageView+WebCache.h"

#import "MJRefresh.h"

#import "BAHttpTool.h"
#import "BAStatusTool.h"

#import "BAUserTool.h"
#import "BAAccountTool.h"

#import "BAStatusCell.h"

#import "BAStatusFrame.h"

@interface BAHomeTableViewController () <BACoverDelegate>

@property (nonatomic, weak) BATitleButton *titleButton;

@property (nonatomic, strong) BAOneTableViewController *one;

/**
 *  viewModel:BAStatusFrame
 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation BAHomeTableViewController


- (NSMutableArray *)statusFrames
{
    if (!_statusFrames)
    {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (BAOneTableViewController *)one
{
    if (_one == nil)
    {
        _one = [[BAOneTableViewController alloc] init];
    }
    
    return _one;
}

// UIBarButtonItem:决定导航条上按钮的内容
// UINavigationItem:决定导航条上内容
// UITabBarItem:决定tabBar上按钮的内容
// ios7之后，会把tabBar上和导航条上的按钮渲染
// 导航条上自定义按钮的位置是由系统决定，尺寸才需要自己设置。

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadMoreStatus];

}
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 设置导航条内容
    [self setUpNavigationBar];
    
    // 添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    // 添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    
    // 一开始展示之前的微博名称，然后在发送用户信息请求，直接赋值
    
    // 请求当前用户的昵称
    [BAUserTool userInfoWithSuccess:^(BAUser *user) {
        
        // 请求当前账号的用户信息
        // 设置导航条的标题
        [self.titleButton setTitle:user.name forState:UIControlStateNormal];
        // 获取当前的账号
        BAAccount *account = [BAAccountTool account];
        account.name = user.name;
        
        // 保存用户的名称
        [BAAccountTool saveAccount:account];
        
    
    } failure:^(NSError *error) {
        
    }];
    self.tableView.rowHeight = 100;
}

#pragma mark - 刷新最新的微博
- (void)refresh
{
    // 自动下拉刷新
    [self.tableView headerBeginRefreshing];
}

#pragma mark - 请求更多旧的微博
- (void)loadMoreStatus
{
    NSString *maxIdStr = nil;
    if (self.statusFrames.count) { // 有微博数据，才需要下拉刷新
        BAStatus *s = [self.statusFrames[0] status];
        long long maxId = [s.idstr longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld",maxId];
    }
    
    // 请求更多的微博数据
    [BAStatusTool moreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        
        // 结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        // 模型转换视图模型 CZStatus -> CZStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (BAStatus *status in statuses) {
            BAStatusFrame *statusF = [[BAStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        // 把数组中的元素添加进去
        [self.statusFrames addObjectsFromArray:statusFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
    
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 请求最新的微博
- (void)loadNewStatus
{
    NSString *sinceId = nil;
    if (self.statusFrames.count) { // 有微博数据，才需要下拉刷新
        BAStatus *s = [self.statusFrames[0] status];
        sinceId = s.idstr;
    }
    
    [BAStatusTool newStatusWithSinceId:sinceId success:^(NSArray *statuses) { // 请求成功的Block
        
        // 展示最新的微博数
        [self showNewStatusCount:statuses.count];
        
        // 结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        // 模型转换视图模型 CZStatus -> CZStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (BAStatus *status in statuses) {
            BAStatusFrame *statusF = [[BAStatusFrame alloc] init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        // 把最新的微博数插入到最前面
        [self.statusFrames insertObjects:statusFrames atIndexes:indexSet];
        
        // 刷新表格
        [self.tableView reloadData];

    
    } failure:^(NSError *error) {
        
    }];
    

    
//    // 创建请求管理者
//    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
//
//    // 创建参数字典
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    if (self.statuses.count)
//    {
//        // 有微博数据，才需要下拉刷新
//        params[@"since_id"] = [self.statuses[0] idstr];
//    }
//
//    params[@"access_token"] = [BAAccountTool account].access_token;
//    
//    // 发送 get 请求
//    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        // 请求成功时调用
//        
//         // 结束下拉刷新
//        [self.tableView headerEndRefreshing];
//        
//        // 获取到微博数据 转换成模型
//        // 获取微博字典数组
//        NSArray *dictArr = responseObject[@"statuses"];
//        
//        // 把字典数组转换成模型数组
//        self.statuses = (NSMutableArray *)[BAStatus objectArrayWithKeyValuesArray:dictArr];
//        
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, _statuses.count)];
//        // 把最新的微博数插入到最前面
//        [self.statuses insertObjects:_statuses atIndexes:indexSet];
//        
//        // 刷新表格
//        [self.tableView reloadData];
//        
////        NSLog(@"%@", self.statuses);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
}

#pragma mark - 展示最新的微博数

- (void)showNewStatusCount:(int)count
{
    if (count == 0) return;
//    展示最新的微博数
    
    CGFloat h = 35;
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    CGFloat w = self.view.width;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.text = [NSString stringWithFormat:@"最新的微博数：%d", count];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
//    [self.view addSubview:label];
    
    // 插入到导航控制器下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 动画平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
        
    } completion:^(BOOL finished) {
        // 往上平移
        [UIView animateKeyframesWithDuration:0.25 delay:2 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            
            // 还原
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}


#pragma mark - 设置导航条
- (void)setUpNavigationBar
{
    // 左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearch) forControlEvents:UIControlEventTouchUpInside] ;
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    
    // titleView
    BATitleButton *titleButton = [BATitleButton buttonWithType:UIButtonTypeCustom];
    _titleButton = titleButton;
    
    NSLog(@"%@", [BAAccountTool account].name);
    NSString *title = [BAAccountTool account].name?:@"首页";
    [titleButton setTitle:title forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    
    // 高亮的时候不需要调整图片
    titleButton.adjustsImageWhenHighlighted = NO;
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
}

// 以后只要显示在最前面的控件，一般都加在主窗口
// 点击标题按钮
- (void)titleClick:(UIButton *)button
{
    button.selected = !button.selected;
    
    // 弹出蒙板
    BACover *cover = [BACover show];
    cover.delegate = self;
    
    
    // 弹出pop菜单
    CGFloat popW = 200;
    CGFloat popX = (self.view.width - 200) * 0.5;
    CGFloat popH = popW;
    CGFloat popY = 55;
    BAPopMenu *menu = [BAPopMenu showInRect:CGRectMake(popX, popY, popW, popH)];
    menu.contentView = self.one.view;
    
    
}

// 点击蒙板的时候调用
- (void)coverDidClickCover:(BACover *)cover
{
    // 隐藏pop菜单
    [BAPopMenu hide];
    
    _titleButton.selected = NO;
    
}


- (void)friendSearch
{
    //    NSLog(@"%s",__func__);
}

- (void)pop
{
//    // 创建one 控制器
//    BAOneTableViewController *oneVC = [[BAOneTableViewController alloc] initWithNibName:nil bundle:nil];
//    
//    // 当push的时候隐藏底部导航条
//    oneVC.hidesBottomBarWhenPushed = YES;
//    
//    // 跳转到另一个控制器
//    [self.navigationController pushViewController:oneVC animated:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建cell
    BAStatusCell *cell = [BAStatusCell cellWithTableView:tableView];
    
    // 获取status模型
    BAStatusFrame *statusF = self.statusFrames[indexPath.row];
    
    // 给cell传递模型
    cell.statusF = statusF;
    
//    // 用户昵称
//    cell.textLabel.text = status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;
//
//    
//    NSLog(@"%s", __func__);
    return cell;
}

// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取status模型
    BAStatusFrame *statusF = self.statusFrames[indexPath.row];
    
    return statusF.cellHeight;
}




@end

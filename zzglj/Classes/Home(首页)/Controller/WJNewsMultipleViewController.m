//
//  WJNewsMultipleViewController.m
//  zzglj
//
//  Created by allen on 2017/4/21.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import "WJNewsMultipleViewController.h"
#import "WJLoadMoreFooter.h"
#import "WJNews.h"
#import "WJNewsViewCell.h"
#import "WJWebViewController.h"
#import "WJNewsParam.h"
#import "WJNewsReturn.h"
#import "WJNewsTools.h"
#import "SCHttpClient.h"
#import "MJExtension.h"
#import "WJNewsViewCell2.h"

@interface WJNewsMultipleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (weak, nonatomic) IBOutlet UITableView *tableViewLeft;
@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewRight;

/**
 *  新闻数组
 */
@property (nonatomic, strong) NSMutableArray *arrayNewsLeft;
/**
 *  上拉时tableView的刷新控件
 */
@property (nonatomic, weak) UIRefreshControl *refreshControlLeft;
/**
 *  下拉加载更多时的刷新控件
 */
@property (nonatomic, weak) WJLoadMoreFooter *footerLeft;
/**
 *  新闻数组
 */
@property (nonatomic, strong) NSMutableArray *arrayNewsRight;
/**
 *  上拉时tableView的刷新控件
 */
@property (nonatomic, weak) UIRefreshControl *refreshControlRight;
/**
 *  下拉加载更多时的刷新控件
 */
@property (nonatomic, weak) WJLoadMoreFooter *footerRight;

/**
 *  是否已经加载右边页签数据
 */
@property (nonatomic, assign) BOOL bLoadRight;

@end

@implementation WJNewsMultipleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSegment];
    
    [self setupTableView];
    
    [self setupRefresh];
}

- (void)setupSegment
{
    for (int i = 0; i<self.arraySegmentTitle.count; i++)  {
        [self.segmentControl setTitle:[self.arraySegmentTitle objectAtIndex:i] forSegmentAtIndex:i];
    }
    UIFont *font = [UIFont systemFontOfSize:15.0f];
    //NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
    //                                                       forKey:UITextAttributeFont];
    //[self.segmentControl setTitleTextAttributes:attributes
    //                                   forState:UIControlStateNormal];
    //[self.segmentControl setTitleTextAttributes:attributes
    //                                   forState:UIControlStateSelected];
    [self.segmentControl setTintColor:[UIColor whiteColor]];
    //设置选中页签字体
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor],UITextAttributeTextColor,font,UITextAttributeFont,nil];
    [self.segmentControl setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    NSDictionary *dics = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor],UITextAttributeTextColor,font,UITextAttributeFont,nil];
    [self.segmentControl setTitleTextAttributes:dics forState:UIControlStateNormal];
    
    [self.segmentControl addTarget:self action:@selector(segmentIndexDidChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentIndexDidChange:(UISegmentedControl *)segmentControl{
    
    NSInteger index = [segmentControl  selectedSegmentIndex];
    
    NSLog(@"text:%@",[segmentControl titleForSegmentAtIndex:index]);
    
    switch ([segmentControl  selectedSegmentIndex]) {
            
        case 0:
            
            self.tableViewLeft.hidden=NO;
            
            self.tableViewRight.hidden=YES;
            
            self.segmentControl.selectedSegmentIndex=0;
            
            //self.tag = 0;
            
            //[self.tableViewLeft reloadData];
            
            break;
            
        case 1:
            
            self.tableViewLeft.hidden=YES;
            
            self.tableViewRight.hidden=NO;
            
            self.segmentControl.selectedSegmentIndex=1;
            
            //self.tag = 1;
            
            //[self.tableViewRight reloadData];
            if (!self.bLoadRight) {
                self.bLoadRight = YES;
                // 让刷新控件自动进入刷新状态
                [self.refreshControlRight beginRefreshing];
                
                // 加载数据
                [self refreshControlStateChange:self.refreshControlRight];
            }
            
            break;
            
        default:
            
            NSLog(@"segmentActionDefault");
            
            break;
            
    }
    
}

- (void)setupTableView
{
    UIView *tableHeadView = [[UIView alloc] init];
    tableHeadView.backgroundColor = [UIColor clearColor];
    tableHeadView.x = 0;
    tableHeadView.y = 0;
    tableHeadView.width = self.tableViewLeft.width;
    tableHeadView.height = 10;
    self.tableViewLeft.tableHeaderView = tableHeadView;
    self.tableViewLeft.backgroundColor = WJGlobalBg;
    self.tableViewLeft.delegate = self;
    self.tableViewLeft.dataSource = self;
    
    
    UIView *tableHeadView2 = [[UIView alloc] init];
    tableHeadView2.backgroundColor = [UIColor clearColor];
    tableHeadView2.x = 0;
    tableHeadView2.y = 0;
    tableHeadView2.width = self.tableViewLeft.width;
    tableHeadView2.height = 10;
    self.tableViewRight.tableHeaderView = tableHeadView2;
    self.tableViewRight.backgroundColor = WJGlobalBg;
    self.tableViewRight.delegate = self;
    self.tableViewRight.dataSource = self;
}

- (NSMutableArray *)arrayNewsLeft
{
    if (_arrayNewsLeft == nil) {
        _arrayNewsLeft = [NSMutableArray array];
    }
    return _arrayNewsLeft;
}

- (NSMutableArray *)arrayNewsRight
{
    if (_arrayNewsRight == nil) {
        _arrayNewsRight = [NSMutableArray array];
    }
    return _arrayNewsRight;
}
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.添加下拉刷新控件
    UIRefreshControl *refreshControlLeft = [[UIRefreshControl alloc] init];
    [self.tableViewLeft addSubview:refreshControlLeft];
    self.refreshControlLeft = refreshControlLeft;
    
    // 2.监听状态
    [refreshControlLeft addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 3.让刷新控件自动进入刷新状态
    [refreshControlLeft beginRefreshing];
    
    // 4.加载数据
    [self refreshControlStateChange:refreshControlLeft];
    
    // 5.添加上拉加载更多控件
    WJLoadMoreFooter *footerLeft = [WJLoadMoreFooter footer];
    self.tableViewLeft.tableFooterView = footerLeft;
    self.footerLeft = footerLeft;
    
    // 1.添加下拉刷新控件
    UIRefreshControl *refreshControlRight = [[UIRefreshControl alloc] init];
    [self.tableViewRight addSubview:refreshControlRight];
    self.refreshControlRight = refreshControlRight;
    
    // 2.监听状态
    [refreshControlRight addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    // 3.让刷新控件自动进入刷新状态
    //[refreshControlRight beginRefreshing];
    
    // 4.加载数据
    //[self refreshControlStateChange:refreshControlRight];
    
    // 5.添加上拉加载更多控件
    WJLoadMoreFooter *footerRight = [WJLoadMoreFooter footer];
    self.tableViewRight.tableFooterView = footerRight;
    self.footerRight = footerRight;
    
}

/**
 *  当下拉刷新控件进入刷新状态（转圈圈）的时候会自动调用
 */
- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl
{
    [self loadNewStatuses:refreshControl];
}


/**
 *  加载最新的微博数据
 */
- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
{
    // 1.封装请求参数
    WJNewsParam *param = [WJNewsParam param];
    param.lmid = self.lmid;
    param.lmid1 =self.arrayLmid1[self.segmentControl.selectedSegmentIndex];// self.lmid1;
    if (self.segmentControl.selectedSegmentIndex == 0) {
        WJNews *news = [self.arrayNewsLeft firstObject];
        if (news) {
            //        param.str =[NSString stringWithFormat: @" and datediff(day,indate,'%@')<0",news.Indate];
            param.minid = news.ID;
        }
    }
    else
    {
        WJNews *news = [self.arrayNewsRight firstObject];
        if (news) {
            //        param.str =[NSString stringWithFormat: @" and datediff(day,indate,'%@')<0",news.Indate];
            param.minid = news.ID;
        }
    }
    
    // 2.加载新闻列表
    [WJNewsTools newsWithParam:param success:^(WJNewsReturn *result) {
        // 获得最新的新闻News数组
        NSArray *newss = result.Details;
        
        // 将新数据插入到旧数据的最前面
        NSRange range = NSMakeRange(0, newss.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        if (self.segmentControl.selectedSegmentIndex == 0) {
            [self.arrayNewsLeft insertObjects:newss atIndexes:indexSet];
            // 重新刷新表格
            [self.tableViewLeft reloadData];
        }
        else
        {
            [self.arrayNewsRight insertObjects:newss atIndexes:indexSet];
            // 重新刷新表格
            [self.tableViewRight reloadData];
        }
        
        
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
        
        // 提示用户最新的新闻数量
        [self showNewStatusesCount:newss.count];
    } failure:^(NSError *error) {
        WJLog(@"请求失败--%@", error);
        // 让刷新控件停止刷新（恢复默认的状态）
        [refreshControl endRefreshing];
    }];
}

/**
 *  提示用户最新的微博数量
 *
 *  @param count 最新的微博数量
 */
- (void)showNewStatusesCount:(int)count
{
    //    // 0.清零提醒数字
    //    [UIApplication sharedApplication].applicationIconBadgeNumber -= self.tabBarItem.badgeValue.intValue;
    //    self.tabBarItem.badgeValue = nil;
    
    // 1.创建一个UILabel
    UILabel *label = [[UILabel alloc] init];
    
    // 2.显示文字
    if (count) {
        label.text = [NSString stringWithFormat:@"共有%d条新的数据", count];
    } else {
        label.text = @"没有最新的数据";
    }
    
    // 3.设置背景
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    // 4.设置frame
    label.width =self.view.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    // 5.添加到导航控制器的view
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    // 6.动画
    CGFloat duration = 0.75;
    [UIView animateWithDuration:duration animations:^{
        // 往下移动一个label的高度
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) { // 向下移动完毕
        
        // 延迟delay秒后，再执行动画
        CGFloat delay = 1.0;
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            // 恢复到原来的位置
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
            // 删除控件
            [label removeFromSuperview];
        }];
    }];
}


//- (void)loadNewStatuses:(UIRefreshControl *)refreshControl
//{
//    SCHttpClient *client=[SCHttpClient new];
//    [client postRequestWithPhoneNumber:@""];
//}


/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatuses
{
    // 1.封装请求参数
    WJNewsParam *param = [WJNewsParam param];
    param.lmid = self.lmid;
    param.lmid1 =self.arrayLmid1[self.segmentControl.selectedSegmentIndex]; // self.lmid1;
    if(self.segmentControl.selectedSegmentIndex == 0)
    {
        WJNews *lastNews = [self.arrayNewsLeft lastObject];
        if (lastNews) {
            //        param.str =[NSString stringWithFormat: @" and datediff(day,indate,'%@')>0",lastNews.Indate];
            param.maxid = lastNews.ID;
        }
    }
    else
    {
        WJNews *lastNews = [self.arrayNewsRight lastObject];
        if (lastNews) {
            //        param.str =[NSString stringWithFormat: @" and datediff(day,indate,'%@')>0",lastNews.Indate];
            param.maxid = lastNews.ID;
        }
    }
    
    // 2.加载新闻数据
    [WJNewsTools newsWithParam:param success:^(WJNewsReturn *result) {
        // 获得最新的新闻News数组
        NSArray *newss = result.Details;
        if (self.segmentControl.selectedSegmentIndex == 0) {
            // 将新数据插入到旧数据的最后面
            [self.arrayNewsLeft addObjectsFromArray:newss];
            
            // 重新刷新表格
            [self.tableViewLeft reloadData];
            // 让刷新控件停止刷新（恢复默认的状态）
            [self.footerLeft endRefreshing];
        }
        else
        {
            // 将新数据插入到旧数据的最后面
            [self.arrayNewsRight addObjectsFromArray:newss];
            
            // 重新刷新表格
            [self.tableViewRight reloadData];
            // 让刷新控件停止刷新（恢复默认的状态）
            [self.footerRight endRefreshing];
        }
        
    } failure:^(NSError *error) {
        WJLog(@"请求失败--%@", error);
        // 让刷新控件停止刷新（恢复默认的状态）
        if(self.segmentControl.selectedSegmentIndex == 0)
        {
            [self.footerLeft endRefreshing];
        }
        else
        {
            [self.footerRight endRefreshing];
        }
        
    }];
}



#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.segmentControl.selectedSegmentIndex == 0)
        return self.arrayNewsLeft.count;
    else
        return self.arrayNewsRight.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.segmentControl.selectedSegmentIndex == 0)
    {
        WJNewsViewCell *cell = [WJNewsViewCell cellWithTableView:tableView];
        cell.news = self.arrayNewsLeft[indexPath.row];
        //[cell setIndexPath:indexPath rowsInSection: self.arrayNews.count];
        return cell;
    }
    else
    {
        WJNewsViewCell2 *cell = [WJNewsViewCell2 cellWithTableView:tableView];
        cell.news = self.arrayNewsRight[indexPath.row];
        //[cell setIndexPath:indexPath rowsInSection: self.arrayNews.count];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WJNews *news = self.arrayNewsLeft[indexPath.row];
    WJWebViewController *webVC = [[WJWebViewController alloc] init];
    webVC.strUrl = news.realRedirectUrl;
    webVC.title = news.FTitle;
    webVC.bNavigationController = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.segmentControl.selectedSegmentIndex == 0)
    {
        if (self.arrayNewsLeft.count <= 0 || self.footerLeft.isRefreshing) return;
        
        // 1.差距
        CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
        // 刚好能完整看到footer的高度
        CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
        
        // 2.如果能看见整个footer
        if (delta <= (sawFooterH - 0)) {
            // 进入上拉刷新状态
            [self.footerLeft beginRefreshing];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 加载更多的微博数据
                [self loadMoreStatuses];
            });
        }
    }
    else
    {
        if (self.arrayNewsRight.count <= 0 || self.footerRight.isRefreshing) return;
        
        // 1.差距
        CGFloat delta = scrollView.contentSize.height - scrollView.contentOffset.y;
        // 刚好能完整看到footer的高度
        CGFloat sawFooterH = self.view.height - self.tabBarController.tabBar.height;
        
        // 2.如果能看见整个footer
        if (delta <= (sawFooterH - 0)) {
            // 进入上拉刷新状态
            [self.footerRight beginRefreshing];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 加载更多的微博数据
                [self loadMoreStatuses];
            });
        }
    }
}

@end

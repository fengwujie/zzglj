//
//  WJHomeViewController2.m
//  zzglj
//
//  Created by allen on 2017/4/6.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import "WJHomeViewController2.h"
#import "ImagePlayerView.h"
#import "WJSysTool.h"
#import "WJRollImage.h"
#import "WJRollImageReturn.h"
#import "WJRollImageParam.h"
#import "WJRollImageTool.h"
#import "WJWebViewController.h"
#import "WJNewsSingleViewController.h"

@interface WJHomeViewController2 ()<ImagePlayerViewDelegate>
@property (weak, nonatomic) IBOutlet ImagePlayerView *imagePlayerView;


@property (nonatomic, strong) NSMutableArray *imageURLs;
@property (nonatomic, strong) NSCache *imageCache;

@property (weak, nonatomic) IBOutlet UIView *gljgk;
@property (weak, nonatomic) IBOutlet UIView *dasgk;
@property (weak, nonatomic) IBOutlet UIView *dacx;
@property (weak, nonatomic) IBOutlet UIView *wxda;
@property (weak, nonatomic) IBOutlet UIView *flfg;
@property (weak, nonatomic) IBOutlet UIView *sxda;
@property (weak, nonatomic) IBOutlet UIView *dazt;


@property (nonatomic, strong) NSArray *arrayRollImages;
@end

@implementation WJHomeViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WJGlobalBg;
    UIButton *titleView = [[UIButton alloc] init];
    titleView.width=400;
    titleView.height=44;
    [titleView setTitle:@"漳州市公路局" forState:UIControlStateNormal];
    [titleView.titleLabel setFont:[WJSysTool navigationTitleFont]];
    [titleView setImage:[UIImage imageNamed:@"glj_logo32"] forState:UIControlStateNormal];
    [titleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleView setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [titleView setUserInteractionEnabled:NO];
    self.navigationItem.titleView = titleView;
    
    [self loadRollImage];
    //[self setupImagePlayerView];
    
    [self setupUIView];
}

- (void)setupUIView
{
    UITapGestureRecognizer*tapGesture1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gljgkClick:)];
    [self.gljgk addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer*tapGesture2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dasgkClick:)];
    [self.dasgk addGestureRecognizer:tapGesture2];
    
    
    UITapGestureRecognizer*tapGesture3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dacxClick:)];
    [self.dacx addGestureRecognizer:tapGesture3];
    
    UITapGestureRecognizer*tapGesture4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wxdaClick:)];
    [self.wxda addGestureRecognizer:tapGesture4];
    
    UITapGestureRecognizer*tapGesture5 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flfgClick:)];
    [self.flfg addGestureRecognizer:tapGesture5];
    
    UITapGestureRecognizer*tapGesture6 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sxdaClick:)];
    [self.sxda addGestureRecognizer:tapGesture6];
    
    UITapGestureRecognizer*tapGesture7 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(daztClick:)];
    [self.dazt addGestureRecognizer:tapGesture7];
}

-(void)gljgkClick:(id)sender
{
    WJLog(@"gljgk");
    WJNewsSingleViewController *newsVC = [[WJNewsSingleViewController alloc] init];
    newsVC.lmid = @1;
    newsVC.lmid1 = @5;
    newsVC.title = @"公路局概况";
    [self.navigationController pushViewController:newsVC animated:YES];
}
-(void)dasgkClick:(id)sender
{
    WJLog(@"dasgk");
    WJWebViewController *webVC = [[WJWebViewController alloc] init];
    webVC.strUrl = WJUrlDASGK;
    webVC.title = @"档案室概况";
    [self.navigationController pushViewController:webVC animated:YES];
}
-(void)dacxClick:(id)sender
{
    WJLog(@"dacx");
    WJWebViewController *webVC = [[WJWebViewController alloc] init];
    webVC.strUrl = WJUrlDACX;
    webVC.title = @"档案查询";
    [self.navigationController pushViewController:webVC animated:YES];
}
-(void)wxdaClick:(id)sender
{
    WJLog(@"wxda");
}
-(void)flfgClick:(id)sender
{
    WJLog(@"flfg");
}
-(void)sxdaClick:(id)sender
{
    WJLog(@"sxda");
}
-(void)daztClick:(id)sender
{
    WJLog(@"dazt");
}

- (void)setupImagePlayerView
{
    _imageCache = [NSCache new];
    
//    self.imageURLs = @[[NSURL URLWithString:@"http://42.96.167.141:8012/App/YJfile/yjattached/image/20170310/20170310172355_2228.jpg"],
//                       [NSURL URLWithString:@"http://42.96.167.141:8012/App/YJfile/yjattached/image/20170310/20170310172252_8454.jpg"],
//                       [NSURL URLWithString:@"http://42.96.167.141:8012/App/YJfile/yjattached/image/20170310/20170310172140_4989.jpg"],
//                       [NSURL URLWithString:@"http://42.96.167.141:8012/App/YJfile/yjattached/image/20170310/20170310172054_4658.jpg"],
//                       [NSURL URLWithString:@"http://42.96.167.141:8012/App/YJfile/yjattached/image/20170310/20170310171954_6510.jpg"]];
    
    self.imagePlayerView.imagePlayerViewDelegate = self;
    
    // set auto scroll interval to x seconds
    self.imagePlayerView.scrollInterval = 1.0f;
    
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
    
    // endless scroll
    self.imagePlayerView.endlessScroll = YES;
    
    // adjust edgeInset
    self.imagePlayerView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self.imagePlayerView reloadData];
}
#pragma mark - 初始化
- (NSMutableArray *)imageURLs
{
    if (_imageURLs == nil) {
        _imageURLs = [NSMutableArray array];
    }
    return _imageURLs;
}
/**
 *  加载最新的微博数据
 */
- (void)loadRollImage
{
    // 1.封装请求参数
    WJRollImageParam *param = [WJRollImageParam param];
    //param.lmid = self.lmid;
    param.lmid = @257;
    // 2.加载新闻列表
    [WJRollImageTool rollImageWithParam:param success:^(WJRollImageReturn *result) {
        // 获得最新的新闻News数组
        _arrayRollImages = result.Details;
        for (WJRollImage *rollimage in _arrayRollImages) {
            WJLog(@"%@", rollimage.AdPath );
            NSString *path =[NSString stringWithFormat:@"http://42.96.167.141:8012%@",rollimage.AdPath];
            [self.imageURLs addObject:[NSURL URLWithString:path]];
            [self setupImagePlayerView];
        }
    } failure:^(NSError *error) {
        WJLog(@"请求失败--%@", error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ImagePlayerViewDelegate
- (NSInteger)numberOfItems
{
    return self.imageURLs.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    // recommend to use SDWebImage lib to load web image
    //    [imageView setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:nil];
    if(self.imageURLs.count > 0)
    {
    NSURL *imageURL = [self.imageURLs objectAtIndex:index];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UIImage *image = [self.imageCache objectForKey:imageURL.absoluteString];
        if (!image) {
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            image = [UIImage imageWithData:imageData];
            [self.imageCache setObject:image forKey:imageURL.absoluteString];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            // Update the UI
            imageView.image = image;
        });
    });
    }
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
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

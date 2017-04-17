//
//  WJContactUsViewController.m
//  zzglj
//
//  Created by allen on 2017/4/17.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import "WJContactUsViewController.h"
#import "WJSysTool.h"

@interface WJContactUsViewController ()

@end

@implementation WJContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WJGlobalBg;
    UIButton *titleView = [[UIButton alloc] init];
    titleView.width=400;
    titleView.height=44;
    [titleView setTitle:@"联系我们" forState:UIControlStateNormal];
    [titleView.titleLabel setFont:[WJSysTool navigationTitleFont]];
    [titleView setImage:[UIImage imageNamed:@"glj_logo32"] forState:UIControlStateNormal];
    [titleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleView setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    [titleView setUserInteractionEnabled:NO];
    self.navigationItem.titleView = titleView;
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

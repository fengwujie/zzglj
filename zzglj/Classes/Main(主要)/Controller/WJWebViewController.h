//
//  WJWebViewController.h
//  zzglj
//
//  Created by fengwujie on 16/1/4.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJWebViewController : UIViewController

/**
 URL地址
 */
@property (nonatomic, copy) NSString *strUrl;

/**
 *  是否为主界面的web页面
 */
@property (nonatomic, assign, getter=isMainWeb) BOOL bMainWeb;

/**
 *  是否加载在导航控制器上
 */
@property (nonatomic, assign, getter=isNavigationController) BOOL bNavigationController;
@end

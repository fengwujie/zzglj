//
//  WJNewsSingleViewController
//  zzglj
//
//  Created by fengwujie on 16/1/6.
//  Copyright © 2016年 vision-soft. All rights reserved.
//  新闻列表父控制器

#import <UIKit/UIKit.h>

@interface WJNewsSingleViewController : UITableViewController

/**
 *  一级栏目，对应值为(公路局=1,文献文档=27）
 */
@property (nonatomic, strong) NSNumber *lmid;


/**
 *  二级栏目，对应值为（公路局=5,文献文档=258）
 */
@property (nonatomic, strong) NSNumber *lmid1;
/**
 *  请求方法名，必填，各自调用类的时候赋值，如新闻列表自己的WJNewsTool类中
 */
@property (nonatomic, copy) NSString *methodName;
@end

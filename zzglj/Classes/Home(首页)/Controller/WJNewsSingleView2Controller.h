//
//  WJNewsSingleView2Controller.h
//  zzglj
//
//  Created by allen on 2017/4/20.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJNewsSingleView2Controller : UITableViewController

/**
 *  一级栏目，对应值为(档案专题=218）
 */
@property (nonatomic, strong) NSNumber *lmid;

/**
 *  请求方法名，必填，各自调用类的时候赋值，如新闻列表自己的WJNewsTool类中
 */
//@property (nonatomic, copy) NSString *methodName;
@end

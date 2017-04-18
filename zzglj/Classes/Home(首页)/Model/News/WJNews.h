//
//  WJNews.h
//  zzglj
//
//  Created by fengwujie on 16/1/6.
//  Copyright © 2016年 vision-soft. All rights reserved.
//  新闻模型

#import <Foundation/Foundation.h>

@interface WJNews : NSObject
/**
 *  新闻ID
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *FTitle;
/**
 *  发布日期
 */
@property (nonatomic, copy) NSString *Indate;
/**
 *  链接地址，该字段如果是有填写则跳转到对应的页面(目前没有，服务器返回的是空值),
 */
@property (nonatomic, copy) NSString *RedirectUrl;
/**
 *  图片地址,由于图片是存放在服务器上面，在客户端显示图片时需在地址前加上http://42.96.167.141:8012
 */
@property (nonatomic, copy) NSString *Litpic;
/**
 *  新闻摘要
 */
@property (nonatomic, copy) NSString *Summary;

/**
 *  新闻真实的跳转链接
 */
@property (nonatomic, copy) NSString *realRedirectUrl;

@end

//
//  WJNewsSingleParam.h
//  zzglj
//
//  Created by allen on 2017/4/20.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJNewsSingleParam : NSObject

/**
 *  一级栏目，对应值为(档案专题=218）
 */
@property (nonatomic, strong) NSNumber *lmid;

///**	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。*/
//@property (nonatomic, strong) NSNumber *since_id;
//
///** false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。*/
//@property (nonatomic, strong) NSNumber *max_id;

/** false	int	单页返回的记录条数，最大不超过100，默认为20。*/
@property (nonatomic, strong) NSNumber *size;
/**
 *  表示获取时间大于minid的数据
 */
@property (nonatomic, copy) NSString *minid;
/**
 *  表示获取时间小于maxid的数据
 */
@property (nonatomic, copy) NSString *maxid;
/**
 *  目前没用到，空值
 */
@property (nonatomic, copy) NSString *keyWord;
/**
 *  目前没用到，空值
 */
@property (nonatomic, copy) NSString *str;

/**
 *  请求方法名，必填，各自调用类的时候赋值，如新闻列表自己的WJNewsTool类中
 */
@property (nonatomic, copy) NSString *methodName;

/**
 *  请求所需要的协议串，必填，各自调用类的时候赋值，如新闻列表自己的WJNewsTool类中
 */
@property (nonatomic, copy) NSString *soapMessage;

+ (instancetype)param;
@end

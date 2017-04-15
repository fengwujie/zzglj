//
//  WJRollImageParam.h
//  zzglj
//
//  Created by allen on 2017/4/16.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJRollImageParam : NSObject
/**
 *  257
 */
@property (nonatomic, strong) NSNumber *lmid;
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

//
//  WJNewsTools.h
//  zzglj
//
//  Created by allen on 2017/4/19.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJNewsParam.h"
#import "WJNewsReturn.h"
@interface WJNewsTools : NSObject

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)newsWithParam:(WJNewsParam *)param success:(void (^)(WJNewsReturn *result))success failure:(void (^)(NSError *error))failure;

@end

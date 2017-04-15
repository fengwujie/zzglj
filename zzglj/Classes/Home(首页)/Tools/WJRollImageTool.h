//
//  WJRollImageTool.h
//  zzglj
//
//  Created by allen on 2017/4/16.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJRollImageParam.h"
#import "WJRollImageReturn.h"

@interface WJRollImageTool : NSObject
/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)rollImageWithParam:(WJRollImageParam *)param success:(void (^)(WJRollImageReturn *result))success failure:(void (^)(NSError *error))failure;
@end

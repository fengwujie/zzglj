//
//  WJRollImageParam.m
//  zzglj
//
//  Created by allen on 2017/4/16.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import "WJRollImageParam.h"

@implementation WJRollImageParam
- (NSNumber *)lmid
{
    return _lmid ? _lmid : @257;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end

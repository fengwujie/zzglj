//
//  WJNewsParam.m
//  zzglj
//
//  Created by fengwujie on 16/1/8.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJNewsParam.h"

@implementation WJNewsParam

- (NSNumber *)size
{
    return _size ? _size : @20;
}

- (NSString *)minid
{
    return _minid ? _minid : @"";
}

- (NSString *)maxid
{
    return _maxid ? _maxid : @"";
}
- (NSString *)keyWord
{
    return _keyWord ? _keyWord : @"";
}

- (NSString *)str
{
    return _str ? _str : @"";
}

- (id)init
{
    if (self = [super init]) {
//        _size = @20;
//        _str = @"";
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end

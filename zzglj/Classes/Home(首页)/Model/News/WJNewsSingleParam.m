//
//  WJNewsSingleParam.m
//  zzglj
//
//  Created by allen on 2017/4/20.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import "WJNewsSingleParam.h"

@implementation WJNewsSingleParam

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

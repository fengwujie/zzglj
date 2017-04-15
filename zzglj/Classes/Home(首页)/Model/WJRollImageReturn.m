//
//  WJRollImageReturn.m
//  zzglj
//
//  Created by allen on 2017/4/16.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import "WJRollImageReturn.h"
#import "WJRollImage.h"
#import "MJExtension.h"

@implementation WJRollImageReturn
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"Details" : [WJRollImage class]};
}
@end

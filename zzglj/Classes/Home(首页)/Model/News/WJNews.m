//
//  WJNews.m
//  zzglj
//
//  Created by fengwujie on 16/1/6.
//  Copyright © 2016年 vision-soft. All rights reserved.
//

#import "WJNews.h"
#import "MJExtension.h"
#import "NSDate+WJ.h"
@implementation WJNews

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

-(void)setID:(NSString *)ID
{
    _ID = ID;
    self.realRedirectUrl = [NSString stringWithFormat:@"http://42.96.167.141:8012/app/Mobile/Normal/Content.aspx?NewsId=%@",ID];
}

- (void)setRedirectUrl:(NSString *)RedirectUrl
{
    _RedirectUrl = RedirectUrl;
    if(RedirectUrl != nil && RedirectUrl != NULL && ![RedirectUrl isEqualToString:@""])
    {
        self.realRedirectUrl = [NSString stringWithFormat:@"http://42.96.167.141:8012%@",RedirectUrl];
    }
}
@end

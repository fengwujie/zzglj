//
//  WJNewsTools.m
//  zzglj
//
//  Created by allen on 2017/4/19.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import "WJNewsTools.h"
#import "WJNews.h"
#import "MJExtension.h"
#import "WJHttpTool.h"

@implementation WJNewsTools

+ (void)newsWithParam:(WJNewsParam *)param success:(void (^)(WJNewsReturn *))success failure:(void (^)(NSError *))failure
{
    param.methodName = @"NewsTwoToJsonPage";
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\
                             <soap12:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">\
                             <soap12:Body>\
                             <%@ xmlns=\"http://tempuri.org/\">\
                             <size>%@</size>\
                             <lmid>%@</lmid>\
                             <lmid1>%@</lmid1>\
                             <minid>%@</minid>\
                             <maxid>%@</maxid>\
                             <keyWork>%@</keyWork>\
                             <str>%@</str>\
                             </%@>\
                             </soap12:Body>\
                             </soap12:Envelope>",
                             param.methodName,param.size, param.lmid,param.lmid1,param.minid,param.maxid,param.keyWord,param.str, param.methodName];
    param.soapMessage = soapMessage;
    NSDictionary *params = [param mj_keyValues];
    
    [WJHttpTool post:@"http://42.96.167.141:8012/AppWebServer/DataServiceWeb.asmx" params:params success:^(id responseObj) {
        if (success) {
            //WJNewsReturn *result = [WJNewsReturn mj_objectWithKeyValues:responseObj];
            WJNewsReturn *result = [[WJNewsReturn alloc] init];
            NSArray *resultTemp = [WJNews mj_objectArrayWithKeyValuesArray:responseObj];
            result.Details = resultTemp;
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    /*
     [WJHttpTool get:@"http://webservice.zzgjj.gov.cn/DataServiceWeb.asmx" params:params success:^(id responseObj) {
     //WJLog(@"请求成功！ %@",responseObj);
     // 新浪返回的字典数组
     //            NSArray *statusDictArray = responseObj[@"statuses"];
     
     // 缓存微博字典数组
     //            [self saveHomeStatusDictArray:statusDictArray accessToken:param.access_token];
     
     if (success) {
     WJNewsReturn *result = [WJNewsReturn mj_objectWithKeyValues:responseObj];
     success(result);
     }
     } failure:^(NSError *error) {
     //WJLog(@"请求失败！ %@",error);
     if (failure) {
     failure(error);
     }
     }];
     */
    
    /*
     NSDictionary *params = [param mj_keyValues];
     [WJHttpTool post:@"http://webservice.zzgjj.gov.cn/DataServiceWeb.asmx?op=TableToJson" params:params success:^(id responseObj) {
     WJLog(@"%@",responseObj);
     // 新浪返回的字典数组
     //            NSArray *statusDictArray = responseObj[@"statuses"];
     
     // 缓存微博字典数组
     //            [self saveHomeStatusDictArray:statusDictArray accessToken:param.access_token];
     
     if (success) {
     WJNewsReturn *result = [WJNewsReturn mj_objectWithKeyValues:responseObj];
     success(result);
     }
     } failure:^(NSError *error) {
     WJLog(@"%@",error);
     if (failure) {
     failure(error);
     }
     }];
     */
    
    //    }
    
}

@end

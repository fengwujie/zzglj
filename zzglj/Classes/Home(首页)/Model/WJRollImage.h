//
//  WJRollImage.h
//  zzglj
//
//  Created by allen on 2017/4/16.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJRollImage : NSObject
/**
 *  广告的编号
 */
@property (nonatomic, copy) NSString *ID;
/**
 *  广告标题
 */
@property (nonatomic, copy) NSString *AdTitle;
/**
 *  图片地址,由于图片是存放在服务器上面，在客户端显示图片时需在地址前加上http://42.96.167.141:8012
 */
@property (nonatomic, copy) NSString *AdPath;
/**
 *  图片链接
 */
@property (nonatomic, copy) NSString *AdLink;
@end

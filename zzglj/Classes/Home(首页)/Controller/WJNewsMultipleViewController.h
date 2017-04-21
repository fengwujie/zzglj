//
//  WJNewsMultipleViewController.h
//  zzglj
//
//  Created by allen on 2017/4/21.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJNewsMultipleViewController : UIViewController
/**
 *  segment页签的标题数组（法律法规=公路法规，档案法规；声像档案=公路照片，公务活动）
 */
@property (nonatomic, strong) NSArray *arraySegmentTitle;
/**
 *  一级栏目，对应值为(法律法规=10,声献档案=17）
 */
@property (nonatomic, strong) NSNumber *lmid;

/**
 *  二级栏目数组，对应值为（法律法规=公路法规为11，档案法规：14;声像档案=公路照片为204，公务活动：202）
 */
@property (nonatomic, strong) NSArray *arrayLmid1;
@end

//
//  WJNewsViewCell.h
//  zzglj
//
//  Created by allen on 2017/4/19.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJNews.h"

@interface WJNewsViewCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**
 *  设置当前CELL所在的行号
 *
 *  @param indexPath 当前行的indexPath
 *  @param rows      当前组中总行数
 */
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(int)rows;
/**
 *  Cell数据模型
 */
@property (nonatomic, strong) WJNews *news;
@end

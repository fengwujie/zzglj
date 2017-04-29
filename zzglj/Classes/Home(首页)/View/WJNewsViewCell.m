//
//  WJNewsViewCell.m
//  zzglj
//
//  Created by allen on 2017/4/19.
//  Copyright © 2017年 vision-soft. All rights reserved.
//

#import "WJNewsViewCell.h"
#import "UIImageView+WebCache.h"
#import "UILabel+Extension.h"
@interface WJNewsViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *News_Litpic;
@property (weak, nonatomic) IBOutlet UILabel *News_FTitle;

@end
@implementation WJNewsViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"News";
    WJNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        //cell = [[WJNewsViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //通过xib的名称加载自定义的cell
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WJNewsViewCell" owner:self options:nil] lastObject];

    }
    return cell;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:15];
        
        // 去除cell的默认背景色
        self.backgroundColor = [UIColor clearColor];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}

- (void)setNews:(WJNews *)news{
    _news = news;
    /*
    self.textLabel.text = news.FTitle;
    //self.detailTextLabel.text = news.cIndate;
    NSString *path = [NSString stringWithFormat:@"http://42.96.167.141:8012%@",news.Litpic];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:path]];
    */
    self.News_FTitle.text = news.FTitle;
    //[self.News_FTitle textLeftTopAlign];
    //self.detailTextLabel.text = news.cIndate;
    NSString *path = [NSString stringWithFormat:@"http://42.96.167.141:8012%@",news.Litpic];
    [self.News_Litpic sd_setImageWithURL:[NSURL URLWithString:path]];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;//这里间距为10，可以根据自己的情况调整
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= frame.origin.x;
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.News_Litpic.x = 2;
    self.News_Litpic.y = 2;
    self.News_Litpic.height = self.contentView.height-4;
    self.News_Litpic.width = self.News_Litpic.height;
    
    self.News_FTitle.x = self.News_Litpic.width + 10;
    self.News_FTitle.y = 0;
    self.News_FTitle.height = self.contentView.height;
    self.News_FTitle.width = self.contentView.width - self.News_Litpic.width - 10*2;
}

#pragma mark - setter
- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSUInteger)rows
{
    // 1.取出背景view
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selectedBgView = (UIImageView *)self.selectedBackgroundView;
    
    // 2.设置背景图片
    if (rows == 1) {
        bgView.image = [UIImage resizedImage:@"common_card_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    } else if (indexPath.row == 0) { // 首行
        bgView.image = [UIImage resizedImage:@"common_card_top_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 末行
        bgView.image = [UIImage resizedImage:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
    } else { // 中间
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  CZNewsCell.m
//  新闻
//
//  Created by mac on 15-7-5.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import "CZNewsCell.h"
#import <UIImageView+AFNetworking.h>
#import "CZNews.h"
@interface CZNewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UILabel *digestView;
@property (weak, nonatomic) IBOutlet UILabel *replyCountView;


@end
@implementation CZNewsCell
- (void)setNews:(CZNews *)news {
    _news = news;
    self.titleView.text = news.title;
    self.digestView.text = news.digest;
  self.replyCountView.text = [NSString stringWithFormat:@"%@", news.replyCount];
    [self.iconView setImageWithURL:[NSURL URLWithString:news.imgsrc]];
}
- (void)awakeFromNib {
    //设置摘要换行的宽度
    self.digestView.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - CGRectGetMinX(self.iconView.frame) -90;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

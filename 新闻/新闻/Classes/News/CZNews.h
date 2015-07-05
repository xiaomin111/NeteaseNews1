//
//  CZNews.h
//  新闻
//
//  Created by mac on 15-7-5.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZNews : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *replyCount;
@property (nonatomic, copy) NSString *digest;
@property (nonatomic, copy) NSString *imgsrc;
@property (nonatomic, copy) NSString *haha;
+ (instancetype)newsWithDict:(NSDictionary *)dict;
+(void)loadNewsListWithURLString:(NSString *)urlString;
@end

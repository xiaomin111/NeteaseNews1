//
//  CZNetWorkTools.m
//  新闻
//
//  Created by mac on 15-7-4.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import "CZNetWorkTools.h"

@implementation CZNetWorkTools
+ (instancetype)shareNetWorkTools {
    static CZNetWorkTools *instance;
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //后续使用可以用相对路径
        //末尾一定要加/
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/article/headline/"];
        instance = [[self alloc]initWithBaseURL:url];
        //添加相应的解析数据的格式- AFN为了避免出错。a默认只支持三种数据类型的JSON反序列化
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}
@end

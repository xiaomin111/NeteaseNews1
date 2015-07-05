//
//  CZNews.m
//  新闻
//
//  Created by mac on 15-7-5.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import "CZNews.h"
#import "CZNetWorkTools.h"
#import <objc/runtime.h>
@implementation CZNews
+ (instancetype)newsWithDict:(NSDictionary *)dict{
    CZNews *news = [[self alloc]init];
    NSArray *propertis = [self propertis];
    for (NSString *key in propertis) {
        if (key != nil) {
            
            [news setValue:dict[key] forKeyPath:key];
        }
    }
//    [news setValuesForKeysWithDictionary:dict];
    return news;
}

const char *kPropertiesKey = "kPropertiesKey";
+(NSArray *)propertis {
    //1.对象，属性关联到对象
    //2.key， 属性的key
    NSArray *pList  = objc_getAssociatedObject(self, kPropertiesKey);
    if (pList !=nil) {
        return pList;
    }
    unsigned int conut = 0 ;
    /**
     *  1.类
     *  2.属性计数指针
  
     */
    objc_property_t *list =  class_copyPropertyList([self class], &conut);
    NSLog(@"count= %zd",conut);
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:conut];
    for (unsigned int i = 0; i < conut; ++i) {
        //c语言中一般没有对象的概念，一般不需要*
        objc_property_t pty = list[i];
        //属性名称
        const char *sname = property_getName(pty);
//        printf("%s\t",sname);
        //添加到数组
        [mArray addObject:[NSString stringWithUTF8String:sname]];
         
    }
    NSLog(@"mArray = %@",mArray);
    printf("\n");
    //释放对象
        free(list);
    objc_setAssociatedObject(self, kPropertiesKey, mArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return objc_getAssociatedObject(self, kPropertiesKey);
}

- (NSString *)description {
    NSArray *propertis = [self.class propertis];
    NSDictionary *dic = [self dictionaryWithValuesForKeys:propertis];
    return [NSString stringWithFormat:@"<%@:%p> %@",self.class,self,dic];
}
+(void)loadNewsListWithURLString:(NSString *)urlString finished:(void (^)(NSArray *))finished{
    NSAssert(finished !=nil, @"必须转入完成回调");
    [[CZNetWorkTools shareNetWorkTools] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
        //利用keyEnumerator.nextObject 能拿到第一个key
        NSLog(@"%@",responseObject.keyEnumerator.nextObject);
        //根据key拿到数组
        NSArray *array = responseObject[responseObject.keyEnumerator.nextObject];
        NSLog(@"array = %@",array);
        //Capacity 容量 假设分配10，一次性可以分配10个内存空间
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dic in array) {
            [mArray addObject:[self newsWithDict:dic]];
//            NSLog(@"mArray = %@",mArray);
        }
        finished(mArray.copy);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end

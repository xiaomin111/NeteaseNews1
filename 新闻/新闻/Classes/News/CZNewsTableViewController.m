//
//  CZNewsTableViewController.m
//  新闻
//
//  Created by mac on 15-7-4.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import "CZNewsTableViewController.h"
#import "CZNews.h"
#import "CZNewsCell.h"
@interface CZNewsTableViewController ()
@property (nonatomic, strong) NSArray *newsList;
@end

@implementation CZNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf =self;
    [CZNews loadNewsListWithURLString:@"T1348647853363/0-20.html" finished:^(NSArray *newsList) {
        weakSelf.newsList = newsList;
    }];
}
- (void)setNewsList:(NSArray *)newsList {
    _newsList = newsList ;
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID = @"cell";
    CZNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" ];
    CZNews *news = self.newsList[indexPath.row];
    cell.news = news;
    return cell;
}

@end

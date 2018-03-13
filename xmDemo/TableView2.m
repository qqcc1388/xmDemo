//
//  TableView2.m
//  xmDemo
//
//  Created by Tiny on 2018/3/13.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import "TableView2.h"

@interface TableView2 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) CGPoint lastContentOffset;

@end

@implementation TableView2

-(void)setHeaderView:(TYHeaderView *)headerView{
    _headerView = headerView;
    self.dataSource = self;
    self.delegate = self;
    self.scrollIndicatorInsets = UIEdgeInsetsMake(headerView.height, 0, 0, 0);
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.headerView.height)];
    self.tableHeaderView = tableHeaderView;
    [self reloadData];
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat placeHolderHeight = self.headerView.height - 44;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= placeHolderHeight) {
        if (offsetY > self.lastContentOffset.y) {
            //往上滑动
            if (offsetY>(-self.headerView.y)) {
                self.headerView.y = -offsetY;
            }
        }else
        {
            //往下滑动
            if (offsetY<(-self.headerView.y)) {
                self.headerView.y = -offsetY;
            }
        }
    }
    else if (offsetY > placeHolderHeight) {
        if (self.headerView.y != (-placeHolderHeight)) {
            if (offsetY > self.lastContentOffset.y) {
                //往上滑动
                self.headerView.y = self.headerView.y - (scrollView.contentOffset.y-self.lastContentOffset.y);
            }
            if (self.headerView.y < (-placeHolderHeight)) {
                self.headerView.y = -placeHolderHeight;
            }
            if (self.headerView.y>=0) {
                self.headerView.y = 0;
            }
        }
    }
    else if (offsetY <0) {
        self.headerView.y =  - offsetY;
    }
    
    //    if (offsetY>50) {
    //        self.headerView.navView.transparency = 1;
    //    }else
    //    {
    //        self.headerView.navView.transparency = 0;
    //    }
    
    self.lastContentOffset = scrollView.contentOffset;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"测试数据";
    return cell;
}
@end

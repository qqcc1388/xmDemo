//
//  ViewController.m
//  xmDemo
//
//  Created by Tiny on 2018/3/13.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import "ViewController.h"
#import "UIView+XYView.h"
#import "TYTableView1.h"
#import "TableView2.h"
#import "TYHeaderView.h"

#define kHeadHeight    300

@interface ViewController ()<UIScrollViewDelegate,headerViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) TYHeaderView *headerView;

@property (nonatomic, strong) TYTableView1 *tableView1;

@property (nonatomic, strong) TableView2 *tableView2;

@property (nonatomic, assign) CGPoint lastContentOffset;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
    
}


-(TYHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[TYHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadHeight)];
        _headerView.backgroundColor = [UIColor redColor];
        _headerView.delegate = self;
    }
    return _headerView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *2, 0);
    }
    return _scrollView;
}

-(UITableView *)tableView1{
    if (!_tableView1) {
        _tableView1 = [[TYTableView1 alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, self.scrollView.height)];
        _tableView1.showsHorizontalScrollIndicator = NO;
        _tableView1.showsVerticalScrollIndicator = NO;
        _tableView1.headerView = self.headerView;
    }
    return _tableView1;
}

-(UITableView *)tableView2{
    if (!_tableView2) {
        _tableView2 = [[TableView2 alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0,SCREEN_WIDTH, self.scrollView.height)];
        _tableView2.showsHorizontalScrollIndicator = NO;
        _tableView2.showsVerticalScrollIndicator = NO;
        _tableView2.headerView = self.headerView;
    }
    return _tableView2;
}

-(void)setupUI{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.tableView1];
    [self.scrollView addSubview:self.tableView2];
    [self.scrollView addSubview:self.headerView];
    
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        self.headerView.x = scrollView.contentOffset.x;
        int index = 0;
        
        if (self.lastContentOffset.x < scrollView.contentOffset.x) {
            //往右滑动，向上取整
            index = ceil((scrollView.contentOffset.x/SCREEN_WIDTH));
        }else if (self.lastContentOffset.x > scrollView.contentOffset.x)
        {
            //往左滑动，向下取整
            index = floor((scrollView.contentOffset.x/SCREEN_WIDTH));
        }else
        {
            //没动
            index = (scrollView.contentOffset.x/SCREEN_WIDTH);
        }
        
        CGFloat mobileDistance = (0-self.headerView.y);
        switch (index) {
            case 0:{
                //修改circleTableView
                if (self.tableView1.contentOffset.y<mobileDistance) {
                    [self.tableView1 setContentOffset:CGPointMake(0, mobileDistance) animated:NO];
                }
            }
                break;
            case 1:{
                //修改photoView
                if (self.tableView2.contentOffset.y<mobileDistance) {
                    [self.tableView2 setContentOffset:CGPointMake(0, mobileDistance) animated:NO];
                }
            }
                break;
            default:
                break;

        }
        self.lastContentOffset = scrollView.contentOffset;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    static int lastIndex = 0;
    int index = 0;

    if (self.lastContentOffset.x < scrollView.contentOffset.x) {
        //往右滑动，向上取整
        index = ceil((scrollView.contentOffset.x/SCREEN_WIDTH));
    }else if (self.lastContentOffset.x > scrollView.contentOffset.x)
    {
        //往左滑动，向下取整
        index = floor((scrollView.contentOffset.x/SCREEN_WIDTH));
    }else
    {
        //没动
        index = (scrollView.contentOffset.x/SCREEN_WIDTH);
    }
//    if (lastIndex != index) {  //让headerView重新设置选中的item
        self.headerView.selectIndex = index;
//    }
    lastIndex = index;
}

#pragma mark - headerViewDelegate
-(void)headerView:(TYHeaderView *)headerView SelectionIndex:(NSInteger)index{
    //让scrollView滚动到指定位置
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.width*index, 0) animated:YES];
}

@end

//
//  TYSelectionTool.m
//  xmDemo
//
//  Created by Tiny on 2018/3/13.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import "TYSelectionTool.h"

@interface TYSelectionTool ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSMutableArray *itemsList;

@end

@implementation TYSelectionTool

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor greenColor];
    }
    return _lineView;
}

-(NSMutableArray *)itemsList{
    if (!_itemsList) {
        _itemsList = [NSMutableArray array];
    }
    return _itemsList;
}

-(void)setupUI{
    
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    UIButton *item = [self.itemsList objectAtIndex:selectIndex];
    if (item) {
        [self itemClick:item];
    }else{
        [self itemClick:self.itemsList.firstObject];
    }
}

-(void)setItems:(NSArray *)items{
    _items = items;
    CGFloat width = SCREEN_WIDTH/(items.count *1.0);
    CGFloat height = 44;
    UIButton *last = nil;
    for (int i = 0; i < items.count; i ++) {
        UIButton *item = [UIButton new];
        item.titleLabel.font = [UIFont systemFontOfSize:14];
        [item setTitle:items[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:item];
        [self.itemsList addObject:item];
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        item.tag = i;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.centerY.mas_equalTo(self);
            if (last) {
                make.left.mas_equalTo(last.mas_right);
            }else{
                make.left.mas_offset(0);
            }
        }];
        if (i == 0) {
            [self addSubview:self.lineView];
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(0);
                make.height.mas_equalTo(2);
                make.width.mas_equalTo(50);
                make.centerX.mas_equalTo(item.mas_centerX);
            }];
        }
        last = item;
    }
}

-(void)itemClick:(UIButton *)item{
    static UIButton *last = nil;
    if (last != item) {
        [UIView animateWithDuration:0.25f animations:^{
            [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_offset(0);
                make.height.mas_equalTo(2);
                make.width.mas_equalTo(50);
                make.centerX.mas_equalTo(item.mas_centerX);
            }];
        }];
        if (self.selectionToolBlock) {
            self.selectionToolBlock(item.tag);
        }
    }
    last = item;
}

@end

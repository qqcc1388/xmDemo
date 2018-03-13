//
//  TYHeaderView.m
//  xmDemo
//
//  Created by Tiny on 2018/3/13.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import "TYHeaderView.h"
#import "TYSelectionTool.h"

@interface TYHeaderView ()

@property (nonatomic, strong) TYSelectionTool *switchView;

@end

@implementation TYHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(TYSelectionTool *)switchView{
    if (!_switchView) {
        _switchView = [TYSelectionTool new];
        _switchView.backgroundColor = [UIColor blueColor];
        _switchView.items = @[@"第一个",@"第二个"];
        __weak typeof(self) weakself = self;
        _switchView.selectionToolBlock = ^(NSInteger index) {
            NSLog(@"%zi",index);
            if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(headerView:SelectionIndex:)]) {
                [weakself.delegate headerView:weakself SelectionIndex:index];
            }
        };
    }
    return _switchView;
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    self.switchView.selectIndex = selectIndex;
}

-(void)setupUI{
    
    [self addSubview:self.switchView];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(44);
    }];
}
@end

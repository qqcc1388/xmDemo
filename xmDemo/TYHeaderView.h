//
//  TYHeaderView.h
//  xmDemo
//
//  Created by Tiny on 2018/3/13.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TYHeaderView;
@protocol headerViewDelegate<NSObject>

@required
-(void)headerView:(TYHeaderView *)headerView SelectionIndex:(NSInteger)index;

@end

@interface TYHeaderView : UIView

@property (nonatomic,weak) id<headerViewDelegate> delegate;

@property (nonatomic, assign) NSInteger selectIndex;
@end

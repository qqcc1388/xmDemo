//
//  TYSelectionTool.h
//  xmDemo
//
//  Created by Tiny on 2018/3/13.
//  Copyright © 2018年 hxq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYSelectionTool : UIView

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) void (^selectionToolBlock)(NSInteger index);

@property (nonatomic, assign) NSInteger selectIndex;
@end

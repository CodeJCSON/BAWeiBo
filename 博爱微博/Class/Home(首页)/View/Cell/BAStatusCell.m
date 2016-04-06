//
//  BAStatusCell.m
//  博爱微博
//
//  Created by 博爱之家 on 15/8/27.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BAStatusCell.h"

#import "BAOriginalView.h"
#import "BARetweetView.h"
#import "BAStatusToolBar.h"

#import "BAStatusFrame.h"

@interface BAStatusCell ()

@property (nonatomic, strong) BAOriginalView *originalView;
@property (nonatomic, strong) BARetweetView *retweetView;
@property (nonatomic, strong) BAStatusToolBar *toolBar;

@end

@implementation BAStatusCell


// 注意：cell是用initWithStyle初始化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 添加所有子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    // 原创微博
    BAOriginalView *originalView = [[BAOriginalView alloc] init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    // 转发微博
    BARetweetView *retweetView = [[BARetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    // 工具条
    BAStatusToolBar *toolBar = [[BAStatusToolBar alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    
    if (cell == nil)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

/*
 问题：
        1.cell的高度应该提前计算出来
        2.cell的高度必须要先计算出每个子控件的frame，才能确定
        3.如果在cell的setStatus方法计算子控件的位置，会比较耗性能

 解决:MVVM思想
         M:模型
         V:视图
         VM:视图模型（模型包装视图模型，模型+模型对应视图的frame）
 */

- (void)setStatusF:(BAStatusFrame *)statusF
{
    _statusF = statusF;
    
    // 设置原创微博frame
    _originalView.frame = statusF.originalViewFrame;
    _originalView.statusF = statusF;
    
    // 设置转发微博frame
    _retweetView.frame = statusF.retweetViewFrame;
    _retweetView.statusF = statusF;
    
    // 设置工具条frame
    _toolBar.frame = statusF.toolBarFrame;
}
@end

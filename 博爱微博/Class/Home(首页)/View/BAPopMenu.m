//
//  BAPopMenu.m
//  博爱微博
//
//  Created by 孙博岩 on 15/8/1.
//  Copyright © 2015年 boai. All rights reserved.
//

#import "BAPopMenu.h"
#import "UIImage+Image.h"
#import "UIView+Frame.h"

@implementation BAPopMenu

// 显示弹出菜单
+ (instancetype)showInRect:(CGRect)rect
{
    BAPopMenu *menu = [[BAPopMenu alloc] initWithFrame:rect];
    menu.userInteractionEnabled = YES;
    menu.image = [UIImage imageWithStretchableName:@"popover_background"];
    
    [BAKeyWindow addSubview:menu];

    return menu;
}

// 隐藏弹出菜单
+ (void)hide
{
    for (UIView *popMenu in BAKeyWindow.subviews)
    {
        if ([popMenu isKindOfClass:self])
        {
            [popMenu removeFromSuperview];
        }
    }
}
// 设置内容视图
- (void)setContentView:(UIView * __nullable)contentView
{
    // 先移除之前内容视图
    [_contentView removeFromSuperview];
    
    _contentView = contentView;
    contentView.backgroundColor = [UIColor redColor];
    [self addSubview:contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 计算内容视图尺寸
    CGFloat y = 9;
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    
    _contentView.frame = CGRectMake(x, y, w, h);
}

@end

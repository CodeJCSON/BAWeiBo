//
//  BACover.m
//  博爱微博
//
//  Created by 孙博岩 on 15/8/1.
//  Copyright © 2015年 boai. All rights reserved.
//

#import "BACover.h"

@implementation BACover

// 设置浅灰色蒙板
- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground)
    {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.5;
    }
    else
    {
        self.alpha = 1;
        self.backgroundColor = [UIColor clearColor];
    }
}

// 显示蒙板
+ (instancetype)show
{
    BACover *cover = [[BACover alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor clearColor];
    
    [BAKeyWindow addSubview:cover];
    
    return cover;
}

// 点击蒙板的时候做事情
//- (void)touchesBegan:(n *)touches withEvent:(nullable UIEvent *)event
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 移除蒙板
    [self removeFromSuperview];

    // 通知代理移除菜单
    if ([_delegate respondsToSelector:@selector(coverDidClickCover:)])
    {
        [_delegate coverDidClickCover:self];
    }
}

@end

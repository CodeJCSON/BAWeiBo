//
//  BAStatusFrame.m
//  博爱微博
//
//  Created by 博爱之家 on 15/9/4.
//  Copyright (c) 2015年 boai. All rights reserved.
// 模型 + 对应控件的frame

#import "BAStatusFrame.h"
#import "BAStatus.h"
#import "BAUser.h"

#define BAStatusCellMargin 10
#define BANameFont [UIFont systemFontOfSize:13]
#define BATimeFont [UIFont systemFontOfSize:12]
#define BASourceFont BATimeFont
#define BATextFont [UIFont systemFontOfSize:15]
#define BAScreenW [UIScreen mainScreen].bounds.size.width

@implementation BAStatusFrame

- (void)setStatus:(BAStatus *)status
{
    _status = status;
    
    // 计算原创微博
    [self setUpOriginalViewFrame];
    
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (status.retweeted_status)
    {
        // 计算转发微博
        [self setUpRetweetViewFrame];
        
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    // 计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = BAScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    // 计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}

#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame
{
    // 头像
    CGFloat imageX = BAStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + BAStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:BANameFont];
    _originalNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + BAStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    
    // 时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + BAStatusCellMargin * 0.5;
    CGSize timeSize = [_status.created_at sizeWithFont:BATimeFont];
    _originalTimeFrame = (CGRect){{timeX,timeY},timeSize};
    
    // 来源
    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + BAStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_status.source sizeWithFont:BASourceFont];
    _originalSourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + BAStatusCellMargin;
    
    CGFloat textW = BAScreenW - 2 * BAStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:BATextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = BAScreenW;
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + BAStatusCellMargin;
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}

#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    // 昵称
    CGFloat nameX = BAStatusCellMargin;
    CGFloat nameY = nameX;
    // 注意：一定要是转发微博的用户昵称
    CGSize nameSize = [_status.retweeted_status.user.name sizeWithFont:BANameFont];
    _retweetNameFrame = (CGRect){{nameX,nameY},nameSize};
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + BAStatusCellMargin;
    
    CGFloat textW = BAScreenW - 2 * BAStatusCellMargin;
    // 注意：一定要是转发微博的正文
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:BATextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    // 原创微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = BAScreenW;
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + BAStatusCellMargin;
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}
@end

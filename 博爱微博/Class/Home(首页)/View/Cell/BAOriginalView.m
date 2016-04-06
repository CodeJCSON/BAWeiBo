//
//  BAOriginalView.m
//  博爱微博
//
//  Created by 博爱之家 on 15/8/27.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BAOriginalView.h"
#import "BAStatusFrame.h"
#import "BAStatus.h"


#import "UIImageView+WebCache.h"

@interface BAOriginalView ()

// 头像
@property (nonatomic, strong) UIImageView *iconView;

// 昵称
@property (nonatomic, strong)  UILabel *nameView;

// vip
@property (nonatomic, strong) UIImageView *vipView;


// 时间
@property (nonatomic, strong) UILabel *timeView;


// 来源
@property (nonatomic, strong) UILabel *sourceView;


// 正文
@property (nonatomic, strong) UILabel *textView;


@end

@implementation BAOriginalView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
        
    }
    return self;
}


// 添加所有子控件

- (void)setUpAllChildView
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = BANameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = BATimeFont;
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = BASourceFont;
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = BATextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
}

- (void)setStatusF:(BAStatusFrame *)statusF
{
    _statusF = statusF;
    
    // 设置frame
    [self setUpFrame];
    // 设置data
    [self setUpData];
    
}

- (void)setUpData
{
    BAStatus *status = _statusF.status;
    // 头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 昵称
    if (status.user.vip)
    {
        _nameView.textColor = [UIColor redColor];
    }
    else
    {
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    // vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    
    _vipView.image = image;
    
    // 时间
    _timeView.text = status.created_at;
    
    // 来源
    
    _sourceView.text = status.source;
    
    // 正文
    _textView.text = status.text;
}

- (void)setUpFrame
{
    // 头像
    _iconView.frame = _statusF.originalIconFrame;
    
    // 昵称
    _nameView.frame = _statusF.originalNameFrame;
    
    // vip
    if (_statusF.status.user.vip) { // 是vip
        _vipView.hidden = NO;
        _vipView.frame = _statusF.originalVipFrame;
    }else{
        _vipView.hidden = YES;
    }
    // 时间
    _timeView.frame = _statusF.originalTimeFrame;
    
    // 来源
    _sourceView.frame = _statusF.originalSourceFrame;
    
    // 正文
    _textView.frame = _statusF.originalTextFrame;
    
    
}
@end

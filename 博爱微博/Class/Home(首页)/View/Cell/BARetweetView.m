//
//  BARetweetView.m
//  博爱微博
//
//  Created by 博爱之家 on 15/8/27.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BARetweetView.h"
#import "BAStatus.h"
#import "BAStatusFrame.h"

@interface BARetweetView ()

// 昵称
@property (nonatomic, strong)  UILabel *nameView;

// 正文
@property (nonatomic, strong) UILabel *textView;

@end

@implementation BARetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retWeet_background"];
    }
    return self;
}


// 添加所有子控件

- (void)setUpAllChildView
{
     // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = BANameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
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
    
    
    BAStatus *status = statusF.status;
    // 昵称
    _nameView.frame = statusF.retweetNameFrame;
    _nameView.text = status.retweeted_status.user.name;
    
    // 正文
    _textView.frame = statusF.retweetTextFrame;
    _textView.text = status.retweeted_status.text;
}


@end

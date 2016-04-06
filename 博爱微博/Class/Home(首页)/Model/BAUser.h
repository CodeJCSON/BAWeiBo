//
//  BAUser.h
//  博爱微博
//
//  Created by boai on 15/8/8.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAUser : NSObject

/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;


@property (nonatomic, assign,getter=isVip) BOOL vip;


@end

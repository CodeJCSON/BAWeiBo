//
//  BAUser.m
//  博爱微博
//
//  Created by boai on 15/8/8.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BAUser.h"

@implementation BAUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end

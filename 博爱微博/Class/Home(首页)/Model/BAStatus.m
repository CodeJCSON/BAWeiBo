//
//  BAStatus.m
//  博爱微博
//
//  Created by boai on 15/8/8.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BAStatus.h"

#import "BAPhoto.h"

@implementation BAStatus

// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[BAPhoto class]};
} 



@end

//
//  BAStatusResult.m
//  博爱微博
//
//  Created by boai on 15/8/14.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BAStatusResult.h"

#import "BAStatus.h"

@implementation BAStatusResult

+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[BAStatus class]};
}


@end

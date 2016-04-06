//
//  BABaseParam.m
//  博爱微博
//
//  Created by boai on 15/8/19.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BABaseParam.h"
#import "BAAccountTool.h"
#import "BAAccount.h"

@implementation BABaseParam

+ (instancetype)param
{
    BABaseParam *param = [[self alloc] init];

    param.access_token = [BAAccountTool account].access_token;
    
    return param;
}


@end

//
//  BAUserParam.h
//  博爱微博
//
//  Created by boai on 15/8/19.
//  Copyright (c) 2015年 boai. All rights reserved.
//  用户未读数据请求的参数模型

#import <Foundation/Foundation.h>
#import "BABaseParam.h"

@interface BAUserParam : BABaseParam

/**
 *  当前登录用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;




@end

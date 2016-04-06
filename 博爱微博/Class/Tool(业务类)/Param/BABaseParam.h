//
//  BABaseParam.h
//  博爱微博
//
//  Created by boai on 15/8/19.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BABaseParam : NSObject

/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

+ (instancetype)param;


@end

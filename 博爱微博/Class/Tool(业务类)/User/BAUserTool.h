//
//  BAUserTool.h
//  博爱微博
//
//  Created by boai on 15/8/19.
//  Copyright (c) 2015年 boai. All rights reserved.
//  处理用户业务

#import <Foundation/Foundation.h>
#import "BAUser.h"

@class BAUserResult;
@interface BAUserTool : NSObject

/**
 *  请求用户的未读数
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)unreadWithSuccess:(void(^)(BAUserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(BAUser *user))success failure:(void(^)(NSError *error))failure;

@end

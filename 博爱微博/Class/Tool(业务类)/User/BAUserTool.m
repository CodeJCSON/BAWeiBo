//
//  BAUserTool.m
//  博爱微博
//
//  Created by boai on 15/8/19.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BAUserTool.h"
#import "BAHttpTool.h"
#import "BAUserParam.h"
#import "BAUserResult.h"

#import "BAAccount.h"
#import "BAAccountTool.h"
#import "MJExtension.h"

@implementation BAUserTool

+ (void)unreadWithSuccess:(void(^)(BAUserResult *))success failure:(void(^)(NSError *))failure
{
    // 创建参数模型
    BAUserParam *param = [BAUserParam param];
    param.uid = [BAAccountTool account].uid;
    
    [BAHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
    
        // 字典转模型
        BAUserResult *result = [BAUserResult objectWithKeyValues:responseObject];
        
        if (success)
        {
            success(result);
        }
        
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];

}

+ (void)userInfoWithSuccess:(void (^)(BAUser *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    BAUserParam *param = [BAUserParam param];
    param.uid = [BAAccountTool account].uid;
    
    [BAHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        // 用户字典转换用户模型
        BAUser *user = [BAUser objectWithKeyValues:responseObject];
        
        if (success) {
            success(user);
        }
        
    } failure:^(NSError *error) {
        
        if (failure) {
            failure(error);
        }
    }];

}

@end

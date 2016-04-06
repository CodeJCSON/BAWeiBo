//
//  BAAccountTool.m
//  博爱微博
//
//  Created by boai on 15/8/5.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BAAccountTool.h"
#import "BAAccount.h"

#import "AFNetworking.h"
#import "BAHttpTool.h"
#import "BAAccountParam.h"
#import "MJExtension.h"

#define BAAuthorizeBaseUrl  @"https://api.weibo.com/oauth2/authorize"
#define BAClient_id         @"3487861006"
#define BARedirect_uri      @"http://www.baidu.com"
#define BAClient_secret     @"813c95eb86b0d47f14348d5d3b5729e4"

#define BAAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]


@implementation BAAccountTool

// 类方法一般用静态变量代替成员属性

static BAAccount *_account;

+ (void)saveAccount:(BAAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:BAAccountFileName];
}

+ (BAAccount *)account
{
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:BAAccountFileName];
        
        // 判断下账号是否过期，如果过期直接返回Nil
        // 2015 < 2017
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) { // 过期
            return nil;
        }
        
    }
    
    
    return _account;
}

+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    BAAccountParam *param = [[BAAccountParam alloc] init];
    param.client_id = BAClient_id;
    param.client_secret = BAClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = BARedirect_uri;
    
    
    [BAHttpTool Post:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        
        //        NSLog(@"%@", responseObject);
        
        // 字典转模型
        BAAccount *account = [BAAccount accountWithDict:responseObject];
        
        // 保存账号信息:
        // 数据存储一般我们开发中会搞一个业务类，专门处理数据的存储
        // 以后我不想归档，用数据库，直接改业务类
        [BAAccountTool saveAccount:account];

        if (success)
        {
            success();
        }
    } failure:^(NSError *error) {
        if (failure)
        {
            failure(error);
        }
    }];
  
}



@end

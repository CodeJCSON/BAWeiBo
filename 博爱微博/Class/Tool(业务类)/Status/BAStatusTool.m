//
//  BAStatusTool.m
//  博爱微博
//
//  Created by boai on 15/8/13.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BAStatusTool.h"
#import "BAHttpTool.h"
#import "BAStatus.h"
#import "BAAccountTool.h"
#import "BAAccount.h"

#import "BAStatusParam.h"
#import "MJExtension.h"
#import "BAStatusResult.h"

@implementation BAStatusTool

+ (void)newStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    BAStatusParam *param = [[BAStatusParam alloc] init];
    param.access_token = [BAAccountTool account].access_token;
    if (sinceId) { // 有微博数据，才需要下拉刷新
        param.since_id = sinceId;
        
    }
    
    [BAHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) { // HttpTool请求成功的回调
        // 请求成功代码先保存
        
        BAStatusResult *result = [BAStatusResult objectWithKeyValues:responseObject];
        
        //        // 获取到微博数据 转换成模型
        //        // 获取微博字典数组
        //        NSArray *dictArr = responseObject[@"statuses"];
        //        // 把字典数组转换成模型数组
        //        NSArray *statuses = (NSMutableArray *)[CZStatus objectArrayWithKeyValuesArray:dictArr];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)moreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    BAStatusParam *param = [[BAStatusParam alloc] init];
    param.access_token = [BAAccountTool account].access_token;
    if (maxId) { // 有微博数据，才需要下拉刷新
        param.max_id = maxId;
        
    }
    
    [BAHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) { // HttpTool请求成功的回调
        // 请求成功代码先保存
        
        // 把结果字典转换结果模型
        BAStatusResult *result = [BAStatusResult objectWithKeyValues:responseObject];
        
        if (success) {
            success(result.statuses);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];



}




@end

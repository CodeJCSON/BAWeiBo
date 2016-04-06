//
//  BAAccount.h
//  博爱微博
//
//  Created by boai on 15/8/5.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

//"access_token" = "2.00rgrSmFbkehbC7e6d1c76a9ZumKNB";
//"expires_in" = 157679999;
//"remind_in" = 157679999;
//uid = 5294424581;

@interface BAAccount : NSObject <NSCoding>

/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *  用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

/**
 *   过期时间 = 当前保存时间+有效期
 */
@property (nonatomic, strong) NSDate *expires_date;

/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

/**
 *
 */



@end

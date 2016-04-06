//
//  BAAccount.m
//  博爱微博
//
//  Created by boai on 15/8/5.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BAAccount.h"

#define BAAccountTokenKey @"token"
#define BAUidKey @"uid"
#define BAExpires_inKey @"exoires"
#define BAExpires_dateKey @"date"
#define BANameKey @"name"

#import "MJExtension.h"

@implementation BAAccount

// 底层便利当前的类的所有属性，一个一个归档和接档
MJCodingImplementation

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    BAAccount *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];

}


// 归档的时候调用：告诉系统哪个属性需要归档，如何归档
//- (void)encodeWithCoder:(NSCoder *)aCoder
//{
//    [aCoder encodeObject:_access_token forKey:BAAccountTokenKey];
//    [aCoder encodeObject:_expires_in   forKey:BAExpires_inKey];
//    [aCoder encodeObject:_uid forKey:BAUidKey];
//    [aCoder encodeObject:_expires_date forKey:BAExpires_dateKey];
//    [aCoder encodeObject:_name forKey:BANameKey];
//}

// 解档的时候调用：告诉系统哪个属性需要解档，如何解档
//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super init])
//    {
//        // 一定要记得赋值
//        _access_token = [aDecoder decodeObjectForKey:BAAccountTokenKey];
//        _expires_in = [aDecoder decodeObjectForKey:BAExpires_inKey];
//        _uid = [aDecoder decodeObjectForKey:BAUidKey];
//        _expires_date = [aDecoder decodeObjectForKey:BAExpires_dateKey];
//        _name = [aDecoder decodeObjectForKey:BANameKey];
//    }
//    return self;
//}

/**
 *  KVC底层实现：遍历字典里的所有key(uid)
 一个一个获取key，会去模型里查找setKey: setUid:,直接调用这个方法，赋值 setUid:obj
 寻找有没有带下划线_key,_uid ,直接拿到属性赋值
 寻找有没有key的属性，如果有，直接赋值
 在模型里面找不到对应的Key,就会报错.
 */


@end

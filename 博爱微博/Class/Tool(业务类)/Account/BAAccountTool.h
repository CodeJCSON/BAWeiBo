//
//  BAAccountTool.h
//  博爱微博
//
//  Created by boai on 15/8/5.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAAccount;

@interface BAAccountTool : NSObject

+ (void)saveAccount:(BAAccount *)account;

+ (BAAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end

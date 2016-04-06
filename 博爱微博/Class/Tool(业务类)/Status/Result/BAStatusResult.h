//
//  BAStatusResult.h
//  博爱微博
//
//  Created by boai on 15/8/14.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"


@interface BAStatusResult : NSObject <MJKeyValue>


/**
 *  用户的微博数组（CZStatus）
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int total_number;


@end

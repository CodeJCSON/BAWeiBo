//
//  BAUserResult.m
//  博爱微博
//
//  Created by boai on 15/8/19.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BAUserResult.h"

@implementation BAUserResult

/**
 *  消息的总和
 */
- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

/**
 *  未读数的总和
 */
- (int)totoalCount
{
    return self.messageCount + _status + _follower;
}



@end

//
//  BAStatusCell.h
//  博爱微博
//
//  Created by 博爱之家 on 15/8/27.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BAStatusFrame;

@interface BAStatusCell : UITableViewCell

@property (nonatomic, strong) BAStatusFrame *statusF;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

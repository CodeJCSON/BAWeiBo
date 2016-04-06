//
//  BANewFeatureCell.h
//  博爱微博
//
//  Created by boai on 15/8/5.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BANewFeatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end

//
//  UIImage+Image.m
//  博爱微博
//
//  Created by 孙博岩 on 15/7/27.
//  Copyright © 2015年 boai. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

// 加载最原始的图片
+ (instancetype)imageWithOrginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end

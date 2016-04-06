//
//  UIImage+Image.h
//  博爱微博
//
//  Created by 孙博岩 on 15/7/27.
//  Copyright © 2015年 boai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

// instancetype 默认识别当前是哪个类或者对象调用，就会转换成对应的类或对象

// 加载最原始的图片
+ (instancetype)imageWithOrginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end

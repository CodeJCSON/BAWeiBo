//
//  BARootTool.m
//  博爱微博
//
//  Created by boai on 15/8/5.
//  Copyright (c) 2015年 boai. All rights reserved.
//

#import "BARootTool.h"

#import "BATabBarController.h"
#import "BANewFeatureController.h"

#define BAVersionKey @"version"

@implementation BARootTool

// 选择根控制器
+ (void)chooseRootViewController:(UIWindow *)window
{
    // 1、获取当前版本号
    NSString *currentVerson = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2、 获取上一次版本号
    NSString *lastVerson = [[NSUserDefaults standardUserDefaults] objectForKey:BAVersionKey];
    
    // V1.0
    // 判断是否有新的版本
    if ([currentVerson isEqualToString:lastVerson])
    {
         // 没有最新的版本号
        //        创建tableBarVC
        BATabBarController *tabBarVC = [[BATabBarController alloc] init];
        
//        tabBarVC.view.backgroundColor = [UIColor redColor];
        
        // 设置窗口的根控制器
        window.rootViewController = tabBarVC;
    }
    else
    {
        // 如果有新特性，进入新特性界面
        BANewFeatureController *vc = [[BANewFeatureController alloc] init];
        
        window.rootViewController = vc;
        
        // 保持当前版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVerson forKey:BAVersionKey];
        
    }
}


@end

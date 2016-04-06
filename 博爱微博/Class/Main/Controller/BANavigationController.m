//
//  BANavigationController.m
//  博爱微博
//
//  Created by 孙博岩 on 15/8/1.
//  Copyright © 2015年 boai. All rights reserved.
//

#import "BANavigationController.h"
#import "UIBarButtonItem+Item.h"

@interface BANavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation BANavigationController

//+ (void)initialize
//{
//    // 获取当前类下面的UIBarButtonItem
//    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
//    
//    // 设置导航条按钮的文字颜色
//    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
//    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
//    
//    
//}
+ (void)initialize
{
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];;
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    // 实现滑动返回功能
    // 清空滑动返回手势代理
    self.interactivePopGestureRecognizer.delegate = nil;
    
    self.delegate = self;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 导航控制器即将显示的时候调用
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 获取主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    // 获取tabBarVC 的 rootViewController
    UITabBarController *tabBarVC = (UITabBarController *)keyWindow.rootViewController;
//    BALog(@"%@", tabBarVC.tabBar.subviews);
    
    // 移除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVC.tabBar.subviews)
    {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            [tabBarButton removeFromSuperview];
        }
    }

}

// 导航控制器跳转完成的时候调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    BALog(@"%@", self.viewControllers[0]);
    if (viewController == self.viewControllers[0])
    {
        // 显示根控制器
        // 返回滑动返回手势代理
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }
    else
    {
        // 实现滑动返回功能
        // 清空滑动返回手势代理
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
//    BALog(@"%s", __func__);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    BALog(@"%s", __func__);
    
    // 设置非根控制器导航条内容
    if (self.viewControllers.count != 0)
    {
        // 设置导航条的内容
        // 设置导航条左边 右边
        // 左边
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backToPre) forControlEvents:UIControlEventTouchUpInside];
        
        // 右边
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backToRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backToPre
{
    
    [self popViewControllerAnimated:YES];
}

- (void)backToRoot
{
    
    [self popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

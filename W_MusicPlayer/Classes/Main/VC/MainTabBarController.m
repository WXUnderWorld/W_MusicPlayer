//
//  MainTabBarController.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/11.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "MainTabBarController.h"
#import "MusicViewController.h"
#import "VideoViewController.h"
#import "MyViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addVC];
}

- (void)addVC
{
    [self createChildViewController:@"MusicViewController" selectImage:@"" defaultImage:@"" itemTitle:@"音乐"];
    [self createChildViewController:@"VideoViewController" selectImage:@"" defaultImage:@"" itemTitle:@"视频"];
    [self createChildViewController:@"MyViewController" selectImage:@"" defaultImage:@"" itemTitle:@"我的"];
}

- (void)createChildViewController:(NSString *)controllerName selectImage:(NSString *)selectImageName defaultImage:(NSString *)defaultImageName itemTitle:(NSString *)title
{
    Class className = NSClassFromString(controllerName);
    UIViewController *viewController = [[className alloc] init];
    viewController.tabBarItem.image = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:defaultImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.title = title;
    viewController.title = title;
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateNormal];
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]} forState:UIControlStateSelected];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];

}

// 根据颜色生成UIImage
- (UIImage*)imageWithColor:(UIColor*)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开始画图的上下文
    UIGraphicsBeginImageContext(rect.size);
    
    // 设置背景颜色
    [color set];
    // 设置填充区域
    UIRectFill(CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // 返回UIImage
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}



@end

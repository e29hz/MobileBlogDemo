//
//  MTUETabBarController.m
//  MTUserExperienceDemo
//
//  Created by 鄂鸿桢 on 16/8/23.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "MTUETabBarController.h"
#import "MTUEHomeViewController.h"

#define MTRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface MTUETabBarController ()<UITabBarControllerDelegate>



@end

@implementation MTUETabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildViewControllers];
}

- (void)addAllChildViewControllers {
    MTUEHomeViewController *home = [[MTUEHomeViewController alloc] init];
    [self addOneChildVc:home title:@"TRVAEL" imageName:@"tabbar_home" selectedImageName:@""];
    
    UIViewController *message = [[UIViewController alloc] init];
    [self addOneChildVc:message title:@"MESSAGE" imageName:@"tabbar_message_center" selectedImageName:@""];
    
    UIViewController *discover = [[UIViewController alloc] init];
    [self addOneChildVc:discover title:@"DISCOVERY" imageName:@"tabbar_discover" selectedImageName:@""];
    
    UIViewController *profile = [[UIViewController alloc] init];
    [self addOneChildVc:profile title:@"PROFILE" imageName:@"tabbar_profile" selectedImageName:@""];
}

+ (void)initialize {
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
}

- (void)addOneChildVc:(UIViewController *)childVc
                title:(NSString *)title
            imageName:(NSString *)imageName
    selectedImageName:(NSString *)selectedImageName {
//    childVc.view.backgroundColor = MTRandomColor;
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:navVc];
}

@end

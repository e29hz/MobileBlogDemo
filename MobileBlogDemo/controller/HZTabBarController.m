//
//  HZTabBarController.m
//  MobileBlogDemo
//
//  Created by 鄂鸿桢 on 16/8/29.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "HZTabBarController.h"
#import "HZHomeViewController.h"

#define HZRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

@interface HZTabBarController ()<UITabBarControllerDelegate>

@end

@implementation HZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildViewControllers];
}

- (void)addAllChildViewControllers {
    HZHomeViewController *home = [[HZHomeViewController alloc] init];
    [self addOneChildVc:home title:@"TRVAEL" imageName:@"tabbar_home"];
    
    UIViewController *message = [[UIViewController alloc] init];
    [self addOneChildVc:message title:@"MESSAGE" imageName:@"tabbar_message_center"];
    
    UIViewController *discover = [[UIViewController alloc] init];
    [self addOneChildVc:discover title:@"DISCOVERY" imageName:@"tabbar_discover"];
    
    UIViewController *profile = [[UIViewController alloc] init];
    [self addOneChildVc:profile title:@"PROFILE" imageName:@"tabbar_profile"];
}

+ (void)initialize {
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
}

- (void)addOneChildVc:(UIViewController *)childVc
                title:(NSString *)title
            imageName:(NSString *)imageName {
    childVc.view.backgroundColor = HZRandomColor;
    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    UINavigationController *navVc = [[UINavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:navVc];
}

@end

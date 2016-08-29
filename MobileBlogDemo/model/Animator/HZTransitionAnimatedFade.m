//
//  HZTransitionAnimatedFade.m
//  MobileBlogDemo
//
//  Created by 鄂鸿桢 on 16/8/29.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "HZTransitionAnimatedFade.h"

@implementation HZTransitionAnimatedFade
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [[transitionContext containerView] addSubview:toVC.view];
    
    toVC.view.alpha = 0.0f;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:0
                     animations:^{
                         toVC.view.alpha = 1.0f;
                         if (_dissmissal) {
                             fromVC.view.alpha = 0.0f;
                         }
                     } completion:^(BOOL finished) {
                         if (!_dissmissal) {
                             fromVC.view.alpha = 0.0f;
                         }
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}
@end

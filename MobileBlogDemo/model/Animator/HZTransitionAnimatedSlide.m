//
//  HZTransitionAnimatedSlide.m
//  MobileBlogDemo
//
//  Created by 鄂鸿桢 on 16/8/29.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "HZTransitionAnimatedSlide.h"

@implementation HZTransitionAnimatedSlide
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    [containerView setBackgroundColor:[UIColor whiteColor]];
    [containerView addSubview:toVC.view];
    if (_dissmissal) {
        [containerView addSubview:fromVC.view];
    } else {
        [containerView setBackgroundColor:[UIColor whiteColor]];
         [containerView addSubview:toVC.view];
    }
    CGRect fromFrame = fromVC.view.frame;
    CGRect toFrame = toVC.view.frame;
    if (_dissmissal) {
        fromFrame.origin.y = containerView.frame.size.height;
        toFrame.origin.y = -containerView.frame.size.height;
    } else {
        fromFrame.origin.y = -fromFrame.size.height;
        toFrame.origin.y = containerView.frame.size.height;
    }
    
    [toVC.view setFrame:toFrame];
    toFrame.origin.y = 0;
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:0
                     animations:^{
                         [fromVC.view setFrame:fromFrame];
                         [toVC.view setFrame:toFrame];
                     } completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
    
}
@end

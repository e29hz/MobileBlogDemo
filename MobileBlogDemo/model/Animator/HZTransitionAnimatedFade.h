//
//  HZTransitionAnimatedFade.h
//  MobileBlogDemo
//
//  Created by 鄂鸿桢 on 16/8/29.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HZTransitionAnimatedFade : NSObject<UIViewControllerAnimatedTransitioning>
/**
 *  用于判断转场时机
 */
@property (nonatomic, assign) BOOL dissmissal;

@end

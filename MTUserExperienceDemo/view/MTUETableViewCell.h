//
//  MTUETableViewCell.h
//  MTUserExperienceDemo
//
//  Created by 鄂鸿桢 on 16/8/24.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTUETableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIView *customBackgroundView;


@property (nonatomic, assign) BOOL isBackward;

@end

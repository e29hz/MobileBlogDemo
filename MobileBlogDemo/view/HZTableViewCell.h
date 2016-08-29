//
//  HZTableViewCell.h
//  MobileBlogDemo
//
//  Created by 鄂鸿桢 on 16/8/29.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UIView *customBackgroundView;

@property (nonatomic, assign) BOOL isBackward;
@end

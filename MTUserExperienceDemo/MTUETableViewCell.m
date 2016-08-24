//
//  MTUETableViewCell.m
//  MTUserExperienceDemo
//
//  Created by 鄂鸿桢 on 16/8/24.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "MTUETableViewCell.h"

const CGFloat kTextLabelWidth  = 200.0f;
const CGFloat kTextLabelHeight = 30.0f;

@implementation MTUETableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:NO];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - kTextLabelWidth / 2, self.frame.origin.y + self.frame.size.height, kTextLabelWidth, kTextLabelHeight)];
    [self addSubview:self.titleLabel];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:22.0f];
}

@end

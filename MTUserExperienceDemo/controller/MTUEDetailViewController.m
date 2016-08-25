//
//  MTUEDetailViewController.m
//  MTUserExperienceDemo
//
//  Created by 鄂鸿桢 on 16/8/24.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "MTUEDetailViewController.h"
#import "MTUEDetailBottomView.h"
#import "MTUECommentTableViewController.h"

@interface MTUEDetailViewController ()

@end

@implementation MTUEDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBottomView];
    [self setupBackgroundImageView];
}

- (void)setupBottomView {
    CGRect frame = CGRectMake(0, self.view.bounds.size.height - 50, self.view.bounds.size.width, 50);
    MTUEDetailBottomView *bottomView = [[[NSBundle mainBundle] loadNibNamed:@"MTUEDetailBottom" owner:self options:nil] firstObject];
    bottomView.frame = frame;
//    bottomView.commentButton.im
    [self.view addSubview:bottomView];
    [bottomView.closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.commentButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupBackgroundImageView {
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 50);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_2624"]];
    imageView.frame  = frame;
    [self.view addSubview:imageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)close:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)comment:(UIButton *)button {
    MTUECommentTableViewController *commentTableViewController = [[MTUECommentTableViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:commentTableViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end

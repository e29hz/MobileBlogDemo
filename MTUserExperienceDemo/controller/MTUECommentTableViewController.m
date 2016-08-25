//
//  MTUECommentTableViewController.m
//  MTUserExperienceDemo
//
//  Created by 鄂鸿桢 on 16/8/25.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "MTUECommentTableViewController.h"

@interface MTUECommentTableViewController ()

@end

@implementation MTUECommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"nav_close_icon@3x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    button.bounds = CGRectMake(0, 0, 50, 50);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)close:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end

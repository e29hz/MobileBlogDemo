//
//  HZCommentViewController.m
//  MobileBlogDemo
//
//  Created by 鄂鸿桢 on 16/8/29.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "HZCommentViewController.h"
#define HZRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]


@interface HZCommentViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, assign) BOOL displayed;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HZCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:@"nav_close_icon@3x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    button.bounds = CGRectMake(0, 0, 50, 50);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.displayed = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.displayed = YES;
}

- (void)close:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                                   reuseIdentifier:@"comment"];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    cell.textLabel.text = [NSString stringWithFormat:@"COMMENT : %ld", (long)indexPath.row];
    cell.backgroundColor = HZRandomColor;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= 0 && indexPath.row <= 3 && !_displayed) {
        cell.transform = CGAffineTransformMakeTranslation(0, cell.frame.origin.y + 50);
    } else {
        cell.transform = CGAffineTransformMakeTranslation(0, 50);
    }
    //    NSLog(@"%f, %ld", cell.frame.origin.y, indexPath.row);
    cell.alpha = 0.5;
    [UIView animateWithDuration:0.7
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         cell.transform = CGAffineTransformMakeTranslation(0, 0);
                         cell.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
}


@end

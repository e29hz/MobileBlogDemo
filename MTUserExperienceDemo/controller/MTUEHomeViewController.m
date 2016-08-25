//
//  MTUEHomeViewController.m
//  MTUserExperienceDemo
//
//  Created by 鄂鸿桢 on 16/8/24.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "MTUEHomeViewController.h"
#import "UIColor+MTUserExperience.h"
#import "MTUETableViewCell.h"
#import "MTUEDetailViewController.h"
#import "MTUEDismissTransitionAnimated.h"
#import "MTUEPresentTransitionAnimated.h"

@interface MTUEHomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UIViewControllerTransitioningDelegate
>

@property (nonatomic, assign) CGFloat       currentSelection;
@property (nonatomic, strong) NSArray       *imageNameArray;
@property (nonatomic, strong) NSArray       *colorsArray;
@property (nonatomic, strong) NSArray       *namesArray;
@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSIndexPath   *currentSelectIndexPath;
@property (nonatomic, strong) UIColor       *currentColor;
@property (nonatomic, assign) BOOL          backward;

@end

@implementation MTUEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.backward = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                  style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.imageNameArray = @[@"social-dribbble-outline", @"social-github", @"social-dropbox", @"social-instagram", @"ios7-cloudy"];
    self.colorsArray = @[[UIColor DribbbleColor], [UIColor GithubColor], [UIColor DropboxColor], [UIColor InstagramColor], [UIColor CloudyColor]];
    self.namesArray = @[@"Dribbble", @"GitHub", @"Dropbox", @"Instagram", @"Cloudy"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.currentSelection = -1;
    NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 44, 0);
    [self performSelector:@selector(animationBackToOrigin) withObject:nil afterDelay:0.0f];

    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)animationBackToOrigin {
    if (self.backward && self.currentSelectIndexPath) {
        if (!self.tableView.editing) {
            [self.tableView beginUpdates];
            NSIndexPath *indexPath = self.currentSelectIndexPath;
            MTUETableViewCell *cell = (MTUETableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [UIView animateWithDuration:0.3f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0.0f, 0.0f);
                                 self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0.0f, 0.0f);
                                 cell.backgroundColor = self.currentColor;
                                 cell.alpha = 1.0f;
                             } completion:^(BOOL finished) {
                                 [self animationCompleted];
                             }];
            [self.tableView endUpdates];
            [self.tableView scrollToRowAtIndexPath:indexPath
                                  atScrollPosition:UITableViewScrollPositionMiddle
                                          animated:YES];
        }
    }
}

- (void)animationCompleted {
    self.currentColor = nil;
    self.backward = NO;
    self.currentSelection = -1;
    self.tableView.scrollEnabled = YES;
    self.tableView.allowsSelection = YES;
}

- (void)animatingTransitionForTableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath {
    if (!tableView.editing) {
        [tableView beginUpdates];
        self.currentSelectIndexPath = indexPath;
        self.currentSelection = indexPath.row;
        MTUETableViewCell *cell = (MTUETableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.navigationController.navigationBar.transform = CGAffineTransformMakeTranslation(0.0f,
                                                                                    -self.navigationController.navigationBar.bounds.size.height);
                             self.tabBarController.tabBar.transform = CGAffineTransformMakeTranslation(0.0f, self.tabBarController.tabBar.bounds.size.height);
                             self.currentColor = cell.backgroundColor;
                             [self transitionBetWeenViewController];
                         } completion:^(BOOL finished) {
                             self.backward = YES;
                             tableView.scrollEnabled = NO;
                             tableView.allowsSelection = NO;
                         }];
        [tableView endUpdates];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void)transitionBetWeenViewController {
    MTUEDetailViewController *detailViewController = [[MTUEDetailViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    navigationController.transitioningDelegate = self;
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MTUETableViewCell" owner:self options:nil];
    MTUETableViewCell *cell = [topLevelObjects objectAtIndex:0];
    cell.customBackgroundView.backgroundColor = self.colorsArray[indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:[self.imageNameArray objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.backward) {
        if (indexPath.row == self.currentSelection) {
            return self.view.bounds.size.height;
        } else {
            return 160.0f;
        }
    } else {
        return  160.0f;
    }
}

#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView performSelectorOnMainThread:@selector(deselectRowAtIndexPath:animated:)
                                withObject:indexPath
                             waitUntilDone:NO];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self animatingTransitionForTableView:tableView rowAtIndexPath:indexPath];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return [[MTUEPresentTransitionAnimated alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[MTUEDismissTransitionAnimated alloc] init];
}

@end

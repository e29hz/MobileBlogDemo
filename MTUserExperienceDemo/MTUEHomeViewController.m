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

@interface MTUEHomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, assign) CGFloat         currentSelection;
@property (nonatomic, strong) NSArray         *imageNameArray;
@property (nonatomic, strong) UILabel         *textLabel;
@property (nonatomic, strong) NSArray         *colorsArray;
@property (nonatomic, strong) NSArray         *namesArray;
@property (nonatomic, strong) UITableView     *tableView;
@property (nonatomic, assign, readwrite) BOOL isBackward;
@property (nonatomic, strong) NSIndexPath     *currentSelectIndexPath;
@property (nonatomic, assign, readwrite) BOOL backWard;



@end

@implementation MTUEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backWard = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                  style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.contentInset = UIEdgeInsetsMake(44, 0, 0, 0);
    [self.view addSubview:self.tableView];
    self.imageNameArray = @[@"social-dribbble-outline", @"social-github", @"social-dropbox", @"social-instagram", @"ios7-cloudy"];
    self.colorsArray = @[[UIColor DribbbleColor], [UIColor GithubColor], [UIColor DropboxColor], [UIColor InstagramColor], [UIColor CloudyColor]];
    self.namesArray = @[@"Dribbble", @"GitHub", @"Dropbox", @"Instagram", @"Cloudy"];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.currentSelection = -1;

    NSIndexPath *selection = [self.tableView indexPathForSelectedRow];
    if (selection) {
        [self.tableView deselectRowAtIndexPath:selection animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self performSelector:@selector(animationBackToOrigin) withObject:nil afterDelay:0.7f];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)animationBackToOrigin {
    if (self.isBackward && self.currentSelectIndexPath) {
        if (!self.tableView.editing) {
            [self.tableView beginUpdates];
            NSIndexPath *indexPath = self.currentSelectIndexPath;
            MTUETableViewCell *cell = (MTUETableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            [UIView animateWithDuration:0.3f
                                  delay:0.0f
                                options:UIViewAnimationOptionCurveEaseInOut
                             animations:^{
                                 cell.iconImage.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                                 CGRect iconImageRect = cell.iconImage.frame;
                                 UILabel *label = cell.titleLabel;
                                 CGRect labelRect = CGRectMake(label.frame.origin.x,
                                                               iconImageRect.origin.y + iconImageRect.size.height + 10 + self.view.frame.size.height,
                                                               label.frame.size.width,
                                                               label.frame.size.height);
                                 [cell.titleLabel setFrame:labelRect];
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
    self.isBackward = NO;
    self.currentSelection = -1;
    self.textLabel = nil;
    self.tableView.scrollEnabled = YES;
    self.tableView.allowsSelection = YES;
}

- (void)animatingTransitionForTableView:(UITableView *)tableView rowAtIndexPath:(NSIndexPath *)indexPath {
    if (!tableView.editing) {
        [tableView beginUpdates];
        self.currentSelectIndexPath = indexPath;
        self.currentSelection = indexPath.row;
        MTUETableViewCell *cell = (MTUETableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        [UIView animateWithDuration:0.5f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             cell.iconImage.transform = CGAffineTransformMakeScale(2.0, 2.0);
                         } completion:^(BOOL finished) {
                             CGRect iconImageRect = cell.iconImage.frame;
                             cell.titleLabel.text = self.namesArray[indexPath.row];
                             [UIView animateWithDuration:0.4f animations:^{
                                 UILabel *label = cell.titleLabel;
                                 CGRect labelRect = CGRectMake(label.frame.origin.x,
                                                               iconImageRect.origin.y + iconImageRect.size.height + 10,
                                                               label.frame.size.width,
                                                               label.frame.size.width);
                                 [cell.titleLabel setFrame:labelRect];
                             } completion:^(BOOL finished) {
                                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     [self transitionBetWeenViewControllers];
                                 });
                                 self.isBackward = YES;
                                 tableView.scrollEnabled = NO;
                                 tableView.allowsSelection = NO;
                             }];
                         }];
        [tableView endUpdates];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

- (void)transitionBetWeenViewControllers {
    UIViewController *detailViewController = [[UIViewController alloc] init];
    detailViewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailViewController animated:NO];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MTUETableViewCell" owner:self options:nil];
    MTUETableViewCell *cell = [topLevelObjects objectAtIndex:0];
    cell.backgroundColor = self.colorsArray[indexPath.row];
    cell.iconImage.image = [UIImage imageNamed:[self.imageNameArray objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.backWard) {
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
    [self animatingTransitionForTableView:tableView rowAtIndexPath:indexPath];
}

@end

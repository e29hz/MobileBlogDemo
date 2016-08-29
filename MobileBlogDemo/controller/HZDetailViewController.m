//
//  HZDetailViewController.m
//  MobileBlogDemo
//
//  Created by 鄂鸿桢 on 16/8/29.
//  Copyright © 2016年 e29hz. All rights reserved.
//

#import "HZDetailViewController.h"
#import "HZDetailBottomView.h"
#import "HZCommentViewController.h"
#import "HZTransitionAnimatedSlide.h"

@interface HZDetailViewController ()
<
UIViewControllerTransitioningDelegate,
UIScrollViewDelegate
>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) HZDetailBottomView *bottomView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) UISwipeGestureRecognizer *fromRightSwip;
@property (nonatomic, strong) UISwipeGestureRecognizer *fromLeftSwip;

@end

@implementation HZDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configArray];
    [self configTapGes];
    [self setupBottomView];
    [self setupBackgroundImageView];
    [self setupTitleLabel];
    [self setupLabel];
}
#pragma mark - setup
- (void)configArray {
    self.array = @[@"",
                   @"不管全世界所有人怎么说，\n我都认为自己的感受才是正确的，\n无论别人怎么看，\n我绝不打乱自己的节奏，\n喜欢的事自然可以坚持，\n不喜欢怎么也长久不了",
                   @"哪里会有人喜欢孤独，\n不过是不喜欢失望",
                   @"我或许败北，\n或许迷失自己，\n或许哪里也抵达不了，\n或许我已失去一切，\n任凭怎么挣扎也只能徒呼奈何，\n或许我只是徒然掬一把废墟灰烬，\n唯我一人蒙在鼓里，\n或许这里没有任何人把赌注下在我身上。",
                   @"刚刚好，看见你幸福的样子，\n于是幸福着你的幸福。",
                   @"不要同情自己，\n同情自己是卑劣懦夫干的勾当。",
                   @"我们的正常之处，\n就在于自己懂得自己的不正常。",
                   @"不存在十全十美的文章，\n如同不存在彻头彻尾的绝望。",
                   @"少年时我们追求激情，\n成熟后却迷恋平庸，\n在我们寻找，伤害，背离之后，\n还能一如既往的相信爱情，\n这是一种勇气。"];
}

- (void)configTapGes {
    _fromRightSwip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextPage)];
    _fromRightSwip.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:_fromRightSwip];
    
    _fromLeftSwip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(forwardPage)];
    _fromLeftSwip.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:_fromLeftSwip];
}

- (void)setupLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 64, self.view.frame.size.width - 40, self.view.frame.size.height - 128)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    NSString *labelText = [self.array objectAtIndex:0];
    [label setFont:[UIFont fontWithName:@"WenyueType GutiFangsong (Noncommercial Use)" size:20]];
    label.attributedText = [self attributedStringWithString:labelText];
    [self.imageView addSubview:label];
    self.label = label;
}

- (NSAttributedString *)attributedStringWithString:(NSString *)string {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:30];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    return attributedString;
}

- (void)setupBottomView {
    CGRect frame = CGRectMake(0, self.view.bounds.size.height - 46, self.view.bounds.size.width, 46);
    HZDetailBottomView *bottomView = [[[NSBundle mainBundle] loadNibNamed:@"HZDetailBottomView" owner:self options:nil] firstObject];
    bottomView.frame = frame;
    bottomView.pageLabel.text = [NSString stringWithFormat:@"%ld of %lu", self.count + 1, (unsigned long)self.array.count];
    [self.view addSubview:bottomView];
    [bottomView.closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView.commentButton addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    self.bottomView = bottomView;
}

- (void)setupBackgroundImageView {
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 46);
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_2624"]];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.frame  = frame;
    [self.view addSubview:imageView];
    self.imageView = imageView;
}

- (void)setupTitleLabel {
    UILabel *titleLabel = [[UILabel alloc]
                           initWithFrame:CGRectMake(20,
                                                    self.view.bounds.size.height / 3,
                                                    self.view.frame.size.width - 40,
                                                    self.view.frame.size.height * 2 / 3)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont boldSystemFontOfSize:45];
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.text = @"\nTHE\nDARK SIDE\nOF THE\nDIGITAL\nNOMAD";
    
    [self.imageView addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - action
- (void)close:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)comment:(UIButton *)button {
    HZCommentViewController *commentViewController = [[HZCommentViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:commentViewController];
    navigationController.transitioningDelegate = self;
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - 翻页响应事件
- (void)nextPage {
    if (self.count < self.array.count-1) {
        self.label.attributedText = [self attributedStringWithString:[self.array objectAtIndex:self.count+1]];
        NSString *subtypeString = kCATransitionFromRight;
        [self transitionWithType:kCATransitionMoveIn subtype:subtypeString forView:self.imageView];
        self.count = self.count + 1;
    } else {
        self.count = self.array.count - 1;
        [self showAlert:@"已经是最后一页咯"];
    }
    self.bottomView.pageLabel.text = [NSString stringWithFormat:@"%ld of %lu", self.count + 1, (unsigned long)self.array.count];
    [self changeImage];
}

- (void)forwardPage {
    if (self.count > 0 ) {
        self.label.attributedText = [self attributedStringWithString:[self.array objectAtIndex:self.count-1]];
        NSString *subtypeString = kCATransitionFromLeft;
        [self transitionWithType:kCATransitionReveal subtype:subtypeString forView:self.imageView];
        self.count = self.count - 1;
    } else {
        self.count = 0;
        [self showAlert:@"已经是第一页咯"];
    }
    self.bottomView.pageLabel.text = [NSString stringWithFormat:@"%ld of %lu", self.count + 1, (unsigned long)self.array.count];
    [self changeImage];
}

- (void)changeImage {
    if (self.count == 0) {
        [self.imageView setImage:[UIImage imageNamed:@"IMG_2624"]];
        self.titleLabel.hidden = NO;
    } else {
        self.imageView.image = nil;
        self.titleLabel.hidden = YES;
    }
}

#pragma CATransition动画实现
/**
 *  动画效果实现
 */
- (void)transitionWithType:(NSString *)type subtype:(NSString *)subtype forView:(UIView *)view {
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.type = type;
    if (subtype != nil) {
        animation.subtype = subtype;
    }
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - alertView提示
- (void)showAlert:(NSString *)message {
    UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertControler addAction: [UIAlertAction actionWithTitle: @"确定" style: UIAlertActionStyleCancel handler:nil]];
    [self presentViewController: alertControler animated: YES completion: nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    HZTransitionAnimatedSlide *transitionAnimatedSlide = [[HZTransitionAnimatedSlide alloc] init];
    transitionAnimatedSlide.dissmissal = NO;
    return transitionAnimatedSlide;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    HZTransitionAnimatedSlide *transitionAnimatedSlide = [[HZTransitionAnimatedSlide alloc] init];
    transitionAnimatedSlide.dissmissal = YES;
    return transitionAnimatedSlide;
}
@end

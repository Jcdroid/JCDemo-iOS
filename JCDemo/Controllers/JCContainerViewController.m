//
//  JCContainerViewController.m
//  JCDemo
//
//  Created by mac on 15/12/10.
//  Copyright © 2015年 Jcdroid. All rights reserved.
//

#import "JCContainerViewController.h"
#import "JCChildOneViewController.h"
#import "JCAnimator.h"

@interface PrivateTransitionContext : NSObject <UIViewControllerContextTransitioning>

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight; /// Designated initializer.
@property (nonatomic, copy) void (^completionBlock)(BOOL didComplete); /// A block of code we can set to execute after having received the completeTransition: message.
@property (nonatomic, assign, getter=isAnimated) BOOL animated; /// Private setter for the animated property.
@property (nonatomic, assign, getter=isInteractive) BOOL interactive; /// Private setter for the interactive property.

@end

@interface PrivateAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>

@end


@interface JCContainerViewController ()

@property (strong, nonatomic) NSArray *controllers;

@property (nonatomic, strong) UIView *privateButtonsView; /// The view hosting the buttons of the child view controllers.
@property (nonatomic, strong) UIView *privateContainerView; /// The view hosting the child view controllers views.

@end

@implementation JCContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.privateContainerView = [[UIView alloc] initWithFrame:self.view.frame];
    self.privateContainerView.backgroundColor = [UIColor blackColor];
    self.privateContainerView.opaque = YES;
    [self.view addSubview:self.privateContainerView];
    
    self.privateButtonsView = [[UIView alloc] initWithFrame:self.view.frame];
    self.privateButtonsView.backgroundColor = [UIColor clearColor];
    self.privateButtonsView.tintColor = [UIColor colorWithWhite:1 alpha:0.75f];
    [self.view addSubview:self.privateButtonsView];
    
    CGFloat x = 100;
    CGFloat y = 100;
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@(i).stringValue forState:UIControlStateNormal];
        button.frame = CGRectMake(x, y, 40, 40);
        button.tag = i;
        [button addTarget:self action:@selector(showVC:) forControlEvents:UIControlEventTouchUpInside];
        [self.privateButtonsView addSubview:button];
        x += 50;
    }
    
    JCChildOneViewController *vc1 = [JCChildOneViewController initWithColor:[UIColor colorWithRed:0.256 green:0.709 blue:1.000 alpha:1.000]];
    JCChildOneViewController *vc2 = [JCChildOneViewController initWithColor:[UIColor colorWithRed:1.000 green:0.769 blue:0.332 alpha:1.000]];
    JCChildOneViewController *vc3 = [JCChildOneViewController initWithColor:[UIColor colorWithRed:0.650 green:0.505 blue:1.000 alpha:1.000]];
    
    _controllers = @[vc1, vc2, vc3];
    
    [self transitionToViewController:_controllers[0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showVC:(UIButton *)button {
    NSInteger tag = button.tag;
    
    UIViewController *toVC = _controllers[tag];
    [self transitionToViewController:toVC];
}

- (void)transitionToViewController:(UIViewController *)toViewController {
    UIViewController *fromViewController = self.childViewControllers.count > 0 ? self.childViewControllers.firstObject : nil;
    if (toViewController == fromViewController || ![self isViewLoaded]) {
        return;
    }
    
    [fromViewController willMoveToParentViewController:self];
    [self addChildViewController:toViewController];
    
    if (!fromViewController) {
        [self.privateContainerView addSubview:toViewController.view];
        [toViewController didMoveToParentViewController:self];
        return;
    }
    
    
    // 1
    // JCAnimator *animator1 = [[JCAnimator alloc] init];
    
    // 2
    id <UIViewControllerAnimatedTransitioning> animator = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(containerViewController:animationControllerForTransitionFromViewController:toViewController:)]) {
        animator = [self.delegate containerViewController:self animationControllerForTransitionFromViewController:fromViewController toViewController:toViewController];
    }
    animator = (animator ?: [[PrivateAnimatedTransition alloc] init]);
    
    NSUInteger fromIndex = [self.controllers indexOfObject:fromViewController];
    NSUInteger toIndex = [self.controllers indexOfObject:toViewController];
    PrivateTransitionContext *transitionContext = [[PrivateTransitionContext alloc] initWithFromViewController:fromViewController toViewController:toViewController goingRight:toIndex > fromIndex];
    
    transitionContext.animated = YES;
    transitionContext.interactive = NO;
    transitionContext.completionBlock = ^(BOOL finished) {
        [fromViewController.view removeFromSuperview];
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        
        if ([animator respondsToSelector:@selector(animationEnded:)]) {
            [animator animationEnded:finished];
        }
        self.privateButtonsView.userInteractionEnabled = YES;
    };
    
    self.privateButtonsView.userInteractionEnabled = NO;
    [animator animateTransition:transitionContext];
    
}

@end

#pragma mark - Private Transitioning Classes

@interface PrivateTransitionContext ()

@property (nonatomic, strong) NSDictionary *privateViewControllers;
@property (nonatomic, assign) CGRect privateDisappearingFromRect;
@property (nonatomic, assign) CGRect privateAppearingFromRect;
@property (nonatomic, assign) CGRect privateDisappearingToRect;
@property (nonatomic, assign) CGRect privateAppearingToRect;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;

@end

@implementation PrivateTransitionContext

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight {
    NSAssert ([fromViewController isViewLoaded] && fromViewController.view.superview, @"The fromViewController view must reside in the container view upon initializing the transition context.");
    
    if ((self = [super init])) {
        self.presentationStyle = UIModalPresentationCustom;
        self.containerView = fromViewController.view.superview;
        self.privateViewControllers = @{
                                        UITransitionContextFromViewControllerKey:fromViewController,
                                        UITransitionContextToViewControllerKey:toViewController,
                                        };
        
        // Set the view frame properties which make sense in our specialized ContainerViewController context. Views appear from and disappear to the sides, corresponding to where the icon buttons are positioned. So tapping a button to the right of the currently selected, makes the view disappear to the left and the new view appear from the right. The animator object can choose to use this to determine whether the transition should be going left to right, or right to left, for example.
        CGFloat travelDistance = (goingRight ? -self.containerView.bounds.size.width : self.containerView.bounds.size.width);
        self.privateDisappearingFromRect = self.privateAppearingToRect = self.containerView.bounds;
        self.privateDisappearingToRect = CGRectOffset (self.containerView.bounds, travelDistance, 0);
        self.privateAppearingFromRect = CGRectOffset (self.containerView.bounds, -travelDistance, 0);
    }
    
    return self;
}

- (CGRect)initialFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.privateDisappearingFromRect;
    } else {
        return self.privateAppearingFromRect;
    }
}

- (CGRect)finalFrameForViewController:(UIViewController *)viewController {
    if (viewController == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.privateDisappearingToRect;
    } else {
        return self.privateAppearingToRect;
    }
}

- (UIViewController *)viewControllerForKey:(NSString *)key {
    return self.privateViewControllers[key];
}

- (void)completeTransition:(BOOL)didComplete {
    if (self.completionBlock) {
        self.completionBlock (didComplete);
    }
}

- (BOOL)transitionWasCancelled { return NO; } // Our non-interactive transition can't be cancelled (it could be interrupted, though)

// Supress warnings by implementing empty interaction methods for the remainder of the protocol:

- (void)updateInteractiveTransition:(CGFloat)percentComplete {}
- (void)finishInteractiveTransition {}
- (void)cancelInteractiveTransition {}

@end

@implementation PrivateAnimatedTransition

static CGFloat const kChildViewPadding = 16;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    BOOL goingRight = ([transitionContext initialFrameForViewController:toViewController].origin.x < [transitionContext initialFrameForViewController:fromViewController].origin.x);
    CGFloat travelDistance = [transitionContext containerView].bounds.size.width + kChildViewPadding;
    CGAffineTransform travel = CGAffineTransformMakeTranslation(goingRight ? travelDistance : -travelDistance, 0);
    
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    toViewController.view.transform = CGAffineTransformInvert(travel);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = travel;
        fromViewController.view.alpha = 0;
        toViewController.view.transform = CGAffineTransformIdentity;
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:[transitionContext transitionWasCancelled]];
    }];
}

@end
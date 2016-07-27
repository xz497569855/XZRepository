//
//  OneViewController.m
//  UISearchController
//
//  Created by mc on 16/5/31.
//  Copyright © 2016年 www.xz.com. All rights reserved.
//

#import "OneViewController.h"
#import "Masonry.h"
#import "GLViewController.h"
#import "GiftViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height


@interface OneViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UISegmentedControl *seg;
@end

@implementation OneViewController

- (UIScrollView *)scrollView {
    if(!_scrollView) {
        
    }
    return _scrollView;
}
- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:animated];
//    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
//    NSLog(@"%@",NSStringFromCGRect([self.childViewControllers[0] tableView].frame));
//    NSLog(@"%@",NSStringFromCGRect(self.childViewControllers[0].view.frame));
//    NSLog(@"%@",NSStringFromCGRect(self.scrollView.frame));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self initFace];
    
    [self addChildVc];
}


#pragma mark - Views
- (void)setupNav {
    self.seg = [[UISegmentedControl alloc] initWithItems:@[@"攻略",@"礼物"]];
    self.seg.frame = CGRectMake(0, 0, 150, 20);
    self.seg.selectedSegmentIndex = 0;
    self.seg.tintColor = [UIColor whiteColor];
    [self.seg addTarget:self action:@selector(segmentedControlDidChange:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.seg;
}

- (void)initFace {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64 - 44)];
    _scrollView.contentSize = CGSizeMake(kWidth * 2, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
}

- (void)addChildVc {
    
    GLViewController *glVc = [[GLViewController alloc] initWithTableView:YES];
    GiftViewController *giftVc = [[GiftViewController alloc] init];
    
    [self addChildViewController:glVc];
    [self addChildViewController:giftVc];
    
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
}

#pragma mark - Actions
- (void)segmentedControlDidChange:(UISegmentedControl *)seg {
    if (seg.selectedSegmentIndex == 0)
    {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else
    {
        [_scrollView setContentOffset:CGPointMake(kWidth, 0) animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate
//scrollView在滑动时调用（调用很频繁）
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
}

//
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    
    int index = scrollView.contentOffset.x / width;
    self.seg.selectedSegmentIndex = index;
    
    UIViewController *showVc = self.childViewControllers[index];
    
    if ([showVc isViewLoaded]) return;
    
    showVc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, width, height);
    [scrollView addSubview:showVc.view];
    
}
//scrollView停止滚动时调用(用手滑动结束时才会调用，改变scrollView的ContentOffset导致的滑动结束不会调用)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}



@end

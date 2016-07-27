//
//  MainViewController.m
//  UISearchController
//
//  Created by mc on 16/5/31.
//  Copyright © 2016年 www.xz.com. All rights reserved.
//

#import "MainViewController.h"
#import "LFNavigationController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "CustomTabbar.h"

@interface MainViewController ()
@property (nonatomic,strong)NSArray *childVc;
@property (nonatomic,strong)NSArray *controllterTitles;
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,strong)NSArray *selectedImages;
@end

@implementation MainViewController

#pragma mark - getter

-(NSArray *)childVc {
    if (_childVc == nil) {
        _childVc = @[
                        [[OneViewController alloc] init],
                        [[TwoViewController alloc] init],
                        [[ThreeViewController alloc] init],
                        [[FourViewController alloc] init],
                    ];
    }
    return _childVc;
}

-(NSArray *)controllterTitles {
    if (_controllterTitles == nil) {
        _controllterTitles = @[@"One",@"Two",@"Three",@"Four"];
    }
    return _controllterTitles;
}

-(NSArray *)images {
    if (_images == nil) {
        _images = @[@"8",@"8",@"8",@"8"];
    }
    return _images;
}

-(NSArray *)selectedImages {
    if (_selectedImages == nil) {
        _selectedImages = @[@"4",@"4",@"4",@"4"];
    }
    return _selectedImages;
}

//-(void)setControllterTitles:(NSArray *)controllterTitles {
//    if (_controllterTitles != controllterTitles) {
//        _controllterTitles = controllterTitles;
//    }
//}



- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
    [self addChildVc];
    
}

- (void)addChildVc {
    //appearance
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    for (NSInteger i = 0; i < self.childVc.count; i++) {
        [self setupChildVc:self.childVc[i] title:self.controllterTitles[i] image:self.images[i] selectedImage:self.selectedImages[i]];
    }
    
    //[self setValue:[[CustomTabbar alloc] init] forKeyPath:@"tabBar"];
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    vc.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:image];
    
    //方法一：设置不渲染，使用原始图片
//    UIImage *imageOriginal = [UIImage imageNamed:selectedImage];
//    imageOriginal = [imageOriginal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc.tabBarItem.selectedImage = imageOriginal;
    //方法二：找到图片，去设置图片Render As为Original Image
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    LFNavigationController *nav = [[LFNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}


@end

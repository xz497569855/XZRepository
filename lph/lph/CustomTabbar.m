//
//  CustomTabbar.m
//  UISearchController
//
//  Created by mc on 16/5/31.
//  Copyright © 2016年 www.xz.com. All rights reserved.
//

#import "CustomTabbar.h"

@implementation CustomTabbar

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

//- (void)layoutSubviews {
//    
//    [super layoutSubviews];
//    
//    //设置其他UITabBarButton的frame
//    CGFloat buttonY = 0;
//    CGFloat buttonW = self.frame.size.width / 5;
//    CGFloat buttonH = self.frame.size.height;
//    NSInteger index = 0;
//    for (UIView *button in self.subviews) {
//        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
//        
//        //计算按钮的x值
//        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        index++;
//    }
//    
//}

@end

//
//  SubcategoriesCell.h
//  lph
//
//  Created by mc on 16/7/25.
//  Copyright © 2016年 www.xz.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class subcategoriesModel;
@interface SubcategoriesCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageViews;

@property (nonatomic, strong) subcategoriesModel *subModel;


@end

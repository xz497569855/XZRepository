//
//  SubcategoriesCell.m
//  lph
//
//  Created by mc on 16/7/25.
//  Copyright © 2016年 www.xz.com. All rights reserved.
//

#import "SubcategoriesCell.h"
#import "subcategoriesModel.h"
#import "UIImageView+WebCache.h"

@implementation SubcategoriesCell

//相对高
#define XHIGHT [UIScreen mainScreen].bounds.size.height/667
//相对宽
#define XWIDTH [UIScreen mainScreen].bounds.size.width/375
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [[UILabel alloc] init];
        self.imageViews = [[UIImageView alloc] init];
        [self addSubview:self.label];
        [self addSubview:self.imageViews];
    }
    return self;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.imageViews.frame = CGRectMake(XWIDTH * 12, 0, self.frame.size.height -  XHIGHT *20 , self.frame.size.height - XHIGHT *20);
    
    self.label.frame = CGRectMake(0, CGRectGetMaxY(self.imageViews.frame), self.frame.size.width, 20);
    
}

- (void)setSubModel:(subcategoriesModel *)subModel {
    if (_subModel != subModel) {
        _subModel = subModel;
    
        [self.imageViews sd_setImageWithURL:[NSURL URLWithString:subModel.icon_url]];
        self.label.text = subModel.name;
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:13];
    }
}
@end

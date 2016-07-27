//
//  categoriesModel.h
//  lph
//
//  Created by mc on 16/7/25.
//  Copyright © 2016年 www.xz.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface categoriesModel : NSObject

@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *subcategories;

@end

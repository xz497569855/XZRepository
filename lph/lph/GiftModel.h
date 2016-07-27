//
//  GiftModel.h
//  lph
//
//  Created by mc on 16/7/25.
//  Copyright © 2016年 www.xz.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftModel : NSObject

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSMutableArray *categories;

@property (nonatomic, copy) NSString *message;

@end

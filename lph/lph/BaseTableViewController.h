//
//  BaseTableViewController.h
//  lph
//
//  Created by mc on 16/7/24.
//  Copyright © 2016年 www.xz.com. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL isHasTableView;

- (instancetype)initWithTableView:(BOOL)has;

@end

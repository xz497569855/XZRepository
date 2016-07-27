//
//  BaseTableViewController.m
//  lph
//
//  Created by mc on 16/7/24.
//  Copyright © 2016年 www.xz.com. All rights reserved.
//

#import "BaseTableViewController.h"
#import "Masonry.h"

@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTableViewController

- (instancetype)initWithTableView:(BOOL)has {
    if (self = [super init]) {
        if (has) {
            self.isHasTableView = YES;
        }else {
            self.isHasTableView = NO;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isHasTableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.text = @"哈哈";
//    return cell;
    
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 70;
//}


@end

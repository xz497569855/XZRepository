//
//  GiftViewController.m
//  lph
//
//  Created by mc on 16/7/25.
//  Copyright © 2016年 www.xz.com. All rights reserved.
//

#import "GiftViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "GiftModel.h"
#import "categoriesModel.h"
#import "subcategoriesModel.h"
#import "SubcategoriesCell.h"


#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

static NSString *ID1 = @"tableCell";
static NSString *ID2 = @"collectionCell";
static NSString *ID3 = @"collectionCellHeader";
static NSString *ID4 = @"collectionCellFooter";

static BOOL isGetWhatWay = YES;

@interface GiftViewController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;

/**左边tableView的categoriesModel*/
@property (nonatomic, strong) NSMutableArray *categoriesData;
/**右边collectionView每一组的subcategoriesModel*/
@property (nonatomic, strong) NSMutableArray *subcategoriesData;



@end

@implementation GiftViewController

#pragma maek - 懒加载

- (NSMutableArray *)categoriesData {
    if(!_categoriesData) {
        _categoriesData = [NSMutableArray array];
    }
    return _categoriesData;
}

- (NSMutableArray *)subcategoriesData {
    if(!_subcategoriesData) {
        _subcategoriesData = [NSMutableArray array];
    }
    return _subcategoriesData;
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.view);
            make.width.equalTo(@(kWidth / 4));
        }];
    }
    return _tableView;
}

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kWidth / 4 - 3 , kWidth / 4 - 3);
        flowLayout.minimumInteritemSpacing = 3;
        flowLayout.minimumLineSpacing = 3;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kWidth/4, 0, kWidth / 4 * 3, self.view.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        
        
        [_collectionView registerClass:[SubcategoriesCell class] forCellWithReuseIdentifier:ID2];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ID3];
         [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ID4];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initFace];
    
    [self loadData];
    

}

//- (void)viewDidAppear:(BOOL)animated {
//    NSLog(@"%@",NSStringFromCGRect(self.collectionView.frame));
//    
//    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
//    
//    
//    NSLog(@"%@",NSStringFromCGPoint(self.collectionView.contentOffset));
//    
//    NSLog(@"%@",NSStringFromCGSize(self.collectionView.contentSize));
//    
//    
//    NSLog(@"%@",NSStringFromUIEdgeInsets(self.collectionView.contentInset));
//}

- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.liwushuo.com/v2/item_categories/tree" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        GiftModel *gmodel = [GiftModel mj_objectWithKeyValues:responseObject[@"data"]];
        gmodel.code = [responseObject[@"code"] integerValue];
        gmodel.message = responseObject[@"message"];
        
        self.categoriesData = gmodel.categories;
        
        for (NSInteger i = 0; i < self.categoriesData.count; i++) {
            categoriesModel *model = self.categoriesData[i];
            NSMutableArray *array = model.subcategories;
            [self.subcategoriesData addObject:array];
        }
        [self.tableView reloadData];
        [self.collectionView reloadData];
        [self scrollViewDidScroll:self.collectionView];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)initFace {
    
    
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.categoriesData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
    if (cell == nil) {
        

       
        cell.backgroundColor = [UIColor clearColor];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID1];
        
        UIView *contentView = [[UIView alloc] initWithFrame:cell.contentView.frame];
        contentView.backgroundColor = [UIColor whiteColor];
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, cell.frame.size.height)];
        redView.backgroundColor = [UIColor redColor];
        [contentView addSubview:redView];
        
        cell.backgroundColor = [UIColor colorWithRed:0.8847 green:0.8847 blue:0.8847 alpha:1.0];
        [cell.selectedBackgroundView addSubview:contentView];
        cell.textLabel.font = [UIFont systemFontOfSize:11];
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        
//        
//        [cell.contentView addSubview:redView];
    }
    categoriesModel *model = self.categoriesData[indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    isGetWhatWay = NO;
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.subcategoriesData[section] count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SubcategoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID2 forIndexPath:indexPath];
    cell.subModel = self.subcategoriesData[indexPath.section][indexPath.row];
    return cell;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.subcategoriesData.count) {
        return self.subcategoriesData.count;
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section:%ld---row:%ld",indexPath.section,indexPath.row);
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        isGetWhatWay = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.collectionView) {
        if (isGetWhatWay == YES) {
            // 将collectionView在控制器view的中心点转化成collectionView上的坐标
            CGPoint pInView = [self.view convertPoint:self.collectionView.center toView:self.collectionView];
            // 获取这一点的indexPath
            NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pInView];
            if (indexPathNow.section == 0) {
                //获取所有collectionView的头视图(也可用item)
                NSArray *array = [self.collectionView indexPathsForVisibleSupplementaryElementsOfKind:UICollectionElementKindSectionHeader];
                if ([[array firstObject] section] == 0 || [[array firstObject] section] == 1) {
                    NSIndexPath *tabIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                    [self.tableView selectRowAtIndexPath:tabIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                    [self.tableView scrollToRowAtIndexPath:tabIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                }
                return;
            }
            
            NSIndexPath *tableIndecPath = [NSIndexPath indexPathForRow:indexPathNow.section inSection:0];
            [self.tableView selectRowAtIndexPath:tableIndecPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [self.tableView scrollToRowAtIndexPath:tableIndecPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
        
    }


}

#pragma mark - 返回头视图 / 尾视图 通过kind判断
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ID3 forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(5, reusableView.frame.size.height / 2, reusableView.frame.size.width - 10, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [reusableView addSubview:line];
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(reusableView.frame.size.width / 2 - 40, 0, 80, reusableView.frame.size.height)];
        headerLabel.textColor = [UIColor blackColor];
        headerLabel.font = [UIFont systemFontOfSize:11];
        headerLabel.textAlignment = NSTextAlignmentCenter;
        
        headerLabel.backgroundColor = [UIColor whiteColor];
        [reusableView addSubview:headerLabel];
        categoriesModel *model = self.categoriesData[indexPath.section];
        headerLabel.text = model.name;
        return reusableView;
    }else {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ID4 forIndexPath:indexPath];
        reusableView.backgroundColor = [UIColor whiteColor];
        return reusableView;
    }
    return nil;
}

#pragma mark 返回头视图的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(self.collectionView.frame.size.width, 20);
}

#pragma mark 返回尾视图的高度
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(self.collectionView.frame.size.width, 10);
}


@end

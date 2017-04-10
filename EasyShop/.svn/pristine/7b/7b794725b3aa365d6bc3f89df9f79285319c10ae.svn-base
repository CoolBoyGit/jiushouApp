//
//  ESProductListController.m
//  EasyShop
//
//  Created by wcz on 16/5/29.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESProductListController.h"
#import "ESCollectionShopCell.h"
#import "ESHomeShopDetailController.h"

@interface ESProductListController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionview;

@end

@implementation ESProductListController

- (UICollectionView *)collectionview
{
    if (_collectionview == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.minimumLineSpacing = 10;
        //        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionview.dataSource = self;
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.delegate = self;
        [_collectionview registerClass:[ESCollectionShopCell class] forCellWithReuseIdentifier:@"ESCollectionShopCell"];
        _collectionview.backgroundColor = [UIColor whiteColor];
    }
    return _collectionview;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   self.navigationItem.title = @"产品";
    [self.view addSubview:self.collectionview];
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    }

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth  - 30)/ 2 , (ScreenWidth  - 30)/ 2 + 40 );
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESCollectionShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESCollectionShopCell" forIndexPath:indexPath];
    //        cell.backgroundColor = [UIColor redColor];
//    cell.goodsInfo = [self.colloctItems objectAtIndex:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESHomeShopDetailController *shopDetailVc = [[ESHomeShopDetailController alloc] init];
//    shopDetailVc.isNavHidden = YES;
//    FavoritesGoodsInfo *info = [self.colloctItems objectAtIndex:indexPath.item];
//    shopDetailVc.goods_id = info.goods_id;
    [self.navigationController pushViewController:shopDetailVc animated:YES];
}

//#pragma mark - Networking
//- (void)fetchCollectGoods
//{
//    GetFavoritesGoodsRequest *request = [GetFavoritesGoodsRequest request];
//    request.type = self.isCollet ? @0 : @1;
//    
//    @weakify(self);
//    [ESService getFavoritesGoodsRequest:request success:^(NSArray *response) {
//        @strongify(self);
//        [self endGSNetworking];
//        
//        self.colloctItems = response;
//        [self.collectionview reloadData];
//        
//    } failure:^(NSError *error) {
//        @strongify(self);
//        [self endGSNetworking];
//    }];
//    
//}
//
//#pragma mark GSNetworking
//- (void)endGSNetworking
//{
//    [self.collectionview.mj_header endRefreshing];
//}



@end

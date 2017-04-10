//
//  ICCollectShopController.m
//  EasyShop
//
//  Created by wcz on 16/4/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ICCollectShopController.h"
#import "ESCollectionShopCell.h"
#import "ESHomeShopDetailController.h"

@interface ICCollectShopController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ESCollectionShopCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionview;

/** 收藏商品items ( item : FavoritesGoodsInfo ) */
@property (nonatomic,strong) NSMutableArray *colloctItems;

@end

@implementation ICCollectShopController

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
    TitleCenter;
    self.navigationItem.title = self.isCollet ? @"我的收藏" : @"心愿单";
//    [self initalizedCumstomNav];
    [self.view addSubview:self.collectionview];
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
    
    @weakify(self);
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self fetchCollectGoods];
    }];
    
    [self fetchCollectGoods];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.colloctItems.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth  - 30)/ 2 , (ScreenWidth  - 30)/ 2 + 50 );
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESCollectionShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESCollectionShopCell" forIndexPath:indexPath];
    cell.delegate=self;
//        cell.backgroundColor = [UIColor redColor];
    cell.goodsInfo = [self.colloctItems objectAtIndex:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESHomeShopDetailController *shopDetailVc = [[ESHomeShopDetailController alloc] init];
    
    FavoritesGoodsInfo *info = [self.colloctItems objectAtIndex:indexPath.item];
    shopDetailVc.goods_id = info.goods_id;
    [self.navigationController pushViewController:shopDetailVc animated:YES];
//    ESRootViewController*rootvc=[[ESRootViewController alloc]init];
//    rootvc.hidesBottomBarWhenPushed=YES;
//    //GoodsInfo *info = [self.goodsItems objectAtIndex:indexPath.row];
//    rootvc.goods_id=info.goods_id;
//    [self.navigationController pushViewController:rootvc animated:YES];
}

#pragma mark -- ESCollectionShopCellDelegate
//删除收藏
- (void)deleteCollectionAtGoods_id:(NSString *)goods_id{

    CancelFavoritesGoodsRequest*request=[CancelFavoritesGoodsRequest request];
    request.goods_id=goods_id;
    request.type=0;
    @weakify(self);
    [ESService cancelFavoritesGoodsRequest:request success:^{
        @strongify(self);
        
        [self endGSNetworking];
        /*为了方便暂时不从新请求网络收藏的数据*/
            NSMutableArray *arr = [self.colloctItems mutableCopy];
            for (FavoritesGoodsInfo *goodsInfo in arr) {
                if ([goodsInfo.goods_id isEqualToString:goods_id]) {
                    [self.colloctItems removeObject:goodsInfo];
                }
            }
        [self.collectionview reloadData];
       
        
       
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];

    
}

#pragma mark - Networking
- (void)fetchCollectGoods
{
    GetFavoritesGoodsRequest *request = [GetFavoritesGoodsRequest request];
    request.type = self.isCollet ? @0 : @1;
    
    @weakify(self);
    [ESService getFavoritesGoodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        self.colloctItems = [NSMutableArray arrayWithArray:response];
        [self.collectionview reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
    
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.collectionview.mj_header endRefreshing];
}

@end

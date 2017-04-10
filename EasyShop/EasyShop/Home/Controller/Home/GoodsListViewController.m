//
//  GoodsListViewController.m
//  EasyShop
//
//  Created by guojian on 16/5/30.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "GoodsListViewController.h"
#import "ESGoodsCell.h"
#import "ESHomeShopDetailController.h"
#import "ESSpectionHeardView.h"//是头部视图


@interface GoodsListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** collectionView */
@property (nonatomic,weak) UICollectionView *collectionView;

/** 第几页 */
@property (nonatomic,assign) NSInteger page;
/** 商品列表 */
@property (nonatomic,strong) NSMutableArray  *goodsItems;

@end

@implementation GoodsListViewController

- (NSMutableArray *)goodsItems
{
    if (!_goodsItems) {
        _goodsItems = [NSMutableArray array];
    }
    return _goodsItems;
}
#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = RGB(247, 247, 247);
    [collectionView registerClass:[ESGoodsCell class] forCellWithReuseIdentifier:kIDESGoodsCell];
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.left.right.bottom.equalTo(@0);
    }];
    @weakify(self);
    collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       @strongify(self);
        [self refreshList];
    }];
    MJRefreshAutoNormalFooter*footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreList];
    }];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    collectionView.mj_footer=footer;
    switch (self.listType) {
        case GoodsListType_Cart:
           self.navigationItem.title = @"热销商品";
            break;
        case GoodsListType_Activity://是这个的话添加一个专场图
            [collectionView registerClass:[ESSpectionHeardView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ESSpectionHeardView"];
           self.navigationItem.title = [NSString stringWithFormat:@"%@专场",self.activity_name];
            break;
        case GoodsListType_Today:
            self.navigationItem.title = @"今日特卖";
            break;
    }

    self.collectionView = collectionView;
    
    
    [self refreshList];
}
//设置collectionView的表头
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (self.listType == GoodsListType_Activity) {
        return CGSizeMake(ScreenWidth, ScreenWidth*408/617.0);

    }
    return CGSizeZero;
    
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind==UICollectionElementKindSectionHeader) {
        ESSpectionHeardView*view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ESSpectionHeardView" forIndexPath:indexPath];
       
        view.imageStr=self.heardImageStr;
        return view;
    }
    return nil;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
/*设置每一个item的大小*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    return CGSizeMake((ScreenWidth  - 3)/ 2 , (ScreenWidth-3)/ 2 + 50);
}
-(void)getHeightGoodsItem:(GoodsInfo*)info{
    
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
//设置列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.goodsItems.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIDESGoodsCell forIndexPath:indexPath];
    cell.goodsInfo = [self.goodsItems objectAtIndex:indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESHomeShopDetailController *shopDetailVc = [[ESHomeShopDetailController alloc] init];
//    shopDetailVc.isNavHidden = YES;
    GoodsInfo *info = [self.goodsItems objectAtIndex:indexPath.item];
    shopDetailVc.goods_id = info.gid;
    [self.navigationController pushViewController:shopDetailVc animated:YES];
//    ESRootViewController*rootvc=[[ESRootViewController alloc]init];
//    rootvc.hidesBottomBarWhenPushed=YES;
//    GoodsInfo *info = [self.goodsItems objectAtIndex:indexPath.row];
//    rootvc.goods_id=info.gid;
//    [self.navigationController pushViewController:rootvc animated:YES];
}

#pragma mark - Networking
#pragma mark 请求商品列表

- (void)refreshList
{
    self.page = 1;
    [self fetchList];
}
- (void)moreList
{
    self.page ++;
    [self fetchList];
}

- (void)fetchList
{
    switch (self.listType) {
        case GoodsListType_Cart://购物车
            [self fetchGoodsInfo];
            break;
        case GoodsListType_Activity://活动专场
            [self fetchActivityGoods];
            break;
        case GoodsListType_Today://今日特卖
            [self fetchTodayGoods];
            break;
    }
}

#pragma mark - 请求今日特卖
- (void)fetchTodayGoods
{
    SubGoodsListRequest *request = [SubGoodsListRequest request];
    request.type = @1;
    request.page = [NSNumber numberWithInteger:self.page];
    request.n = @20;
    
    @weakify(self);
    [ESService subGoodsListRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        [self handleResponse:response];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark - 请求专场商品列表
- (void)fetchActivityGoods
{
    GetActivityGoodsListRequest *request = [GetActivityGoodsListRequest request];
    request.aid = self.activity_id;
    request.page    = [NSNumber numberWithInteger:self.page];
    request.n       = @10;
    
    @weakify(self);
    [ESService getActivityGoodsListRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        [self handleResponse:response];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
    
}

#pragma mark 请求商品列表
- (void)fetchGoodsInfo
{
    GoodsRequest *request = [GoodsRequest request];
    request.page    = [NSNumber numberWithInteger:self.page];
    request.n       = @20;
    //    request.cat_id  = self.navInfo.nid;
    
    @weakify(self);
    [ESService goodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        [self handleResponse:response];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
    
}

- (void)handleResponse:(NSArray *)response
{
    if (self.page == 1) {
        [self.goodsItems removeAllObjects];
    }
    if (response.count < 10) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    } else
    {
        [self.collectionView.mj_footer resetNoMoreData];
    }
    
    [self.goodsItems addObjectsFromArray:response];
    [self.collectionView reloadData];
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

@end

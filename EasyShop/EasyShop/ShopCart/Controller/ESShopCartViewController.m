//
//  ShopCartViewController.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/4/8.
//  Copyright © 2016年 wcz. All rights reserved.
//
#import "ESShopCartViewController.h"
#import "ESShopCartCell.h"
#import "ESProductViewCell.h"
#import "ESShopBottomView.h"
#import "ESSpecialSaleView.h"
#import "ESPayListController.h"
#import "ESCartShopHeaderView.h"
#import "ESHomeShopDetailController.h"
#import "ESSureOrderController.h"
#import "ESShopCartNoneCell.h"
#import "ESHomeShopDetailController.h"
#import "GoodsListViewController.h"
#import "ESNewAddressController.h"
#import "GoodsStockView.h"

#import "ESCollectHeaderView.h"
@interface ESShopCartViewController()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ESSpecialSaleView      *specialShop;//今日特卖
@property (strong, nonatomic) UICollectionView                      *bottomCollectionView;
@property (nonatomic, strong) ESShopBottomView                *shopBottomView;

/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;

/** 是否为空 */
@property (nonatomic,assign,readonly) BOOL isEmpty;
/** 购物车信息 */
@property (nonatomic,strong) CartInfo *cartInfo;

/** 推荐商品 */
@property (nonatomic,strong) NSArray *relatedItems;
@property (nonatomic,strong) UILabel *tipsLabel;

@property (nonatomic,strong) UICollectionView*emptyCollect;
@property (nonatomic,strong) NSMutableArray*relatItemArray;
@property (nonatomic,assign) NSInteger relaPage;
@end

@implementation ESShopCartViewController

- (BOOL)isEmpty
{
    if (self.cartInfo) {
        if (self.cartInfo.shopsItems && self.cartInfo.shopsItems.count > 0) {
            return NO;
        }
    }
    return YES;
}
-(NSMutableArray *)relatItemArray{
    if (_relatItemArray==nil) {
        _relatItemArray=[NSMutableArray array];
        
    }
    return _relatItemArray;
}
- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}


#pragma mark - LifeCycle
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self addNotification];
    self.navigationItem.title = @"购物车";
    
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.specialShop;
    self.specialShop.text=@"购物车猜你喜欢";
    [self.specialShop addSubview:self.bottomCollectionView];
    [self.bottomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@40);
        make.height.equalTo(@(((ScreenWidth-3)/2.0+75)*2+8));
    }];
    [self.view addSubview:self.shopBottomView];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self fetchCart];
    }];
        [self fetchCart];
    [self.view addSubview:self.emptyCollect];
    [self.emptyCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
        
    }];
    self.emptyCollect.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getRelateGoodsList];
    }];
    MJRefreshAutoNormalFooter*nFooter=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreRelateGoodsList];
    }];
    [nFooter setTitle:@"亲,已经到底了" forState:MJRefreshStateNoMoreData];
    self.emptyCollect.mj_footer=nFooter;
    if (kUserManager.isLogin) {
        self.emptyCollect.hidden=YES;
    }else{
        self.emptyCollect.hidden=NO;
        [self getRelateGoodsList];
    }

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    DZLog(@"%f",self.shopBottomView.frame.origin.y);
}
-(void)getRelateGoodsList{
    self.relaPage=1;
    [self fetchGoods];
    
}
-(void)moreRelateGoodsList{
    self.relaPage++;
    [self fetchGoods];
}
-(void)fetchGoods{
    GoodsRequest*request=[GoodsRequest request];
    request.page=[NSNumber numberWithInteger:self.relaPage];
    request.n=[NSNumber numberWithInt:10];
    request.orderBy=[NSNumber numberWithInt:3];
    @weakify(self);
    [ESService goodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        if (self.relaPage==1) {
            [self.relatItemArray removeAllObjects];
        }
        if (response.count < 7) {
            [self.emptyCollect.mj_footer endRefreshingWithNoMoreData];
        } else
        {
            [self.emptyCollect.mj_footer resetNoMoreData];
        }
        [self.relatItemArray addObjectsFromArray:response];
        [self.emptyCollect reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
        
    }];
    
}

- (void)dealloc
{
    [self removeNotification];
}

#pragma mark - Notification
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:kUserLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:kUserLogoutNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cartInfoUpdate) name:kCartInfoUpdateNotification object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:LoginViewwillDiddisAppear object:nil];
}

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)userDidLogin
{
    [self fetchCart];
}
- (void)userDidLogout
{
    self.cartInfo = nil;
    //[self.tableView reloadData];
    self.emptyCollect.hidden=NO;
    [self getRelateGoodsList];
    
}
- (void)cartInfoUpdate
{
    [self fetchCart];
}

#pragma mark - lazy init

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.frame=CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-98);
        _tableView.backgroundColor = RGBA(247, 247, 247, 1);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[ESShopCartCell class] forCellReuseIdentifier:@"ESShopCartCell"];
        [_tableView registerClass:[ESCartShopHeaderView class] forHeaderFooterViewReuseIdentifier:kIDESCartShopHeader];
        [_tableView registerClass:[ESShopCartNoneCell class] forCellReuseIdentifier:kIDShopCartNoneCell];
    }
    return _tableView;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isEmpty) {
        return 1;
    }
    return self.cartInfo.shopsItems.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isEmpty) {
        return 1;
    }
    CartShopInfo *info = [self.cartInfo.shopsItems objectAtIndex:section];
    return info.goodsItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isEmpty) {//在这里判断是否有数据
        ESShopCartNoneCell *cell = [tableView dequeueReusableCellWithIdentifier:kIDShopCartNoneCell forIndexPath:indexPath];
        @weakify(self);
        cell.gotoBlock = ^{
            @strongify(self);
            GoodsListViewController *list = [[GoodsListViewController alloc] init];
            [self.navigationController pushViewController:list animated:YES];
        };
        return cell;
    }
    ESShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ESShopCartCell"];
    CartShopInfo *info = [self.cartInfo.shopsItems objectAtIndex:indexPath.section];
    cell.goodsInfo = [info.goodsItems objectAtIndex:indexPath.row];
    if (info.goodsItems.count-1==indexPath.row) {
        cell.isHidden=NO;
    }
    @weakify(self);
    cell.tapToDetail=^{
        @strongify(self);
        ESHomeShopDetailController *shopDetailVc = [[ESHomeShopDetailController alloc] init];
        CartShopInfo *info          = [self.cartInfo.shopsItems objectAtIndex:indexPath.section];
        CartGoodsInfo *goodsInfo    = [info.goodsItems objectAtIndex:indexPath.row];
        // GoodsInfo *info = [self.goodsItems objectAtIndex:indexPath.row];
        shopDetailVc.goods_id       = goodsInfo.goods_id;
        [self.navigationController pushViewController:shopDetailVc animated:YES];
    };
    cell.selectedBlock = ^{
        @strongify(self);
        [self editGoodsStatusAtIndexPath:indexPath];
    };
    cell.operateBlock = ^(BOOL isAdd){
        @strongify(self);
        [self editCartGoodsAtIndexPath:indexPath isAdd:isAdd];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isEmpty) {//有数据
        if (editingStyle == UITableViewCellEditingStyleDelete) {//删除
            [self deleteGoodsAtIndexPath:indexPath];
        }
    }
}
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.isEmpty) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isEmpty) {
        return kHeightShopCartNone;
    }
    return 103;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.isEmpty) {
        return 0;
    }
    return kHeightESCartShopHeader;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ESCartShopHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kIDESCartShopHeader];
    headerView.shopInfo             = [self.cartInfo.shopsItems objectAtIndex:section];
    @weakify(self);
    headerView.selectedBlock = ^(BOOL isSelected){
        @strongify(self);
        [self editShopStatusAtSection:section];
    };
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.isEmpty) {
        return 0;
    }
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(ESSpecialSaleView *)specialShop
{
    if (!_specialShop) {
        _specialShop = [[ESSpecialSaleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ((ScreenWidth-3)/2.0+75)*2+45+3)];
    }
    return _specialShop;
}
#pragma marak emptyCollect
-(UICollectionView *)emptyCollect{
    if (_emptyCollect==nil) {
        UICollectionViewFlowLayout *flowRight = [[UICollectionViewFlowLayout alloc] init];
        flowRight.scrollDirection = UICollectionViewScrollDirectionVertical;
        _emptyCollect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:flowRight];
        _emptyCollect.dataSource = self;
        _emptyCollect.delegate = self;
        _emptyCollect.scrollEnabled = YES;
        _emptyCollect.hidden=YES;
        [_emptyCollect registerClass:[ESCollectHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ESCollectHeaderView"];
        _emptyCollect.showsVerticalScrollIndicator = NO;
        _emptyCollect.showsHorizontalScrollIndicator = NO;
        [_emptyCollect setBackgroundColor:RGB(247, 247, 247)];
        [_emptyCollect registerClass:[ESProductViewCell class] forCellWithReuseIdentifier:@"ESProductViewCell"];
        
    }
    return _emptyCollect;
}

- (UICollectionView*)bottomCollectionView
{
    if(!_bottomCollectionView)
    {
        UICollectionViewFlowLayout *flowRight = [[UICollectionViewFlowLayout alloc] init];
        flowRight.scrollDirection = UICollectionViewScrollDirectionVertical;
        _bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 0) collectionViewLayout:flowRight];
        _bottomCollectionView.dataSource = self;
        _bottomCollectionView.delegate = self;
        _bottomCollectionView.scrollEnabled = NO;
        _bottomCollectionView.showsVerticalScrollIndicator = NO;
        _bottomCollectionView.showsHorizontalScrollIndicator = NO;
        [_bottomCollectionView setBackgroundColor:RGB(247, 247, 247)];
        [_bottomCollectionView registerClass:[ESCollectHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ESCollectHeaderView"];
        [_bottomCollectionView registerClass:[ESProductViewCell class] forCellWithReuseIdentifier:@"ESProductViewCell"];
    }
    return _bottomCollectionView;
}
#pragma mark 底部功能
- (ESShopBottomView *)shopBottomView
{
    if (!_shopBottomView) {
        _shopBottomView = [[ESShopBottomView alloc] initWithFrame:CGRectMake(0, ScreenHeight-49-49, ScreenWidth, 49)];
        @weakify(self);
        _shopBottomView.allSelectedBlock = ^(BOOL isSelected){//全选
            @strongify(self);
            ESLoginVerify
            
            [self editCartStatus:isSelected];
        };
        _shopBottomView.submitBlock = ^{//去结算
            @strongify(self);
            ESLoginVerify
            if (self.cartInfo.cartInfo.goods_sum.intValue==0) {
                [self.view addSubview:self.tipsLabel];
                [UIView animateWithDuration:1.5 animations:^{
                    self.tipsLabel.alpha=0.1;
                    
                } completion:^(BOOL finished) {
                    [self.tipsLabel removeFromSuperview];
                    self.tipsLabel.alpha=1;
                }];
            }
            else{
                [self confirmOrder];

            }
            
        };
    }
    return _shopBottomView;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
        _tipsLabel.center=self.view.center;
        _tipsLabel.textAlignment=NSTextAlignmentCenter;
        _tipsLabel.text=@"亲,请选择商品";
        _tipsLabel.font=[UIFont systemFontOfSize:15];
        _tipsLabel.layer.cornerRadius=5;
        _tipsLabel.layer.masksToBounds=YES;
        _tipsLabel.backgroundColor=[UIColor colorWithWhite:0.600 alpha:0.8];
    }
    return _tipsLabel;
}
#pragma mark - UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==self.bottomCollectionView) {
        return self.relatedItems.count;
    }
    return self.relatItemArray.count;
    
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
//设置列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (collectionView==self.emptyCollect) {
        return CGSizeMake(ScreenWidth, 300);
    }
    return CGSizeMake(0, 0);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.emptyCollect) {
        if (kind == UICollectionElementKindSectionHeader) {
            ESCollectHeaderView*heardView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ESCollectHeaderView" forIndexPath:indexPath];
            heardView.topStr=@"购物车空空如也";
            return heardView;
        }
    }else{
        if (kind == UICollectionElementKindSectionHeader) {
            ESCollectHeaderView*heardView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ESCollectHeaderView" forIndexPath:indexPath];
            return heardView;
        }

    }
    
    return nil;
    
    
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESProductViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESProductViewCell" forIndexPath:indexPath];
    if (collectionView==self.bottomCollectionView) {
        cell.goodsInfo = [self.relatedItems objectAtIndex:indexPath.item];
    }else{
        cell.goodsInfo = [self.relatItemArray objectAtIndex:indexPath.item];
    }
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.emptyCollect) {
        return CGSizeMake((ScreenWidth-3)/2.0,(ScreenWidth-3)/2.0+65) ;
    }
    return CGSizeMake((ScreenWidth-3)/2.0,(ScreenWidth-3)/2.0+75) ;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(3,0,0,0);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESHomeShopDetailController *shopDetailVc = [[ESHomeShopDetailController alloc] init];
    shopDetailVc.hidesBottomBarWhenPushed = YES;
    GoodsInfo *info=[[GoodsInfo alloc]init];
    if (collectionView==self.bottomCollectionView) {
        info = [self.relatedItems objectAtIndex:indexPath.item];
    }else{
        info = [self.relatItemArray objectAtIndex:indexPath.item];
    }
    
    

    shopDetailVc.goods_id = info.gid;
    [self.navigationController pushViewController:shopDetailVc animated:YES];
}
#pragma mark - Networking

#pragma mark - 删除购物车商品
- (void)deleteGoodsAtIndexPath:(NSIndexPath *)indexPath
{
    CartShopInfo *info          = [self.cartInfo.shopsItems objectAtIndex:indexPath.section];
    CartGoodsInfo *goodsInfo    = [info.goodsItems objectAtIndex:indexPath.row];
    
    DeleteCartGoodsRequest *request = [DeleteCartGoodsRequest request];
    request.goods_id = goodsInfo.goods_id;
    
    @weakify(self);
    [self.indicator startAnimation];
    [ESService deleteCartGoodsRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [ESToast showSuccess:@"删除成功！"];
        [self fetchCart];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark - 增加数量
- (void)editCartGoodsAtIndexPath:(NSIndexPath *)indexPath isAdd:(BOOL)isAdd
{
    CartShopInfo *info          = [self.cartInfo.shopsItems objectAtIndex:indexPath.section];
    CartGoodsInfo *goodsInfo    = [info.goodsItems objectAtIndex:indexPath.row];
    
    EditCartGoodsRequest *request = [EditCartGoodsRequest request];
    request.cid     = goodsInfo.cid;
    request.n       = isAdd ? @1 : @-1;
    
    @weakify(self);
    [ESService editCartGoodsRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [self fetchCart];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
    
}

#pragma mark -  编辑购物车商品状态
- (void)editGoodsStatusAtIndexPath:(NSIndexPath *)indexPath
{
    CartShopInfo *info          = [self.cartInfo.shopsItems objectAtIndex:indexPath.section];
    CartGoodsInfo *goodsInfo    = [info.goodsItems objectAtIndex:indexPath.row];
    BOOL isSelected = goodsInfo.status.integerValue;//当前状态
    
    [self editStatusWithCid:goodsInfo.cid isSelected:isSelected];
}

/** 单个商店商品 */
- (void)editShopStatusAtSection:(NSInteger)section
{
    CartShopInfo *info  = [self.cartInfo.shopsItems objectAtIndex:section];
    
    BOOL isSelected     = info.isSelected;

    [self editStatusWithCid:info.cids isSelected:isSelected];
}
/** 整个购物车 */
- (void)editCartStatus:(BOOL)isSelected
{
    NSMutableString *mStr = [[NSMutableString alloc] init];
    for (CartShopInfo *info in self.cartInfo.shopsItems) {
        if ([mStr isEqualToString:@""]) {//空
            [mStr appendString:info.cids];
        }else{
            [mStr appendString:[NSString stringWithFormat:@",%@",info.cids]];
        }
    }
    
    [self editStatusWithCid:[mStr copy] isSelected:isSelected];
}


- (void)editStatusWithCid:(NSString *)cid isSelected:(BOOL)isSelected
{
    EditStatusRequest *request = [EditStatusRequest request];
    request.cid         = cid;
    request.status      = isSelected ? @0 : @1;
    @weakify(self);
    [ESService editStatusRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        [self fetchCart];
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark  查询购物车
- (void)fetchCart
{
    CartRequest *request = [CartRequest request];
    @weakify(self);
    [ESService cartRequest:request success:^(CartInfo *response) {
        @strongify(self);
        [self endGSNetworking];
        self.cartInfo                   = response;
        self.shopBottomView.cartInfo    = response;
        if (response.shopsItems.count==0) {
            self.emptyCollect.hidden=NO;
            [self getRelateGoodsList];
            return ;
        }else{
            self.emptyCollect.hidden=YES;
            [self.tableView reloadData];
            if (self.cartInfo.goodids.length==0) {
                [self fetchRelatedGoodsGoods_id:[NSString stringWithFormat:@"%d",809]];
            }else{
                //请求推荐商品d
                [self fetchRelatedGoodsGoods_id:self.cartInfo.goodids];
            }
        }
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark - 推荐商品
- (void)fetchRelatedGoodsGoods_id:(NSString*)string
{
    GetRelatedGoodsRequest *request = [GetRelatedGoodsRequest request];
    request.goods_id = string;
    request.n        = @6;
    
    @weakify(self);
    [ESService getRelatedGoodsRequest:request success:^(NSArray *response) {
        @strongify(self);
        
        self.relatedItems = response;
        [self.bottomCollectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - 确认订单
- (void)confirmOrder
{
    @weakify(self);
    [self.indicator startAnimation];
    [ESService orderConfirmRequest:[OrderConfirmRequest request] success:^(OrderConfirmInfo *response) {
        @strongify(self);
        [self endGSNetworking];
        ESSureOrderController *order = [[ESSureOrderController alloc] init];
        order.isDetailShop=self.isHome;
        order.confirmInfo = response;
        [self.navigationController pushViewController:order animated:YES];
    } stockFailure:^(NSMutableArray*array) {//库存不足
        @strongify(self);
        [self endGSNetworking];
        [GoodsStockView showWithStockInfo:array];
    } failure:^(NSError *error) {
       @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
    [self.tableView.mj_header endRefreshing];
    [self.emptyCollect.mj_header endRefreshing];
    [self.emptyCollect.mj_footer endRefreshing];
}

@end

//
//  ICCouponController.m
//  iCarePregnant
//
//  Created by wcz on 16/6/22.
//  Copyright © 2016年 oenius. All rights reserved.
//

#import "ICCouponController.h"
#import "ESCouponViewCell.h"
#import "ESCouponFooterReusableView.h"
#import "ESCouponNoneCell.h"
@interface ICCouponController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionview;

/** from */
@property (nonatomic,assign) NSInteger page;
/** 卡券 */
@property (nonatomic,strong) NSMutableArray *couponItems;
/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;
/**领取优惠卷页面是空**/
@property (nonatomic,assign,readonly) BOOL isGetNone;
/** 是否是支付页面 && 优惠券为空 */
@property (nonatomic,assign,readonly) BOOL isNone;
/**在领取现金卷页面的提醒Label**/
@property (nonatomic,strong) UILabel*tipsLabel;
@end

@implementation ICCouponController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (self.couponType) {
        case CouponType_Select: self.navigationItem.title = @"使用优惠券"; break;//这个是点击支付页面的优惠卷跳转的，
        case CouponType_Get : self.navigationItem.title = @"现金券"; break;//这个是领取的页面跳转的。
        case CouponType_selectCluster: self.navigationItem.title=@"使用优惠卷";break;//拼团的页面跳转过来的
        default:
            break;
    }
    
    [self.view addSubview:self.collectionview];
    if (self.isComeFromUserCenter) {
        [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.bottom.equalTo(@0);
        }];
    }else{
        [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@64);
            make.left.right.bottom.equalTo(@0);
        }];
    }
   
    
    @weakify(self);
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshList];
    }];
    if (self.couponType == CouponType_Center) {//个人中心
        MJRefreshAutoNormalFooter*footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            @strongify(self);
            [self moreList];
        }];
        [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
        self.collectionview.mj_footer=footer;
    }
   // [self getCLusterCoupon];
    [self refreshList];
}

-(BOOL)isGetNone{
    return self.couponType==CouponType_Get && self.couponItems.count==0;
}
- (BOOL)isNone
{
    
         return  (self.couponType == CouponType_Select||self.couponType==CouponType_selectCluster) && self.couponItems.count == 0;
    
}

- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}

- (NSMutableArray *)couponItems
{
    if (!_couponItems) {
        _couponItems = [NSMutableArray array];
    }
    return _couponItems;
}

- (UICollectionView *)collectionview
{
    if (_collectionview == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionview = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionview.dataSource = self;
        _collectionview.delegate = self;
        _collectionview.backgroundColor = [UIColor whiteColor];
        [_collectionview registerClass:[ESCouponViewCell class] forCellWithReuseIdentifier:@"ESCouponViewCell"];
        [_collectionview registerClass:[ESCouponNoneCell class] forCellWithReuseIdentifier:@"ESCouponNoneCell"];
        [_collectionview registerClass:[ESCouponFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ESCouponFooterReusableView"];
    }
    return _collectionview;
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.isNone||self.isGetNone ? 1 : self.couponItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    if (self.isNone) {
        ESCouponNoneCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ESCouponNoneCell" forIndexPath:indexPath];
        cell.isShow=NO;
        return cell;
    }
    if (self.isGetNone) {
        ESCouponNoneCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ESCouponNoneCell" forIndexPath:indexPath];
        cell.isShow=YES;
        return cell;
    }
    ESCouponViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESCouponViewCell" forIndexPath:indexPath];
    if (self.couponType==CouponType_Get) {//领取优惠卷
        cell.getInfo=[self.couponItems objectAtIndex:indexPath.item];
    }else{
        cell.couponInfo = [self.couponItems objectAtIndex:indexPath.item];
        
        
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (self.couponType == CouponType_Select) {
        if (kind==UICollectionElementKindSectionFooter) {
            ESCouponFooterReusableView*view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"ESCouponFooterReusableView" forIndexPath:indexPath];
            return view;
        }
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.couponType == CouponType_Select) {
        return CGSizeMake(ScreenWidth-20, ScreenHeight-100*(self.couponItems.count)-64);
        
    }
    return CGSizeMake(0, 0);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.couponType==CouponType_Get) {
        //GetCouponInfo*info=[self.couponItems objectAtIndex:indexPath.item];
        return self.isNone||self.isGetNone ? CGSizeMake(ScreenWidth-20, 200) : CGSizeMake(ScreenWidth - 20, 90);
    }
    return self.isNone||self.isGetNone ? CGSizeMake(ScreenWidth-20, 200) : CGSizeMake(ScreenWidth - 20, 75);
    
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isGetNone||self.isNone) {
        return;
    }
    switch (self.couponType) {
        case CouponType_Select://支付
        {
            CouponInfo*couponInfo = [self.couponItems objectAtIndex:indexPath.item];
            if (self.couponBlock) {
                self.couponBlock(couponInfo);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case CouponType_selectCluster:{
            CouponInfo*couponInfoCluster = [self.couponItems objectAtIndex:indexPath.item];
            if (self.couponBlock) {
                self.couponBlock(couponInfoCluster);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case CouponType_Get://获取
        {
            GetCouponInfo* getInfo=[self.couponItems objectAtIndex:indexPath.item];
            [self getCouponByCid:getInfo.cid];
        }
            break;
        default:
            break;
    }
}


#pragma mark - Networking

- (void)refreshList
{
    switch (self.couponType) {
        case CouponType_Center://个人中心
        {
            self.page = 1;
            [self fetchCoupon];
        }
            break;
            
        case CouponType_Select://支付页面获取可以用的优惠卷
            [self fetchSelectCoupon];
            break;
        case CouponType_Get:
            [self queryCoupon];
            break;
        case CouponType_selectCluster://拼团支付页面
            [self getCLusterCoupon];
            break;
    }
    
}
- (void)moreList
{
    self.page ++;
    [self fetchCoupon];
}

#pragma mark 请求拼团页面的商品可以用的优惠卷
-(void)getCLusterCoupon{
    GetclusterCouponRequest*request=[GetclusterCouponRequest request];
    request.goods_id=self.goodsId;
    
    [ESService GetclusterCouponRequest:request success:^(NSArray *response) {
        [self.couponItems removeAllObjects];
        [self.couponItems addObjectsFromArray:response];
        [self.collectionview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}

#pragma mark - 请求可领取优惠券
- (void)queryCoupon
{
    QueryCouponRequest *request = [QueryCouponRequest request];
    
    @weakify(self);
    [ESService queryCouponRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        [self.couponItems removeAllObjects];
        [self.couponItems addObjectsFromArray:response];
        [self.collectionview reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}
/** 领取优惠券 */
#pragma mark 领取优惠卷
- (void)getCouponByCid:(NSString *)cid
{
    GetCouponRequest *request = [GetCouponRequest request];
    request.cid = cid;
    
    @weakify(self);
    [self.indicator startAnimation];
    [ESService getCouponRequest:request success:^{
        @strongify(self);
        [self endGSNetworking];
        
        [self refreshList];
        [ESToast showSuccess:@"优惠券领取成功"];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}

#pragma mark  16.4 获取某个订单可以用到的优惠券
- (void)fetchSelectCoupon
{
    SelectCouponRequest *request=[SelectCouponRequest request];
    request.order_id=self.order_id;
    @weakify(self);
    [ESService selectCouponRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        [self.couponItems removeAllObjects];
        [self.couponItems addObjectsFromArray:response];
        [self.collectionview reloadData];
        
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
        
    }];
}


#pragma mark - 请求个人中心页的优惠券
- (void)fetchCoupon
{
    CouponRequest *request = [CouponRequest request];
    request.type = self.type;
    request.page = [NSNumber numberWithInteger:self.page];
    request.n = @20;
    
    @weakify(self);
    [ESService couponRequest:request success:^(NSArray *response) {
        @strongify(self);
        [self endGSNetworking];
        
        if (self.page == 1) {
            [self.couponItems removeAllObjects];
        }
        //        self.collectionview.mj_footer.hidden = response.count < 20;
        if (response.count < 20) {
            [self.collectionview.mj_footer endRefreshingWithNoMoreData];
        } else
        {
            [self.collectionview.mj_footer resetNoMoreData];
        }
        
        [self.couponItems addObjectsFromArray:response];
        [self.collectionview reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
    }];
}


#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
    [self.collectionview.mj_header endRefreshing];
    [self.collectionview.mj_footer endRefreshing];
}

@end

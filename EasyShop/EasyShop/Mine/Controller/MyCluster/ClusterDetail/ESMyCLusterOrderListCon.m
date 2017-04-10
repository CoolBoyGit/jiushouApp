//
//  ESTogetListController.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/19.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESMyCLusterOrderListCon.h"
#import "ESClusterDetailController.h"
#import "ESMyclusterOrderListCell.h"
#import "ESHomeShopDetailController.h"
#import "ClusterOrderDetailCon.h"
#import "ESCluserOerderHeadView.h"
#import "ESProductViewCell.h"
#import "ESCollectHeaderView.h"
@interface ESMyCLusterOrderListCon ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UITableView*tableView;
@property (nonatomic,strong) NSMutableArray*clusterOrederItems;
@property (nonatomic,assign) int page;
/** indicator */
@property (nonatomic,strong) ESIndicator *indicator;
@property (nonatomic,strong) UICollectionView*bottomCollectionView;

@property (nonatomic,strong) NSMutableArray*relatItemArray;
@property (nonatomic,assign) NSInteger relaPage;
@end

@implementation ESMyCLusterOrderListCon

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page=1;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshList];
    }];
//    MJRefreshAutoNormalFooter*footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        @strongify(self);
//        [self moreList];
//    }];
//    [footer setTitle:@"亲,已经到底了" forState:MJRefreshStateNoMoreData];
//    self.tableView.mj_footer=footer;
    self.tableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(moreList)];
    [self getClusterList];
    [self.view addSubview:self.bottomCollectionView];
    [self.bottomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.bottomCollectionView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self getRelateGoodsList];
    }];
    MJRefreshAutoNormalFooter*nFooter=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreRelateGoodsList];
    }];
    [nFooter setTitle:@"亲,已经到底了" forState:MJRefreshStateNoMoreData];
    self.bottomCollectionView.mj_footer=nFooter;

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
- (NSMutableArray *)clusterOrederItems
{
    if (!_clusterOrederItems) {
        _clusterOrederItems = [NSMutableArray array];
    }
    return _clusterOrederItems;
}
-(void)moreList{
    self.page++;
    [self getClusterList];
}
-(void)refreshList{
    self.page=1;
    [self getClusterList];
}
#pragma mark tableViewdellgate
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor=RGB(247, 247, 247);
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [_tableView registerClass:[ESMyclusterOrderListCell class] forCellReuseIdentifier:@"ESMyclusterOrderListCell"];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.clusterOrederItems.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     GetClusterListRespone*respone=[self.clusterOrederItems objectAtIndex:indexPath.row];
    ESHomeShopDetailController*vc=[[ESHomeShopDetailController alloc]init];
    vc.goods_id=respone.goods_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ESMyclusterOrderListCell*cell=[tableView dequeueReusableCellWithIdentifier:@"ESMyclusterOrderListCell"];
    
    cell.leftButtonBlock=^(NSString *str){
        ESClusterDetailController*vc=[[ESClusterDetailController alloc]init];
        vc.flag=2;
        GetClusterListRespone*respone=[self.clusterOrederItems objectAtIndex:indexPath.row];
        vc.isComeClusterOrder=YES;
        vc.clusterId=respone.cluster_id;
        [self.navigationController pushViewController:vc animated:YES];
    };
    cell.rightButtonBlock=^(){
        ClusterOrderDetailCon*vc=[[ClusterOrderDetailCon alloc]init];
        GetClusterListRespone*respone=[self.clusterOrederItems objectAtIndex:indexPath.row];
        vc.clusterListRespone=respone;
        [self.navigationController pushViewController:vc animated:YES];
    };
    GetClusterListRespone*respone=[self.clusterOrederItems objectAtIndex:indexPath.row];
    cell.respone=respone;
    return cell;
}

- (UICollectionView*)bottomCollectionView
{
    if(!_bottomCollectionView)
    {
        UICollectionViewFlowLayout *flowRight = [[UICollectionViewFlowLayout alloc] init];
        flowRight.scrollDirection = UICollectionViewScrollDirectionVertical;
        _bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:flowRight];
        _bottomCollectionView.dataSource = self;
        _bottomCollectionView.delegate = self;
        _bottomCollectionView.scrollEnabled = YES;
        _bottomCollectionView.hidden=YES;
        [_bottomCollectionView registerClass:[ESCollectHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ESCollectHeaderView"];
        _bottomCollectionView.showsVerticalScrollIndicator = NO;
        _bottomCollectionView.showsHorizontalScrollIndicator = NO;
        [_bottomCollectionView setBackgroundColor:RGB(247, 247, 247)];
        
        [_bottomCollectionView registerClass:[ESProductViewCell class] forCellWithReuseIdentifier:@"ESProductViewCell"];
    }
    return _bottomCollectionView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, 300);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        ESCollectHeaderView*heardView=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ESCollectHeaderView" forIndexPath:indexPath];
        return heardView;
    }
    return nil;
    
}

#pragma mark - UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.relatItemArray.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESProductViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESProductViewCell" forIndexPath:indexPath];
    cell.goodsInfo = [self.relatItemArray objectAtIndex:indexPath.item];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-3)/2.0,(ScreenWidth-3)/2.0+65) ;
}
//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,0,0,0);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
//设置列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsInfo *info = [self.relatItemArray objectAtIndex:indexPath.item];
    ESHomeShopDetailController*detail=[[ESHomeShopDetailController alloc]init];
    detail.goods_id=info.gid;
    [self .navigationController pushViewController:detail animated:YES];
}
#pragma mark 请求推荐商品
-(void)getRelateGoodsList{
    self.relaPage = 1;
    [self fetchGoods];
}
-(void)moreRelateGoodsList{
    self.relaPage++;
    [self fetchGoods];
}
//请求底部的collection的数据
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
            [self.bottomCollectionView.mj_footer endRefreshingWithNoMoreData];
        } else
        {
            [self.bottomCollectionView.mj_footer resetNoMoreData];
        }
        [self.relatItemArray addObjectsFromArray:response];
        [self.bottomCollectionView reloadData];
        
    } failure:^(NSError *error) {
        @strongify(self);
        [self endGSNetworking];
        
    }];
    
}

-(void)getClusterList{
    GetClusterListRequest*reqest=[GetClusterListRequest request];
    reqest.type=[NSNumber numberWithInt:self.type];
    reqest.page=[NSNumber numberWithInt:self.page];
    reqest.n=@5;
    [self.indicator startAnimation];
    [ESService getClusterListRequest:reqest success:^(NSArray *response) {
        [self endGSNetworking];
        if (self.page==1) {
            if (response.count==0) {
                self.bottomCollectionView.hidden=NO;
                [self getRelateGoodsList];
                return ;
            }else{
                self.bottomCollectionView.hidden=YES;
            }
            [self.clusterOrederItems removeAllObjects];
        }
        [self.clusterOrederItems addObjectsFromArray:response];
        
        [self.tableView reloadData];
        if (response.count<5) {
            self.tableView.mj_footer.hidden=YES;
            
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.bottomCollectionView.mj_header endRefreshing];
    [self.bottomCollectionView.mj_footer endRefreshing];
}
@end

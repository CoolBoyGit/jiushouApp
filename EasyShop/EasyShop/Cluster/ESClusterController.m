//
//  ESClusterController.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterController.h"
#import "ClusterCollectionCell.h"
#import "ESHomeShopDetailController.h"
#import "ESclusterPayController.h"
@interface ESClusterController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView*clusterCollectionView;
@property (nonatomic,strong) NSMutableArray*clusterArray;
@property (nonatomic,assign) int page;
@property (nonatomic,strong) ESIndicator *indicator;
@end

@implementation ESClusterController

/** indicator */

- (ESIndicator *)indicator
{
    if (!_indicator) {
        _indicator = [ESIndicator indicatorToView:self.view];
    }
    return _indicator;
}
#pragma mark GSNetworking
- (void)endGSNetworking
{
    [self.indicator stopAnimation];
    [self.clusterCollectionView.mj_header endRefreshing];
    [self.clusterCollectionView.mj_footer endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page=1;
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"拼拼团";
    [self.view addSubview:self.clusterCollectionView];
//    [self.clusterCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(@0);
//        make.top.equalTo(@64);
//    }];
    [self getClusterGoods];
    @weakify(self);
    self.clusterCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self refreshList];
    }];
    MJRefreshAutoNormalFooter*footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        [self moreList];
    }];
    [footer setTitle:@"已经到底了" forState:MJRefreshStateNoMoreData];
    self.clusterCollectionView.mj_footer=footer;

    // Do any additional setup after loading the view.
}
-(void)refreshList{
    self.page=1;
    [self getClusterGoods];
}
-(void)moreList{
    self.page++;
    [self getClusterGoods];
}
-(NSMutableArray *)clusterArray{
    if (_clusterArray==nil) {
        _clusterArray=[[NSMutableArray alloc]init];
        
    }
    return _clusterArray;
}
-(UICollectionView *)clusterCollectionView{
    if (_clusterCollectionView==nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //flowLayout.minimumInteritemSpacing = 20;
        flowLayout.minimumLineSpacing = 5;
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _clusterCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-49) collectionViewLayout:flowLayout];
        _clusterCollectionView.backgroundColor=[UIColor whiteColor];
        _clusterCollectionView.delegate=self;
        _clusterCollectionView.dataSource=self;
        //作用是显示一半的图片.
        _clusterCollectionView.clipsToBounds=YES;
        
        _clusterCollectionView.showsHorizontalScrollIndicator=NO;
        [_clusterCollectionView registerClass:[ClusterCollectionCell class] forCellWithReuseIdentifier:@"ClusterCollectionCell"];
        
    }
    return _clusterCollectionView;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(ScreenWidth, ScreenWidth*(492/745.0));
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.clusterArray.count;
}
//设置列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ESHomeShopDetailController*vc=[[ESHomeShopDetailController alloc]init];
    GoodsInfo*info=[self.clusterArray objectAtIndex:indexPath.item];
    vc.goods_id=info.gid;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ClusterCollectionCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ClusterCollectionCell" forIndexPath:indexPath];
    
    GoodsInfo*goodsInfo = [self.clusterArray objectAtIndex:indexPath.item];
    if ([goodsInfo.stock intValue]==0) {
        cell.isHidden=NO;
    }else{
        cell.isHidden=YES;
    }
    cell.goodsInfo=goodsInfo;
    @weakify(self);
    cell.goButtonBlock=^(){
        @strongify(self);
        ESclusterPayController*cvc=[[ESclusterPayController alloc]init];
        cvc.goods_id=goodsInfo.gid;
        cvc.typeStaus=ClusterPayStaus_FromHome;
        [self.navigationController pushViewController:cvc animated:YES];
    };
    return cell;
}
-(void)getClusterGoods{
    GetClusterGoodsRequest*request=[GetClusterGoodsRequest request];
    request.page=[NSString stringWithFormat:@"%d",self.page];
    request.n=@"10";
    request.orderBy=@"2";
    request.order=@"desc";
    [self.indicator startAnimation];
    
    [ESService GetClusterGoodsRequest:request success:^(NSArray *response) {
        [self endGSNetworking];
        if (self.page==1) {
            [self.clusterArray removeAllObjects];
        }
        if (response.count<10) {
            [self.clusterCollectionView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.clusterCollectionView.mj_footer resetNoMoreData];
        }
        [self.clusterArray addObjectsFromArray:response];;
        [self.clusterCollectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}
@end

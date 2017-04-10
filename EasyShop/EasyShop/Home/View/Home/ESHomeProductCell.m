//
//  ESHomeProductCell.m
//  EasyShop
//
//  Created by wcz on 16/3/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESHomeProductCell.h"
#import "ESProductViewCell.h"
#import "ESHomeShopDetailController.h"
#import "ESProductListController.h"
#import "GoodsListViewController.h"
#import "ESOneGoodsCell.h"
#import "ESbuttoonViewCell.h"
#import "ESHomeActivityCollectionCell.h"
#import <SDImageCache.h>
#import <SDWebImage/UIButton+WebCache.h>
@interface ESHomeProductCell ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionview;

@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic,strong) UIView *bgView;
/*用来存放更多按钮的数组*/
@property (nonatomic,strong) NSMutableArray*activityArray;
@property (nonatomic,strong) UIImage*imagedd;
@property (nonatomic,strong) UIButton*testbutton;

@end

@implementation ESHomeProductCell

- (void)setActivityInfo:(ActivityInfo *)activityInfo
{
    self.activityArray=[[NSMutableArray alloc]init];
    
    _activityInfo = activityInfo;
    if (_activityInfo.goods_list.count<=8) {
        for (GoodsInfo *goods in _activityInfo.goods_list) {
           
                [self.activityArray addObject:goods];
            
        }
    }
    else {
        
        for (int i=0; i<8; i++) {
            [self.activityArray addObject:[_activityInfo.goods_list objectAtIndex:i]];
        }
    }
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:_activityInfo.cover]
                             placeholderImage:[UIImage imageNamed:@"bg"]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_activityInfo.goods_list.count==0) {
            
        }else{
            [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.productImageView.mas_bottom);
                make.left.right.equalTo(@0);
                make.bottom.equalTo(@(-10));
            }];
            [self.collectionview reloadData];
        }
        
    });

    
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
        _bgView.backgroundColor=RGB(247, 247, 247);
        //_bgView.backgroundColor=[UIColor whiteColor];
        _bgView.alpha=1;
    }
  
    return _bgView;
}
- (UIImageView *)productImageView
{
    if (_productImageView == nil) {
        _productImageView = [[UIImageView alloc] init];
        UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTapDetail)];
        _productImageView.image = [UIImage imageNamed:@""];
        [_productImageView addGestureRecognizer:gesTap];
        _productImageView.userInteractionEnabled = YES;
        _productImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _productImageView;
}

- (void)showTapDetail
{
    if (self.activityInfo) {
        //专场只有一个商品的时候，直接进入该商品的详情页面
        if (self.activityInfo.goods_list && self.activityInfo.goods_list.count == 1) {
            GoodsInfo *info = self.activityInfo.goods_list.firstObject;
            [self toGoodDetailWithInfo:info];
            return;
        }
        /*这里是进入专场列表的界面*/
        GoodsListViewController *list = [[GoodsListViewController alloc] init];
        list.listType = GoodsListType_Activity;
        list.activity_name = self.activityInfo.name;
        list.activity_id = self.activityInfo.aid;
        list.heardImageStr=self.activityInfo.cover;
        [[AppDelegate shared] pushViewController:list animated:YES];
    }
}
- (UICollectionView *)collectionview
{
    if (_collectionview == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionview.dataSource = self;
        
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.delegate = self;
        [_collectionview registerClass:[ESHomeActivityCollectionCell class] forCellWithReuseIdentifier:@"ESHomeActivityCollectionCell"];
        [_collectionview registerClass:[ESOneGoodsCell class] forCellWithReuseIdentifier:@"ESOneGoodsCell"];
        [_collectionview registerClass:[ESbuttoonViewCell class] forCellWithReuseIdentifier:@"ESbuttoonViewCell"];
        _collectionview.backgroundColor = [UIColor whiteColor];
    }
    return _collectionview;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.productImageView];
        [self.contentView addSubview:self.collectionview];
        [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.height.equalTo(@(ScreenWidth*(408/617.0)));
        }];
        [self.contentView addSubview: self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@0);
            make.left.right.equalTo(@0);
            make.height.equalTo(@10);
        }];
        

    }
    return self;
}


#pragma mark - collectionview 代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [collectionView.collectionViewLayout invalidateLayout];
    if (self.activityArray.count==1) {
        return 1;
    }else{
        return self.activityArray.count+1;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.activityInfo.goods_list.count==0) {
        return CGSizeMake(0, 0);
    }
    if (self.activityInfo.goods_list.count==1) {
        return CGSizeMake(ScreenWidth, 215);
    }else{
        return CGSizeMake(135, 215);
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.activityArray. count==1) {
        ESOneGoodsCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ESOneGoodsCell" forIndexPath:indexPath];
        GoodsInfo*goodsInfo = [self.activityArray objectAtIndex:indexPath.item];
        if ([goodsInfo.stock intValue]==0) {
            cell.isHidden=NO;
        }else{
            cell.isHidden=YES;
        }
        cell.goodsInfo=goodsInfo;
        return cell;
    }
    else if(indexPath.item==(self.activityArray. count)){
    ESbuttoonViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ESbuttoonViewCell" forIndexPath:indexPath];
        
        return cell;
        

    }
    else if(indexPath.item<=self.activityArray.count-1){
        ESHomeActivityCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESHomeActivityCollectionCell" forIndexPath:indexPath];
        GoodsInfo*goodsInfo = [self.activityArray objectAtIndex:indexPath.item];
        if ([goodsInfo.stock intValue]==0) {
            cell.hiden=NO;
        }else{
            cell.hiden=YES;
        }
        cell.goodsInfo=goodsInfo;
        
        return cell;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.item==self.activityArray.count) {
        [self showTapDetail];
    }else{
        GoodsInfo *info = [self.activityArray objectAtIndex:indexPath.item];
        [self toGoodDetailWithInfo:info];
    }
    

//    [self.controller.navigationController pushViewController:detail animated:YES];
}

- (void)toGoodDetailWithInfo:(GoodsInfo *)info
{
    ESHomeShopDetailController *detail = [[ESHomeShopDetailController alloc] init];
    detail.goods_id  = info.gid;
    detail.hidesBottomBarWhenPushed=YES;
    [[AppDelegate shared] pushViewController:detail animated:YES];
}

@end

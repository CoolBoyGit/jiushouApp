//
//  ESRecommendShopListCell.m
//  EasyShop
//
//  Created by wcz on 16/3/31.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRecommendShopListCell.h"
#import "ESRecommendShopCell.h"
#import "ESHomeShopDetailController.h"
#import "ESRootViewController.h"
@interface ESRecommendShopListCell ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionview;

@end

@implementation ESRecommendShopListCell

- (void)setRelatedItems:(NSArray *)relatedItems
{
    _relatedItems = relatedItems;
    
    [self.collectionview reloadData];
}

- (UICollectionView *)collectionview
{
    if (_collectionview == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionview = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionview.dataSource = self;
        
        _collectionview.showsVerticalScrollIndicator = NO;
        _collectionview.showsHorizontalScrollIndicator = NO;
        _collectionview.delegate = self;
        [_collectionview registerClass:[ESRecommendShopCell class] forCellWithReuseIdentifier:@"ESRecommendShopCell"];
        _collectionview.backgroundColor=RGB(247, 247, 247);
    }
    return _collectionview;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self intalizedView];
    }
    return self;
}

- (void)intalizedView
{
    [self.contentView addSubview:self.collectionview];
    [self.collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(@0);
        make.top.equalTo(@0);
    }];
}

#pragma mark - collectionview 代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.relatedItems.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(135, 210);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESRecommendShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESRecommendShopCell" forIndexPath:indexPath];
    cell.goodsInfo  = [self.relatedItems objectAtIndex:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESHomeShopDetailController *detail = [[ESHomeShopDetailController alloc] init];
    GoodsInfo *info = [self.relatedItems objectAtIndex:indexPath.item];
    detail.goods_id  = info.gid;
    [self.controller.navigationController pushViewController:detail animated:YES];

}

@end
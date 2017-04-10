//
//  ESFiltersView.m
//  EasyShop
//
//  Created by wcz on 16/6/7.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESFiltersView.h"
#import "ESFiltersViewCell.h"

@interface ESFiltersView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@end

@implementation ESFiltersView

- (UICollectionView *)collectionView
{
    if (_collectionView ==nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.itemSize = CGSizeMake(80, 80);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ESFiltersViewCell class] forCellWithReuseIdentifier:@"ESFiltersViewCell"];
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ESFiltersViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ESFiltersViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    cell.imageView = self.image;
    cell.filterName = self.imageArray[indexPath.row];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (_callBack) {
        _callBack(indexPath.row);

    }
}

@end

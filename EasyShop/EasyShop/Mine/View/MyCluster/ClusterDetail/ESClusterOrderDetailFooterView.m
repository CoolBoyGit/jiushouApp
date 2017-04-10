

//
//  ESTogeDetailFooterView.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterOrderDetailFooterView.h"
#import "ESClusteOrderrDetailColleCell.h"
#import "ESHomeShopDetailController.h"
@interface ESClusterOrderDetailFooterView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView*collectionVIew;
@property (nonatomic,strong)UILabel*tipsLabel;
@property (nonatomic,strong) UIView*lineView;
@property (nonatomic,strong) NSArray*array;
@end
@implementation ESClusterOrderDetailFooterView
-(void)setRelationArray:(NSArray *)relationArray{
    _array=relationArray;
    [self.collectionVIew reloadData];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@44);
            make.left.right.equalTo(@0);
            make.top.equalTo(@0);
        }];
        [self addSubview: self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.left.right.equalTo(@0);
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(0);
        }];
        [self addSubview:self.collectionVIew];
        [self.collectionVIew mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(@0);
            make.top.equalTo(self.lineView.mas_bottom).offset(0);
            make.height.equalTo(@(((ScreenWidth-3)/2.0 +50)*4+9));
        }];
    }
    return self;
}
-(NSArray *)array{
    if (_array==nil) {
        _array=[NSArray array];
    }
    return _array;
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGB(247, 247, 247);
    }
    return _lineView;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.textColor=RGB(170, 170, 170);
        _tipsLabel.textAlignment=NSTextAlignmentCenter;
        _tipsLabel.text=@"小就猜你可能喜欢";
    }
    return _tipsLabel;
}
-(UICollectionView *)collectionVIew{
    if (_collectionVIew==nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionVIew=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionVIew.backgroundColor=RGB(247, 247, 247);
        _collectionVIew.delegate=self;
        _collectionVIew.dataSource=self;
        _collectionVIew.clipsToBounds=YES;
        _collectionVIew.scrollEnabled=NO;
        _collectionVIew.showsHorizontalScrollIndicator=NO;
        [_collectionVIew registerClass:[ESClusteOrderrDetailColleCell class] forCellWithReuseIdentifier:@"ESClusteOrderrDetailColleCell"];
        
    }
    return _collectionVIew;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ESHomeShopDetailController*vc=[[ESHomeShopDetailController alloc]init];
    GoodsInfo*info=[self .array objectAtIndex:indexPath.item];
    vc.goods_id=info.gid;
    [[AppDelegate shared]pushViewController:vc animated:YES];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth-3)/2.0, (ScreenWidth-3)/2.0+50);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}
//设置列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ESClusteOrderrDetailColleCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ESClusteOrderrDetailColleCell" forIndexPath:indexPath];
    cell.info=[self.array objectAtIndex:indexPath.item];
    
    return cell;
    
    
}



@end

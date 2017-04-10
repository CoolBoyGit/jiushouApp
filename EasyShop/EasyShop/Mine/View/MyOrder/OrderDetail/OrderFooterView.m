//
//  OrderFooterView.m
//  EasyShop
//
//  Created by guojian on 16/5/31.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "OrderFooterView.h"
#import "GSTimeTool.h"
#import "ESHomeShopDetailController.h"
#import "ESClusterDetailGoodsCell.h"
@interface OrderFooterView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView*collectImageView;

/** 订单编号 */
@property (nonatomic,strong) UILabel *numberLabel;
/** 下单时间 */
@property (nonatomic,strong) UILabel  *timeLabel;
@property (nonatomic,strong) UIButton *pasteButton;
@property (nonatomic,strong)UIView*view;
@property (nonatomic,strong) NSArray*array;
@end

@implementation OrderFooterView
-(void)setRelateArray:(NSArray *)relateArray{
    _array=relateArray;
    [self.collectImageView reloadData];
}
- (void)setOrderInfo:(OrderDetailInfo *)orderInfo
{
    _orderInfo = orderInfo;
    
    self.numberLabel.text = [NSString stringWithFormat:@"订单编号：%@",orderInfo.order_id];
    self.timeLabel.text = [NSString stringWithFormat:@"下单时间：%@",[GSTimeTool formatterNumber:orderInfo.create_time toType:GSTimeType_YYYYMMddHHmm]];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=RGB(247, 247, 247);
        [self addSubview:self.collectImageView];
        [self.collectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
            make.height.equalTo(@(((ScreenWidth-3)/2.0 +60)*6+15));
        }];

        
    }
    return self;
}
-(UIButton *)pasteButton{
    if (_pasteButton==nil) {
        _pasteButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_pasteButton setTitle:@"复制" forState:UIControlStateNormal];
        _pasteButton.titleLabel.font=[UIFont systemFontOfSize:13];
        _pasteButton.layer.cornerRadius=3;
        _pasteButton.layer.masksToBounds=YES;
        _pasteButton.backgroundColor=RGB(233, 40, 46);
        [_pasteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_pasteButton addTarget:self action:@selector(pasteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pasteButton;
}
-(void)pasteButtonAction{
    if (self.pasteButtonBlock) {
        self.pasteButtonBlock();
    }
}
- (UILabel *)numberLabel
{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.font = [UIFont systemFontOfSize:14];
        _numberLabel.text = @"";
    }
    return _numberLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:14];
        _timeLabel.text = @"";
    }
    return _timeLabel;
}
-(UICollectionView *)collectImageView{
    if (_collectImageView==nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //flowLayout.minimumInteritemSpacing = 20;
        flowLayout.minimumLineSpacing = 5;
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectImageView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectImageView.backgroundColor=RGB(247, 247, 247);
        _collectImageView.delegate=self;
        _collectImageView.dataSource=self;
        //作用是显示一半的图片.
        _collectImageView.clipsToBounds=YES;
        _collectImageView.scrollEnabled=NO;
        _collectImageView.showsHorizontalScrollIndicator=NO;
        [_collectImageView registerClass:[ESClusterDetailGoodsCell class] forCellWithReuseIdentifier:@"ESClusterDetailGoodsCell"];
        
    }
    return _collectImageView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ESHomeShopDetailController*vc=[[ESHomeShopDetailController alloc]init];
    GoodsInfo*info=[self.array objectAtIndex:indexPath.item];
    vc.goods_id=info.gid;
    [[AppDelegate shared]pushViewController:vc animated:YES];
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((ScreenWidth-3)/2.0, (ScreenWidth-3)/2.0+60);
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
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
//设置列间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ESClusterDetailGoodsCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ESClusterDetailGoodsCell" forIndexPath:indexPath];
    cell.goodInfo=[self.array objectAtIndex:indexPath.item];
    return cell;
    return  nil;
}



@end

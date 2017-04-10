//
//  ESJionFooterView.m
//  EasyShop
//
//  Created by 就手国际 on 16/10/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterDetailFooterView.h"
#import "ESHomeShopDetailController.h"
#import "ESClusterDetailGoodsCell.h"
@interface ESClusterDetailFooterView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView*collectImageView;
@property (nonatomic,strong) UIImageView*advertisementImageView;
@property (nonatomic,strong) UILabel*likeLabel;
@property (nonatomic,strong) UIView*oneLineView;
@property (nonatomic,strong) UIView*twoLineView;
@property (nonatomic,strong) UIView*threeLineView;
@property (nonatomic,strong) UIView*fourLineView;
@property (nonatomic,strong) UILabel*playLabel;
@property (nonatomic,strong) UIButton*seebutton;
@property (nonatomic,strong) UILabel*leftLabel;//拼团
@property (nonatomic,strong) UILabel*rightLabel;//我的
@property (nonatomic,strong) UIView*centerLineView;
@property (nonatomic,strong) UIView*bgWhiteView;
@property (nonatomic,strong) UIImageView*tipsImageView;
@property (nonatomic,strong) NSArray*array;
@end
@implementation ESClusterDetailFooterView
-(void)setRelationArray:(NSArray *)relationArray{
    
    _array=relationArray;
    [self.collectImageView reloadData];
}
-(NSArray *)array{
    if (_array==nil) {
        _array=[NSArray array];
    }
    return _array;
}
-(void)setDetailInfo:(GetClusterDetailRespone *)detailInfo{
    if ([detailInfo.status isEqualToString:@"2"]) {
        _tipsImageView.image=[UIImage imageNamed:@"clusterDetailFooterFailProcess"];
    }else if ([detailInfo.status isEqualToString:@"3"]){
        _tipsImageView.image=[UIImage imageNamed:@"clusterDetailFooterSuccess"];
        
    }else if ([detailInfo.status isEqualToString:@"4"]){
        _tipsImageView.image=[UIImage imageNamed:@"clusterDetailFooterFail"];
        
    }

}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
       self.backgroundColor=RGB(247, 247, 247);
        //self.backgroundColor=[UIColor whiteColor];
//        [self addSubview:self.advertisementImageView];
//        [self.advertisementImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@20);
//            make.left.right.equalTo(@0);
//            make.height.equalTo(@64);
//            
//        }];
        [self addSubview:self.likeLabel];
        [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.height.equalTo(@30);
            make.left.equalTo(@0);
            make.width.equalTo(@ScreenWidth);
            
            
        }];
        [self addSubview:self.oneLineView];
        [self.oneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@(0));
            make.height.equalTo(@0.5);
            make.top.equalTo(self.likeLabel.mas_bottom).offset(0);
        }];
        [self addSubview:self.collectImageView];
        [self.collectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.oneLineView.mas_bottom).offset(0);
            make.left.right.equalTo(@0);
            make.height.equalTo(@(((ScreenWidth-3)/2.0 +50)*6+15));
        }];
        [self addSubview:self.bgWhiteView];
        [self.bgWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.collectImageView.mas_bottom).offset(5);
            make.left.right.equalTo(@0);
            make.height.equalTo(@80);
        }];
        [self.bgWhiteView addSubview:self.twoLineView];
        [self.twoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
            make.height.equalTo(@0.5);
            
        }];
        [self.bgWhiteView addSubview:self.playLabel];
        [self.playLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10);
            make.top.equalTo(@15);
            make.left.equalTo(@10);
            make.width.equalTo(@100);
        }];
        [self.bgWhiteView addSubview:self.seebutton];
        [self.seebutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@100);
            make.right.equalTo(@(-10));
            make.centerY.equalTo(self.playLabel.mas_centerY).offset(0);
        }];
        [self.bgWhiteView addSubview:self.tipsImageView];
        [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.playLabel.mas_bottom).offset(10);
            make.left.right.equalTo(@0);
            make.height.equalTo(@(ScreenWidth*(77/617.0)));
        }];
        [self.bgWhiteView addSubview:self.threeLineView];
        [self.threeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.height.equalTo(@0.5);
            make.bottom.equalTo(@0.5);
        }];
        [self addSubview:self.centerLineView];
        [self.centerLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.height.equalTo(@15);
            make.width.equalTo(@1);
            make.top.equalTo(self.bgWhiteView.mas_bottom).offset(15);
            
        }];
        [self addSubview:self.leftLabel];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerLineView.mas_centerY).offset(0);
            make.right.equalTo(self.centerLineView.mas_left).offset(-5);
            make.width.equalTo(@100);
            
        }];
        [self addSubview:self.rightLabel];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerLineView.mas_centerY).offset(0);
            make.left.equalTo(self.centerLineView.mas_right).offset(5);
            make.width.equalTo(@140);
            make.height.equalTo(@10);
        }];
        [self addSubview:self.fourLineView];
        [self.fourLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.height.equalTo(@0.5);
            make.right.equalTo(@(-10));
            make.top.equalTo(self.leftLabel.mas_bottom).offset(8);
        }];
        
        
        
    }
    return self;
}
-(UIImageView *)advertisementImageView{
    if (_advertisementImageView==nil) {
        _advertisementImageView=[[UIImageView alloc]init];
        _advertisementImageView.image=[UIImage imageNamed:@"110.jpg"];
        
    }
    return _advertisementImageView;
}
-(UILabel*)likeLabel{
    if (_likeLabel==nil) {
        _likeLabel=[[UILabel alloc]init];
        _likeLabel.backgroundColor=[UIColor whiteColor];
        _likeLabel.font=[UIFont systemFontOfSize:14];
        _likeLabel.textColor=RGB(170, 170, 170);
        _likeLabel.text=@"你可能会喜欢";
        
    }
    return _likeLabel;
}
-(UIView *)oneLineView{
    if (_oneLineView==nil) {
        _oneLineView=[[UIView alloc]init];
        _oneLineView.backgroundColor=RGB(175, 175, 175);
        
    }
    return _oneLineView;
}
-(UIView *)twoLineView{
    if (_twoLineView==nil) {
        _twoLineView=[[UIView alloc]init];
        _twoLineView.backgroundColor=RGB(175, 175, 175);
    }
    return _twoLineView;
    
    
}
-(UILabel *)leftLabel{
    if (_leftLabel==nil) {
        _leftLabel=[[UILabel alloc]init];
        _leftLabel.textAlignment=NSTextAlignmentRight;
        _leftLabel.textColor=RGB(170, 170, 170);
        _leftLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer*leftTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftTapAction)];
        [_leftLabel addGestureRecognizer:leftTap];
        _leftLabel.font=[UIFont systemFontOfSize:12];
        _leftLabel.text=@"拼团";
    }
    return _leftLabel;
}
-(void)leftTapAction{
    if (self.leftTapBlock) {
        self.leftTapBlock();
    }
}
-(UILabel *)rightLabel{
    if (_rightLabel==nil) {
        _rightLabel=[[UILabel alloc]init];
        _rightLabel.textColor=RGB(170, 170, 170);
        _rightLabel.font=[UIFont systemFontOfSize:12];
        _rightLabel.userInteractionEnabled=YES;
        UITapGestureRecognizer*rightTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTapAction)];
        [_rightLabel addGestureRecognizer:rightTap];
        _rightLabel.text=@"我的团";
    }
    return _rightLabel;
}
-(void)rightTapAction{
    if (self.rightTapBlock) {
        self.rightTapBlock();
    }
}
-(UIView *)centerLineView{
    if (_centerLineView==nil) {
        _centerLineView=[[UIView alloc]init];
        _centerLineView.backgroundColor=RGB(175, 175, 175);
    }
    return _centerLineView;
}
-(UIView *)bgWhiteView{
    if (_bgWhiteView==nil) {
        _bgWhiteView=[[UIView alloc]init];
        _bgWhiteView.backgroundColor=[UIColor whiteColor];
    }
    return _bgWhiteView;
}
-(UILabel *)playLabel{
    if (_playLabel==nil) {
        _playLabel=[[UILabel alloc]init];
        _playLabel.text=@"拼团玩法介绍";
        _playLabel.textColor=RGB(175, 175, 175);
        _playLabel.font=[UIFont systemFontOfSize:12];
    }
    return _playLabel;
}
-(UIButton *)seebutton{
    if (_seebutton==nil) {
        _seebutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_seebutton setTitle:@"查看具体玩法" forState:UIControlStateNormal];
        [_seebutton setTitleColor:RGB(90, 90, 90) forState:UIControlStateNormal];
        _seebutton.titleLabel.font=[UIFont systemFontOfSize:13];
        [_seebutton addTarget:self action:@selector(seebuttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _seebutton;
}
-(UIImageView *)tipsImageView{
    if (_tipsImageView==nil) {
        _tipsImageView=[[UIImageView alloc]init];
        _tipsImageView.image=[UIImage imageNamed:@"arrow"];
    }
    return _tipsImageView;
}
-(UIView *)threeLineView{
    if (_threeLineView==nil) {
        _threeLineView=[[UIView alloc]init];
        _threeLineView.backgroundColor=RGB(175, 175, 175);
        
    }
    return _threeLineView;
}
-(UIView *)fourLineView{
    if (_fourLineView==nil) {
        _fourLineView=[[UIView alloc]init];
        _fourLineView.backgroundColor=RGB(175, 175, 175);
        
    }
    return _fourLineView;
}
-(void)seebuttonAction{
    if (self.seeButtonBlock) {
        self.seeButtonBlock();
    }
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
}

@end

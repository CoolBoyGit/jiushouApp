//
//  ESJoinListPeopleImageCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/13.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterDetailPeopleCell.h"
#import "ESClusterDetPeoCollCell.h"
@interface ESClusterDetailPeopleCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UILabel*manyLabel;
@property (nonatomic,strong) UICollectionView*collectImageView;
@end
@implementation ESClusterDetailPeopleCell
-(void)setClusterDetail:(GetClusterDetailRespone *)clusterDetail{
    _clusterDetail=clusterDetail;
    
    self.manyLabel.text= [NSString stringWithFormat:@"%@人团",clusterDetail.s_num];
    if ([clusterDetail.status isEqualToString:@"2"]) {
        [self.contentView addSubview:self.collectImageView];
        [self.collectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@10);
            make.left.equalTo(@20);
            make.right.equalTo(@(-20));
            make.bottom.equalTo(@0);
        }];

        
    }else if ([clusterDetail.status isEqualToString:@"3"]||[clusterDetail.status isEqualToString:@"4"]){
        [self.contentView addSubview:self.manyLabel];
        [self.manyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.left.right.equalTo(@0);
        }];
        [self.contentView addSubview:self.collectImageView];
        [self.collectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.manyLabel.mas_bottom).offset(15);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.bottom.equalTo(@0);
        }];

       
        
    }
    [self.collectImageView reloadData];
    
}

-(UILabel *)manyLabel{
    if (_manyLabel==nil) {
        _manyLabel=[[UILabel alloc]init];
        _manyLabel.text=@"3人团";
        _manyLabel.textColor=AllTextColor;
        _manyLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _manyLabel;
}
-(UICollectionView *)collectImageView{
    if (_collectImageView==nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing=20;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectImageView=[[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectImageView.backgroundColor=[UIColor clearColor];
        _collectImageView.delegate=self;
        _collectImageView.dataSource=self;
        //作用是显示一半的图片.
        _collectImageView.clipsToBounds=YES;
        _collectImageView.showsHorizontalScrollIndicator=NO;
        [_collectImageView registerClass:[ESClusterDetPeoCollCell class] forCellWithReuseIdentifier:@"ESClusterDetPeoCollCell"];
    }
    return _collectImageView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView. backgroundColor=RGB(248, 248, 248);
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        //判断的标志不可有放在这里.
    }
    return self;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(45, 45);
}
//设置距离两边的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
   CGFloat w= (collectionView.frame.size.width-((self.clusterDetail.member.count*45)+((self.clusterDetail.member.count-1)*20)))/2;
    if (w<20) {
        w=20;
    }
    return UIEdgeInsetsMake(0, w, 0, w);

}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    return self.clusterDetail.member.count;
   
}
//设置列间距
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 20;
//}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ESClusterDetPeoCollCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ESClusterDetPeoCollCell" forIndexPath:indexPath];
    ClusterDetailMemberRespone*memberRespone=[[ClusterDetailMemberRespone alloc]init];
    memberRespone=[self.clusterDetail.member objectAtIndex:indexPath.row];
    cell.menberInfo=memberRespone;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

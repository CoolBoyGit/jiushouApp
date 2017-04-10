//
//  ESPeopleCollectionCell.m
//  EasyShop
//
//  Created by jiushou on 16/10/13.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESClusterDetPeoCollCell.h"
@interface ESClusterDetPeoCollCell()
@property (nonatomic,strong)UIImageView*imageView;
@end
@implementation ESClusterDetPeoCollCell
-(void)setMenberInfo:(ClusterDetailMemberRespone *)menberInfo{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:menberInfo.logo] placeholderImage:[UIImage imageNamed:@"110.jpg"]];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return self;
}
-(UIImageView *)imageView{
    if (_imageView==nil) {
        _imageView=[[UIImageView alloc]init];
        _imageView.layer.cornerRadius=22.5;
        _imageView.layer.masksToBounds=YES;
        _imageView.image=[UIImage imageNamed:@"110.jpg"];
    }
    return _imageView;
}
@end

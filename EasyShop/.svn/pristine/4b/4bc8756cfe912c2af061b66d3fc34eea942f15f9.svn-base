//
//  ESSpectionHeardView.m
//  EasyShop
//
//  Created by jiushou on 16/6/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSpectionHeardView.h"
@interface ESSpectionHeardView ()
@property (nonatomic,strong)UIImageView*heardImageView;
@end

@implementation ESSpectionHeardView
-(void)setImageStr:(NSString *)imageStr{
    [self.heardImageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
     
    
}
-(UIImageView *)heardImageView{
    if (_heardImageView==nil) {
       
        _heardImageView=[[UIImageView alloc]initWithFrame:self.bounds];
//        [_heardImageView sd_setImageWithURL:[NSURL URLWithString:self.imageStr]];
    }
    return _heardImageView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.heardImageView];
        [self.heardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
    }
    return self;
    
}
@end

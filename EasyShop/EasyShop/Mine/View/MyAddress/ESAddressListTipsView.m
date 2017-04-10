//
//  ESAddressListTipsView.m
//  EasyShop
//
//  Created by 就手国际 on 16/12/23.
//  Copyright © 2016年 ldz. All rights reserved.
//

#import "ESAddressListTipsView.h"
@interface ESAddressListTipsView()
@property (nonatomic,strong) UILabel*tipsLabel;
@end
@implementation ESAddressListTipsView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.right.equalTo(@(-20));
            make.top.bottom.equalTo(@0);
        }];
    }
    return self;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.textColor=RGB(80, 80, 80);
        _tipsLabel.numberOfLines=0;
        _tipsLabel.font=[UIFont systemFontOfSize:13];
        NSTextAttachment*attach=[[NSTextAttachment alloc]init];
        attach.image=[UIImage imageNamed:@"mine_address_plaint"];
        attach.bounds=CGRectMake(0, -5, 20, 20);
        NSAttributedString*string=[NSAttributedString attributedStringWithAttachment:attach];
        NSMutableAttributedString*atti=[[NSMutableAttributedString alloc]initWithString:@"最多保存10个有效收货地址,请注意!"];
        [atti insertAttributedString:string atIndex:0];
        
        _tipsLabel.attributedText=atti;
        
    }
    return _tipsLabel;
}
@end

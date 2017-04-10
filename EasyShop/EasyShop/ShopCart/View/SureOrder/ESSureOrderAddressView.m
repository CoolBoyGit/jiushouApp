//
//  ESSureOrderAddressView.m
//  EasyShop
//
//  Created by guojian on 16/5/22.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSureOrderAddressView.h"
#import "ESAddressListController.h"

@interface ESSureOrderAddressView()

/** title */

@property (nonatomic,strong) UIButton*button;


@property (nonatomic,strong) UILabel*nameLabel;
@property (nonatomic,strong) UILabel*phoneLabel;
@property (nonatomic,strong) UILabel*addressLabel;
@property (nonatomic,strong) UIImageView*imageView;
@property (nonatomic,strong) UIView*bgView;
@property (nonatomic,strong) UILabel*persionIdLabel;
@property (nonatomic,strong) UIView*tipsView;
@property (nonatomic,strong) UIImageView*tipsImageView;
@property (nonatomic,strong) UILabel*tipsLabel;
@end

@implementation ESSureOrderAddressView

- (void)setAddressInfo:(AddressInfo *)addressInfo
{
    if (addressInfo==nil) {
        _tipsView.hidden=NO;
        
    }else{
        _tipsView.hidden=YES;
        _addressInfo = addressInfo;
        self.nameLabel.text=[NSString stringWithFormat:@"收件人: %@",_addressInfo.name];
        //self.addressLabel.text = [NSString stringWithFormat:@"%@%@",[NSString handleString:_addressInfo.area],[NSString handleString:_addressInfo.address]];
        NSString*str=[NSString stringWithFormat:@"%@%@",addressInfo.area,addressInfo.address];
        //设置行距
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.alignment = NSTextAlignmentLeft;
        paraStyle.lineSpacing = 5;//设置高度
        paraStyle.hyphenationFactor = 1.0;
        paraStyle.firstLineHeadIndent = 0.0;
        paraStyle.paragraphSpacingBefore = 0.0;
        paraStyle.headIndent = 0;
        paraStyle.tailIndent = 0;
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:14], NSParagraphStyleAttributeName:paraStyle};
        NSAttributedString*astr=[[NSAttributedString alloc]initWithString:str attributes:dic];
        self.addressLabel.attributedText=astr;
        self.phoneLabel.text=[NSString stringWithFormat:@"%@",[_addressInfo.mobile stringByReplacingCharactersInRange:NSMakeRange(4, 3) withString:@"***"]];
        if (addressInfo.personid .length==0) {
            self.persionIdLabel.text=@"身份证: ";
        }else{
            self.persionIdLabel.text=[NSString stringWithFormat:@"身份证: %@",[addressInfo.personid stringByReplacingCharactersInRange:NSMakeRange(4, 9) withString:@"*********"]];
        }

    }
}
-(UIButton *)button{
    if (_button==nil) {
        _button=[UIButton buttonWithType:UIButtonTypeCustom];
        [_button setBackgroundImage:[UIImage imageNamed:@"sureOrderLeftButton"] forState:UIControlStateNormal];
        
    }
    return _button;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addTarget:self action:@selector(changeAction) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor=RGB(247, 247, 247);
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 10, 0));
        }];
        [self.bgView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.left.equalTo(@43);
            make.height.equalTo(@20);
            //make.width.equalTo(@100);
            
        }];
        [self.bgView addSubview:self.phoneLabel];
        [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@15);
            make.left.equalTo(self.nameLabel.mas_right).offset(30);
            make.height.equalTo(@20);
        }];
        [self.bgView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.equalTo(@43);
            make.right.equalTo(@(-40));
        }];
        [self.bgView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(@8);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
        [self.bgView addSubview:self.persionIdLabel];
        [self.persionIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.addressLabel.mas_bottom).offset(10);
            make.left.equalTo(@43);
        }];
        [self.bgView addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgView.mas_centerY).offset(0);
            make.right.equalTo(@(-20));
            make.height.equalTo(@7);
            make.width.equalTo(@10);
        }];
        [self.bgView addSubview:self.tipsView];
        [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        [self.tipsView addSubview:self.tipsImageView];
        [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(@30);
            make.width.height.equalTo(@50);
        }];
        [self.tipsView addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipsImageView.mas_bottom).offset(10);
            make.centerX.equalTo(self.mas_centerX).offset(0);
        }];
      

    }
    return self;
}
-(UIView *)tipsView{
    if (_tipsView==nil) {
        _tipsView=[[UIView alloc]init];
        _tipsView.backgroundColor=[UIColor whiteColor];
    }
    return _tipsView;
}
- (void)changeAction
{
    ESAddressListController *adddrss = [[ESAddressListController alloc] init];
    adddrss.isOrder = YES;
    @weakify(self);
    adddrss.addressBlock = ^(AddressInfo *info){
        @strongify(self);
        self.addressInfo = info;
    };
    [[AppDelegate shared] pushViewController:adddrss animated:YES];

}
-(UILabel *)persionIdLabel{
    if (_persionIdLabel==nil) {
        _persionIdLabel=[[UILabel alloc]init];
        _persionIdLabel.textColor=AllTextColor;
        _persionIdLabel.font=[UIFont systemFontOfSize:14];
    }
    return _persionIdLabel;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=[UIColor whiteColor];
    }
    return _bgView;
}
-(UILabel *)nameLabel{
    if (_nameLabel==nil) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.text=@"李达志";
        _nameLabel.font=[UIFont systemFontOfSize:14];
        _nameLabel.textColor=AllTextColor;
    }
    return _nameLabel;
}
-(UILabel *)phoneLabel{
    if (_phoneLabel==nil) {
        _phoneLabel=[[UILabel alloc]init];
        _phoneLabel.text=@"15088132593";
        _phoneLabel.font=[UIFont systemFontOfSize:14];
        _phoneLabel.textColor=AllTextColor;
    }
    return _phoneLabel;
}
-(UILabel *)addressLabel{
    if (_addressLabel==nil) {
        _addressLabel=[[UILabel alloc]init];
        _addressLabel.text=@"广东 江门市 碰见区 广东就手电子商务有限公司176号之一";
        _addressLabel.numberOfLines=0;
        _addressLabel.textColor=AllTextColor;
        
    }
    return _addressLabel;
}
-(UIImageView *)imageView{
    if (_imageView==nil) {
        _imageView=[[UIImageView alloc]init];
        _imageView.image=[UIImage imageNamed:@"share_location"];
    }
    return _imageView;
}
-(UIImageView *)tipsImageView{
    if (_tipsImageView==nil) {
        _tipsImageView=[[UIImageView alloc]init];
        _tipsImageView.image=[UIImage imageNamed:@"share_location"];
    }
    return _tipsImageView;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.font=[UIFont systemFontOfSize:18];
        _tipsLabel.textColor=AllTextColor;
        NSString*str=@"你还没有收货地址,去添加";
        NSMutableAttributedString*mustr=[[NSMutableAttributedString alloc]initWithString:str];
        [mustr addAttributes:@{NSForegroundColorAttributeName:RGB(233, 40, 46)} range:NSMakeRange(str.length-3, 3)];
        
        _tipsLabel.attributedText=mustr;
    }
    return _tipsLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

   

}


@end

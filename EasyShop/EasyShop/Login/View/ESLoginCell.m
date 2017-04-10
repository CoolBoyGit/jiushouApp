
//
//  ESLoginCell.m
//  EasyShop
//
//  Created by 就手国际 on 17/1/13.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESLoginCell.h"
#import "ESInputTextField.h"
@interface ESLoginCell()

@property (nonatomic,strong) UILabel*mobileLabel;
@end
@implementation ESLoginCell
-(void)setModel:(ESLoginModel *)model{
    self.mobileLabel.text=model.mobile;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.mobileLabel];
        [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@70);
            make.top.bottom.equalTo(@0);
        }];
    }
    return self;
}
-(UILabel *)mobileLabel{
    if (_mobileLabel==nil) {
        _mobileLabel=[[UILabel alloc]init];
        _mobileLabel.textColor=RGB(100, 100, 100);
        _mobileLabel.font=[UIFont systemFontOfSize:16];
        _mobileLabel.text=@"15088132593";
    }
    return _mobileLabel;
}

@end

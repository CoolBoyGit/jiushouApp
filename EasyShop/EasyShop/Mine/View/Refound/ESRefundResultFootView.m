//
//  ESRefundResultFootView.m
//  EasyShop
//
//  Created by 就手国际 on 16/11/21.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESRefundResultFootView.h"
@interface ESRefundResultFootView()
@property (nonatomic,strong) UILabel*label;

@end

@implementation ESRefundResultFootView
-(UILabel *)label{
    if (_label==nil) {
        _label=[[UILabel alloc]init];
        _label.textColor=RGB(78, 78, 90);
        _label.font=[UIFont systemFontOfSize:14];
        _label.text=@"猜你喜欢";
        _label.textAlignment=NSTextAlignmentCenter;
        _label.backgroundColor=[UIColor whiteColor];
    }
    return _label;
}
-(instancetype)init{
    if (self=[super init]) {
        self.backgroundColor=RGB(247, 247, 247);
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
            make.bottom.equalTo(@(-10));
        }];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

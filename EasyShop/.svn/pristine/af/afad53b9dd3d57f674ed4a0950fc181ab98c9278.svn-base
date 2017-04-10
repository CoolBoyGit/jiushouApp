//
//  SearchTwoReusableView.m
//  EasyShop
//
//  Created by jiushou on 16/6/27.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "SearchTwoReusableView.h"
@interface SearchTwoReusableView()
@property (nonatomic, strong) UILabel *titleName;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic,strong) UIView *graView;
@end
@implementation SearchTwoReusableView
-(UIView *)graView{
    if (_graView==nil) {
        _graView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 12)];
        _graView.backgroundColor=RGB(250, 250, 250);
        
    }
    return _graView;
}
- (UILabel *)titleName
{
    if (_titleName == nil) {
        _titleName = [[UILabel alloc] init];
        _titleName.font = [UIFont systemFontOfSize:14];
        _titleName.layer.borderWidth=1;
        _titleName.layer.masksToBounds=YES;
        _titleName.layer.cornerRadius=8;
        _titleName.textAlignment=NSTextAlignmentCenter;
        _titleName.textColor = [UIColor blackColor];
    }
    return _titleName;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor redColor];
    }
    return _imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //        [self addSubview:self.imageView];
        //        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(@12);
        //            make.centerY.equalTo(@0);
        //            make.width.equalTo(@20);
        //            make.height.equalTo(@20);
        //        }];
        [self addSubview:self.graView];
        [self.graView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.height.equalTo(@12);
            make.right.left.equalTo(@0);
        }];
        [self addSubview:self.titleName];
        [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@7);
            make.width.equalTo(@90);
            make.top.equalTo(@17);
            make.bottom.equalTo(@(-7));
            
        }];
        [self addSubview:self.delectButton];
        [self.delectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.top.equalTo(@17);
            make.bottom.equalTo(@(-7));
            make.right.equalTo(@(-10));
            
        }];
        
    }
    return self;
}

//-(void)setDelectButton:(UIButton *)delectButton{
//    delectButton.hidden=NO;
//}
-(UIButton *)delectButton{
    if (_delectButton==nil) {
        _delectButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 30)];
        //_delectButton.hidden=YES;
        _delectButton.layer.borderWidth=0.5;
        _delectButton.layer.cornerRadius=5;
        _delectButton.layer.masksToBounds=YES;
        _delectButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_delectButton setTitle:@"删除" forState:UIControlStateNormal];
        [_delectButton addTarget:self action:@selector(delectButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_delectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return _delectButton;
}
-(void)delectButtonAction{
    if (self.delectButtonBlock) {
        self.delectButtonBlock();
    }
}
- (void)setTitle:(NSString *)title
{
    self.titleName.text = title;
}


@end

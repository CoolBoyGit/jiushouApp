//
//  ESTabbar.m
//  EasyShop
//
//  Created by wcz on 16/5/22.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESTabbar.h"
#import "ESButton.h"

@interface ESTabbar ()

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation ESTabbar

- (NSArray *)array
{
    if (_array == nil) {
        _array = @[
                   @{
                       @"title":@"首页",
                       @"image":@"tabbar_home_normal",
                       @"selectImage":@"tabbar_home_select"
                       },
                   
                   @{
                       @"title":@"拼团",
                       @"image":@"tabbar_cluster_normal",
                       @"selectImage":@"tabbar_cluster_select"
                       },
                   
                    @{
                       @"title":@"购物车",
                       @"image":@"tabbar_shopcar_normal",
                       @"selectImage":@"tabbar_shopcar_select"
                       },
                   
                   @{
                       @"title":@"我的",
                       @"image":@"tabbar_mime_normal",
                       @"selectImage":@"tabbar_mime_select"
                       },
                   
                   ];
    }
    return _array;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changSeleIndex) name:TapClusterPopCluster object:nil];
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changEmaSeleIndex) name:EaseMobLoginSuccess object:nil];
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changShopCarIndex) name:ClickShopCarButtonToShopCar object:nil];
        self.dk_backgroundColorPicker=DKColorPickerWithKey(BG);
        self.buttonArray = [NSMutableArray arrayWithCapacity:4];
        for (int i = 0; i < self.array.count; i ++)
        {
            UIView *view = [self intailizedViewWithDic:self.array[i] withIndex:i];
            view.frame = CGRectMake(ScreenWidth / self.array.count * i, 0, ScreenWidth/self.array.count, 49);
            [self addSubview:view];
        }
    }
    return self;
}


- (UIView *)intailizedViewWithDic:(NSDictionary *)dic withIndex:(NSInteger)index
{
    UIView *view = [[UIView alloc]init];
    ESButton *button = [[ESButton alloc] initWithFrame:CGRectMake(0, 0, 50, 49)];
    button.tag = 100 + index;
    [button setTitle:dic[@"title"] forState:UIControlStateNormal];
    [button setTitle:dic[@"title"] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:RGB(233, 40, 46) forState:UIControlStateSelected];
    if (kUserManager.isUseOtherImage) {
            [button setImage: [UIImage imageWithContentsOfFile:[kUserManager.themRootRoute stringByAppendingPathComponent:dic[@"image"]]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageWithContentsOfFile:[kUserManager.themRootRoute stringByAppendingPathComponent:dic[@"selectImage"]]] forState:UIControlStateSelected];
    }else{
        [button setImage: [UIImage imageNamed:dic[@"image"]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:dic[@"selectImage"]] forState:UIControlStateSelected];
    }
    [self.buttonArray addObject:button];
    [button addTarget:self action:@selector(buttonBeTouch:) forControlEvents:UIControlEventTouchUpInside];
    if (button.tag==100) {
        button.selected=YES;
    }
    [view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.top.bottom.equalTo(@0);
        make.width.equalTo(@50);
    }];
    return view;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)changEmaSeleIndex{
    for (UIButton *button in self.buttonArray) {
        if (button.tag-100==0) {
            button.selected=YES;
        }else {
            button.selected=NO;
        }
    }

}
-(void)changShopCarIndex{
    for (UIButton *button in self.buttonArray) {
        if (button.tag-100==2) {
            button.selected=YES;
        }else {
            button.selected=NO;
        }
    }

}
-(void)changSeleIndex{
    for (UIButton *button in self.buttonArray) {
        if (button.tag-100==1) {
            button.selected=YES;
        }else {
            button.selected=NO;
        }
    }
}
- (void)buttonBeTouch:(UIButton *)button
{
    for (UIButton *button in self.buttonArray) {
        button.selected = NO;
    }
    [self animationStart:button];
    button.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ESTabbarDidSelectIndex:)]) {
        [self.delegate ESTabbarDidSelectIndex:button.tag -100];
    }
}

- (void)animationStart:(UIButton *)button
{
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.95];
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.duration = 0.3;
    [button.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}


@end

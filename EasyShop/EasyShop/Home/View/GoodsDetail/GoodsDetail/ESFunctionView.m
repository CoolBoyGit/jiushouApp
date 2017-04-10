//
//  ESFunctionView.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/3/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESFunctionView.h"
#import "ESTopBottomLabelButton.h"
@interface ESFunctionView()

@property (nonatomic, strong) ESTopBottomLabelButton *addToShopCart;//加入购物车
@property (nonatomic,strong) ESTopBottomLabelButton* jionInButton;//拼团按钮
@property (nonatomic,assign) NSInteger count;
@end


@implementation ESFunctionView

- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont systemFontOfSize:10];
        _countLabel.layer.cornerRadius = 8;
        _countLabel.layer.masksToBounds = YES;
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.backgroundColor = RGB(233, 40, 46);
    }
    return _countLabel;
}
-(UIView *)lineView{
    if (_lineView==nil) {
        _lineView=[[UIView alloc]init];
        _lineView.backgroundColor=RGB(247, 247, 247);
        
    }
    return _lineView;
}
-(void)setGoodsDetail:(GoodsDetailInfo *)goodsDetail{
    _goodsDetail=goodsDetail;
    _dreamBtn.selected=_goodsDetail.isCollect;
    self.count=goodsDetail.cart_info.goods_sum;
        self.jionInButton.topLabel.text=[NSString stringWithFormat:@"￥ %@",goodsDetail.cluster_price];
    self.jionInButton.bottomLbel.text=[NSString stringWithFormat:@"%@人团",goodsDetail.cluster_member];
    NSString *title = @"加入购物车";
    switch (goodsDetail.goodsInfoType) {
        case GoodsInfoType_Remind:  title = @"到货提醒";    break;
        case GoodsInfoType_Wish:    title = @"心愿单";     break;
        case GoodsInfoType_Sell:    title = @"加入购物车";   break;
    }
   
    if (goodsDetail.goodsInfoType==GoodsInfoType_Sell) {
        if ([goodsDetail.cluster isEqualToString:@"0"]) {
            [self addSubview:self.addToShopCart];
            [self.addToShopCart mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).with.offset(150);
                make.top.equalTo(self.mas_top).with.offset(0.35);
                make.width.equalTo(@(ScreenWidth-150));
                make.height.equalTo(@43.65);
            }];
            self.addToShopCart.titleLabel.font=[UIFont systemFontOfSize:17];
            [self.addToShopCart setTitle:title forState:UIControlStateNormal];
            [self.addToShopCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.addToShopCart.backgroundColor=RGBA(233, 40, 46,1);
            
            

        }else{
            [self addSubview:self.addToShopCart];
            [self.addToShopCart mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.mas_left).with.offset(150);
                make.top.equalTo(self.mas_top).with.offset(0.35);
                make.width.equalTo(@((ScreenWidth-150)/2.0-5));
                make.height.equalTo(@43.65);
            }];
            
            [self addSubview:self.jionInButton];
            [self.jionInButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.addToShopCart.mas_right).with.offset(0);
                make.top.equalTo(self.mas_top).with.offset(0.35);
                make.width.equalTo(@((ScreenWidth-150)/2.0+5));
                make.height.equalTo(@43.65);
            }];
            self.addToShopCart.topLabel.text=[NSString stringWithFormat:@"￥ %@",goodsDetail.price];
           self.addToShopCart.bottomLbel.text=title;
             self.addToShopCart.backgroundColor=RGBA(233, 40, 46, 0.6);

        }
        
        
    }else{
        [self addSubview:self.addToShopCart];
        [self.addToShopCart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(150);
            make.top.equalTo(self.mas_top).with.offset(0.35);
            make.width.equalTo(@(ScreenWidth-150));
            make.height.equalTo(@43.65);
        }];
        self.addToShopCart.titleLabel.font=[UIFont systemFontOfSize:17];
        [self.addToShopCart setTitle:title forState:UIControlStateNormal];
        [self.addToShopCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.addToShopCart.backgroundColor=RGBA(233, 40, 46, 1);
    }
   }
-(void)setIsSelect:(BOOL)isSelect{
    _dreamBtn.selected=isSelect;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogin) name:kUserLoginNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLogout) name:kUserLogoutNotification object:nil];
        [self setupViews];
        [self fetchCart:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateCountLbelText:) name:kCartInfoUpdateNotification object:nil];
       
    }
    return self;
}
-(void)userDidLogin{
    [self addSubview:self.countLabel];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@82);
        make.top.equalTo(self.mas_top).with.offset(2.5);
        make.width.height.equalTo(@16);
        
    }];

}
-(void)userDidLogout{
    [self.countLabel removeFromSuperview];
}
- (void)fetchCart:(NSString*)str
{
    CartRequest *request = [CartRequest request];
    
    @weakify(self);
    [ESService cartRequest:request success:^(CartInfo *response) {
        @strongify(self);
        int couont=0;
        NSArray*array=response.shopsItems;
        for (CartShopInfo*info in array) {
            NSArray*shopInfoArray=info.goodsItems;
            for (CartGoodsInfo*goodsInfo in shopInfoArray) {
                couont+=goodsInfo.goods_num.intValue;
            }
        }
        if (couont==0) {
            self.countLabel.hidden=YES;
        }else{
            self.countLabel.hidden=NO;
            self.countLabel.text=[NSString stringWithFormat:@"%d",couont];
            if (str.length>0) {
                
                UIBezierPath*path=[UIBezierPath bezierPath];
                CAKeyframeAnimation*animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
                path.lineWidth=0.9;
                path.lineCapStyle=kCGLineCapRound;
                path.lineJoinStyle=kCGLineCapRound;
                [path moveToPoint:CGPointMake(self.countLabel.centerX , self.countLabel.centerY)];
                
                [path addCurveToPoint:CGPointMake(self.countLabel.centerX , self.countLabel.centerY) controlPoint1:CGPointMake(self.countLabel.centerX, -13) controlPoint2:CGPointMake(self.countLabel.centerX, -13)];
                animation.path=path.CGPath;
                animation.duration=1;
                [self.countLabel.layer addAnimation:animation forKey:@"222"];
            }

    }
        
      
        
        
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)updateCountLbelText:(NSNotification*)noti{
    [self fetchCart:noti.object];
   
}

- (void)setupViews
{
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.right.equalTo(@0);
        make.height.equalTo(@0.35);
    }];
    [self addSubview:self.dreamBtn];
    [self.dreamBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0.35);
        make.width.equalTo(@50);
        make.height.equalTo(@43.65);
    }];
    
    [self addSubview:self.shopCart];
    [self.shopCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dreamBtn.mas_right).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0.35);
        make.width.equalTo(@50);
        make.height.equalTo(@43.65);
    }];

    
    [self addSubview:self.forumBtn];
    [self.forumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopCart.mas_right).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0.35);
        make.width.equalTo(@50);
        make.height.equalTo(@43.65);
    }];
    //[kKeyWindow addSubview:self.countLabel];
    self.countLabel.text = @"";
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    if (kUserManager.isLogin) {
        [self addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@82);
            make.top.equalTo(self.mas_top).with.offset(2.5);
            make.width.height.equalTo(@16);
            
        }];

    }else{
        
    }
    
    self.addToShopCart.alpha = 1.0f;
    self.forumBtn.alpha = 1.0f;
    self.shopCart.alpha = 1.0f;
    self.dreamBtn.alpha = 1.0f;
}
-(ESTopBottomLabelButton *)addToShopCart
{
    if (!_addToShopCart) {
        _addToShopCart = [[ESTopBottomLabelButton alloc ]init];
        _addToShopCart.topLabel.text=@"";
        _addToShopCart.bottomLbel.text=@"";
        _addToShopCart.tag = 103;
        [_addToShopCart addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
    return _addToShopCart;
}
-(ESTopBottomLabelButton *)jionInButton{
    if (!_jionInButton ) {
        _jionInButton=[[ESTopBottomLabelButton alloc]init];
        _jionInButton.backgroundColor=RGBA(233, 40, 46, 1);
//        [_jionInButton setTitle:@"2人团" forState:UIControlStateNormal];
        _jionInButton.topLabel.text=@"";
        _jionInButton.bottomLbel.text=@"";
        _jionInButton.tag=104;
        [_jionInButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jionInButton;
}
-(UIButton *)forumBtn
{
    if (!_forumBtn) {
        _forumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _forumBtn.tag = 102;
        [_forumBtn setImage:[UIImage imageNamed:@"detail_services"] forState:UIControlStateNormal];
        [_forumBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forumBtn;
}
-(UIButton *)shopCart
{
    if (!_shopCart) {
        _shopCart = [UIButton buttonWithType:UIButtonTypeCustom];
        _shopCart.tag = 101;
        [_shopCart setImage:[UIImage imageNamed:@"detail_shopcar"] forState:UIControlStateNormal];
        
        [_shopCart addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shopCart];
    }
    return _shopCart;
}
-(UIButton *)dreamBtn
{
    if (!_dreamBtn) {
        _dreamBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dreamBtn.tag = 100;
        [_dreamBtn setImage:[UIImage imageNamed:@"detail_collect_normal"] forState:UIControlStateNormal];
        [_dreamBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_dreamBtn setImage:[UIImage imageNamed:@"detail_collect_select"] forState:UIControlStateSelected];
        [_dreamBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dreamBtn;
}

-(void)btnClick:(UIButton *)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(functionViewAction:)]) {
        [_delegate functionViewAction:(int)btn.tag];
    }
}



@end

//
//  ESShopDetailCell.m
//  EasyShop
//
//  Created by 脉融iOS开发 on 16/3/27.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShopDetailCell.h"

@interface ESShopDetailCell()<UIScrollViewDelegate,UIWebViewDelegate>

//@property (nonatomic, strong) UILabel *lineLabel;//中间线
//@property (nonatomic, strong) UIImageView *shopDetailImg;//商品详情图片

/** webView */
@property (nonatomic,weak) UIWebView *webView;

@end

@implementation ESShopDetailCell

//- (void)setImageUrl:(NSString *)imageUrl
//{
//    _imageUrl = imageUrl;
//    
//    [self.shopDetailImg sd_setImageWithURL:[NSURL URLWithString:imageUrl]
//                          placeholderImage:[UIImage imageNamed:@"page2"]];
//}
//
//-(UIImageView *)shopDetailImg
//{
//    if (!_shopDetailImg) {
//        _shopDetailImg = [[UIImageView alloc] init];
////        _shopDetailImg.contentMode = UIViewContentModeScaleAspectFill;
//    }
//    return _shopDetailImg;
//}

- (void)setBody:(NSString *)body
{
    _body = body;
    
    [self.webView loadHTMLString:body baseURL:nil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self intalizedView];
        
        UIWebView *webView = [[UIWebView alloc] init];
        webView.delegate = self;
        [self.contentView addSubview:webView];
        self.webView = webView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.webView.frame = self.bounds;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
        CGFloat offsetY = scrollView.contentOffset.y;
        
        
//        if (offsetY < 0) {
//            if ([self.delegate respondsToSelector:@selector(topTableViewDidScrollTop:)]) {
//                [self.delegate topTableViewDidScrollTop:self];
//            }
//        }
}

//-(void)intalizedView
//{
//    [self.contentView addSubview:self.shopDetailImg];
//    [self.shopDetailImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(@0);
//        make.top.equalTo(@2);
//    }];
//
//    [self.contentView addSubview:self.lineLabel];
//    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@20);
//        make.right.equalTo(@-20);
//        make.top.equalTo(@0);
//        make.height.equalTo(@0.5);
//    }];
//}
//
//- (void)setModel:(id)model
//{
//    self.lineLabel.alpha = 1.0f;
//    self.shopDetailImg.image = [UIImage imageNamed:@"page2"];
//}
//
//-(UILabel *)lineLabel
//{
//    if (!_lineLabel) {
//        _lineLabel = [[UILabel alloc] init];
//        _lineLabel.backgroundColor = ADeanHEXCOLOR(0xeeeeee);
//    }
//    return _lineLabel;
//}


@end

//
//  ESImageCollectionViewCell.m
//  EasyShop
//
//  Created by wcz on 16/3/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESImageCollectionViewCell.h"

@interface ESImageCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ESImageCollectionViewCell

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    if (self.isHome) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl]
                          placeholderImage:[UIImage imageNamed:@"bg"]];
    }
    else{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl]
                          placeholderImage:[UIImage imageNamed:@"bg414*414"]];
    }
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"bg"];
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds=YES;
    }
    return _imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
    }
    return self;
}


@end
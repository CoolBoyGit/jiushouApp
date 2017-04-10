


//
//  ESPostCommentImageCell.m
//  EasyShop
//
//  Created by wcz on 16/7/14.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESPostCommentImageCell.h"

@interface ESPostCommentImageCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ESPostCommentImageCell


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

-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}
@end

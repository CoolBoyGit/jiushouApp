//
//  ESSearchResultCell.m
//  EasyShop
//
//  Created by wcz on 16/6/27.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSearchResultCell.h"

@interface ESSearchResultCell ()

@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end

@implementation ESSearchResultCell
-(void)setKey:(KeyWord *)key{
    self.titleNameLabel.text=key.keyword;
    self.countLabel.text=@"";
}
-(UILabel *)titleNameLabel
{
    if (_titleNameLabel == nil) {
        _titleNameLabel = [[UILabel alloc] init];
        _titleNameLabel.textColor=RGB(113,113,113);
        _titleNameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleNameLabel;
}

- (UILabel *)countLabel
{
    if (_countLabel == nil) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont systemFontOfSize:12];
        _countLabel.textColor = [UIColor lightGrayColor];
    }
    return _countLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_STSearchBar"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.equalTo(@12);
        }];
        [self.contentView addSubview:self.titleNameLabel];
        [self.titleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imageView.mas_right).offset(15);
            make.centerY.equalTo(@0);
        }];
        
        [self.contentView addSubview:self.countLabel];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-12));
            make.centerY.equalTo(@0);
        }];
    }
    return self;
}

- (void)setModel:(id)model
{
    self.titleNameLabel.text = @"好东西";
    self.countLabel.text = @"总共10件";
}

@end

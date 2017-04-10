








//
//  ESShareScrollviewCell.m
//  EasyShop
//
//  Created by wcz on 16/6/8.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESShareScrollviewCell.h"
#import "ESShareTabView.h"

@interface ESShareScrollviewCell ()

@property (nonatomic, strong)ESShareTabView *defaultView;
@property (nonatomic, strong)ESShareTabView *hotCommentsView;
@property (nonatomic, strong)ESShareTabView *FocusView;


@end

@implementation ESShareScrollviewCell

 -(ESShareTabView *)defaultView
{
    if (_defaultView == nil) {
        _defaultView = [[ESShareTabView alloc]init];
        _defaultView.backgroundColor = [UIColor grayColor];
    }
    return _defaultView;
}
-(ESShareTabView *)hotCommentsView
{
    if (_hotCommentsView == nil) {
        _hotCommentsView = [[ESShareTabView alloc]init];
        _hotCommentsView.backgroundColor = [UIColor grayColor];
    }
    return _hotCommentsView;
}
-(ESShareTabView *)FocusView
{
    if (_FocusView == nil) {
        _FocusView = [[ESShareTabView alloc]init];
        _FocusView.backgroundColor = [UIColor grayColor];
    }
    return _FocusView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIScrollView *scrollview = [[UIScrollView alloc]init];
        scrollview.pagingEnabled  = YES;
        scrollview.contentSize = CGSizeMake(ScreenWidth * 3, 0);
        scrollview.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:scrollview];
        [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        [scrollview addSubview:self.defaultView];
        [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@0);
            make.height.equalTo(@(ScreenHeight- 64 -44-49));
            make.width.equalTo(@(ScreenWidth));
        }];
        [scrollview addSubview:self.hotCommentsView];
        [self.hotCommentsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(self.defaultView.mas_right);
            make.height.equalTo(@(ScreenHeight- 64 -44-49));
            make.width.equalTo(@(ScreenWidth));
        }];
        [scrollview addSubview:self.FocusView];
        [self.FocusView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.equalTo(self.hotCommentsView.mas_right);
            make.height.equalTo(@(ScreenHeight- 64 -44-49));
            make.width.equalTo(@(ScreenWidth));
        }];
    }
    return self;
}



@end

//
//  HomeTitleView.h
//  O2BookStore
//
//  Created by 卢双 on 13-9-6.
//  Copyright (c) 2013年 卢双. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeTitleViewDelegate <NSObject>

@optional
- (void)leftBtnPressed;

- (void)rightBtnPressed;

@end

@interface HomeTitleView : UIView


- (id)initWithTile:(NSString *)title withBackRuturn:(BOOL)isBack;
@property (nonatomic, assign) id<HomeTitleViewDelegate> delegate;
@property (nonatomic, strong)UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong)UIView *rightView;
@property (nonatomic, strong) UIView *leftView;

@end

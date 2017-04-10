//
//  ESHomeSearchView.h
//  EasyShop
//
//  Created by wcz on 16/3/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESHomeSearchViewDelegate <NSObject>

- (void)addHistoryKeyword:(NSString *)keyword;

- (void)textFieldDidChange:(NSString *)keyWord;

@end

@interface ESHomeSearchView : UIView

@property (nonatomic, assign) BOOL isAllowToPush;

@property (nonatomic, assign) id <ESHomeSearchViewDelegate> delegate;

@property(nullable,nonatomic,copy) NSString  *placeholder;
@property(nullable,nonatomic,strong) UIColor *placeholderColor;
@property(nullable,nonatomic,strong) UIColor *textColor;
@property(nullable,nonatomic,copy) NSString*text;
@property (nonatomic,assign) BOOL isEditing;
@end

//
//  ESFiltersView.h
//  EasyShop
//
//  Created by wcz on 16/6/7.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ESFiltersView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic,   copy) void (^callBack)(NSInteger);

@end

//
//  SearchTwoReusableView.h
//  EasyShop
//
//  Created by jiushou on 16/6/27.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTwoReusableView : UICollectionReusableView
@property (nonatomic, copy) void (^delectButtonBlock)();
@property (nonatomic, copy) NSString *title;
@property (nonatomic ,strong) UIButton*delectButton;
@end

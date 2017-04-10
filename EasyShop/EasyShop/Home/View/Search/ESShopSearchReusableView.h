//
//  ESShopSearchReusableView.h
//  EasyShop
//
//  Created by wcz on 16/6/9.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESShopSearchReusableView : UICollectionReusableView
@property (nonatomic, copy) void (^delectButtonBlock)();
@property (nonatomic, copy) NSString *title;
@property (nonatomic ,strong) UIButton*delectButton;
@end

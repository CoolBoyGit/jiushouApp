//
//  ESLoginFooterView.h
//  EasyShop
//
//  Created by 就手国际 on 17/1/14.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ESLoginFooterThreeViewDelegate <NSObject>

- (void)threeLoginAboutAction:(LoginType)type;

@end

@interface ESLoginFooterView : UIView
@property (nonatomic, assign) id<ESLoginFooterThreeViewDelegate>    delegate;
@property (nonatomic,copy) void (^loginBlock)();
@property (nonatomic,copy) void (^forgetBlock)();
@end

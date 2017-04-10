//
//  ESRefoundPickerView.h
//  EasyShop
//
//  Created by jiushou on 16/6/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESRefoundPickerView : UIView
- (void)showPickerView;
-(void) hidePickerView;
-(instancetype)initWithFrame:(CGRect)frame andRefoundViewIsRemoney:(BOOL)isComfromRefoundMoney;
@property (nonatomic,copy) void (^sussceBlock)(NSString*rowStr);
@end

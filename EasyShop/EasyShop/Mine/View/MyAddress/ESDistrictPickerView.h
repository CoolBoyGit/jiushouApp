//
//  ESDistrictPickerView.h
//  EasyShop
//
//  Created by guojian on 16/5/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESDistrictPickerView : UIView

- (void)showPickerView;
- (void)hidePickerView;
/** 确认block */
@property (nonatomic,copy) void (^sureBlock)(DistrictInfo *province,DistrictInfo *city,DistrictInfo *area);

@end
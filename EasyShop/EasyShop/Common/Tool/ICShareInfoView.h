//
//  ICShareInfoView.h
//  iCarePregnant
//
//  Created by wcz on 16/5/23.
//  Copyright © 2016年 oenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICShareInfoView : UIView

- (void)showPopView;

//@property (nonatomic, copy) void (^callBack)();

@property (nonatomic, copy) void (^selectShareButton)(NSInteger);
@property (nonatomic,copy) void(^tapHidenBLock)();
@end
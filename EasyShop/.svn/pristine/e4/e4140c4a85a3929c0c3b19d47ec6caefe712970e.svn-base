//
//  ICKeyBoardTopView.h
//  Picker
//
//  Created by wcz on 15/12/11.
//  Copyright © 2015年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ButtonType)
{
    ButtonTypeCancel = 1,
    ButtonTypeSure
};


@protocol ICKeyBoardTopViewDelegete <NSObject>

- (void)ICkeyBoardTopViewButtonBeClick:(ButtonType )type;

@end

@interface ICKeyBoardTopView : UIView

@property (nonatomic, weak) id <ICKeyBoardTopViewDelegete>delegate;

@end

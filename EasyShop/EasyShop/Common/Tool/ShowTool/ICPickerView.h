//
//  ICPickerView.h
//  iCarePregnant
//
//  Created by wcz on 15/12/16.
//  Copyright © 2015年 oenius. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ICPickerViewDelegate<NSObject>

- (void)ICPickerViewDidPickerInfoBeSure:(NSString *)info;
- (void)ICPickerViewDidPickerInfoBeCancel:(NSString *)info;

@end

@interface ICPickerView : UIView

@property (nonatomic, copy,readonly) NSString *pickInfo;
@property (nonatomic, weak) id <ICPickerViewDelegate >delegate;

@end

//
//  ESImagePickerController.h
//  EasyShop
//
//  Created by wcz on 16/5/15.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "JKImagePickerController.h"

@interface ESImagePickerController : JKImagePickerController

@property (nonatomic, copy)void (^callBack)(NSArray *array);

@end

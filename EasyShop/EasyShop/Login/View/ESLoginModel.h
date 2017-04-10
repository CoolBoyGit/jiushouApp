//
//  ESLoginModel.h
//  EasyShop
//
//  Created by 就手国际 on 17/1/13.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESLoginModel : NSObject
//@property (nonatomic,strong) UIImage*image;
@property (nonatomic,strong) NSString*imageStr;
@property (nonatomic,copy) NSString*mobile;

+(instancetype)modelWithImage:(UIImage*)image andPlaceholderStr:(NSString*)placeholderStr andText:(NSString*)text;
@end

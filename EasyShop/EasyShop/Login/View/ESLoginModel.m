//
//  ESLoginModel.m
//  EasyShop
//
//  Created by 就手国际 on 17/1/13.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import "ESLoginModel.h"

@implementation ESLoginModel
//-(void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:self.mobile forKey:@"mobile"];
//    [aCoder encodeObject:self.imageStr forKey:@"imageStr"];
//}
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self=[super init]) {
//        self.mobile=[aDecoder decodeObjectForKey:@"mobile"];
//        self.imageStr=[aDecoder decodeObjectForKey:@"imageStr"];
//    }
//    return self;
//}
+(instancetype)modelWithImage:(UIImage *)image andPlaceholderStr:(NSString *)placeholderStr andText:(NSString *)text{
    ESLoginModel*model=[[ESLoginModel alloc]init];
    
    model.mobile=text;
    return model;
}
@end

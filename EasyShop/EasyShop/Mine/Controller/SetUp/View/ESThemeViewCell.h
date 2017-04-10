//
//  ESThemeViewCell.h
//  EasyShop
//
//  Created by 就手国际 on 17/3/9.
//  Copyright © 2017年 ldz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESThemeViewCell : UITableViewCell
@property (nonatomic,strong) UIColor*color;
@property (nonatomic,strong) UILabel*rightLabel;
@property (nonatomic,strong) UILabel*colorLable;
@property (nonatomic,copy)   NSString*labelText;
@end

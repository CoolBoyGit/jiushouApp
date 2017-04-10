//
//  ESImageCollectionViewCell.h
//  EasyShop
//
//  Created by wcz on 16/3/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ESImageCollectionViewCell : UICollectionViewCell

/** 图片地址 */
@property (nonatomic,copy) NSString *imageUrl;
/*用来判断是不是首页的*/
@property (nonatomic,assign) BOOL isHome;
@end

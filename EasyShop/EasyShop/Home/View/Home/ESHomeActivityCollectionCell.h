//
//  ESHomeActivityCollectionCell.h
//  EasyShop
//
//  Created by 就手国际 on 16/12/21.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESHomeActivityCollectionCell : UICollectionViewCell
/** 活动专场商品信息 */
@property (nonatomic,strong) GoodsInfo *goodsInfo;
@property (nonatomic,assign) BOOL hiden;
@end

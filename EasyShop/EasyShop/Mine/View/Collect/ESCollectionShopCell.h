//
//  ESCollectionShopCell.h
//  EasyShop
//
//  Created by wcz on 16/4/20.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESCollectionShopCellDelegate <NSObject>

- (void)deleteCollectionAtGoods_id:(NSString *)goods_id;

@end

@interface ESCollectionShopCell : UICollectionViewCell

/** 收藏商品信息 */
@property (nonatomic,strong) FavoritesGoodsInfo *goodsInfo;
@property (nonatomic,assign) id <ESCollectionShopCellDelegate> delegate;

@end

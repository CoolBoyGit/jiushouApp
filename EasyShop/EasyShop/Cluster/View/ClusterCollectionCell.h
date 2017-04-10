//
//  ClusterCollectionCell.h
//  EasyShop
//
//  Created by 就手国际 on 16/10/28.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ClusterCollectionCell : UICollectionViewCell
@property (nonatomic,strong) GoodsInfo*goodsInfo;
@property (nonatomic,copy) void(^goButtonBlock)();
@property (nonatomic,assign) BOOL isHidden;
@end

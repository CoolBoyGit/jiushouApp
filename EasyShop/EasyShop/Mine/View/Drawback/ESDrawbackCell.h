//
//  ICDrawbackCell.h
//  EasyShop
//
//  Created by wcz on 16/4/23.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESDrawbackCell :  UICollectionViewCell

//@property (nonatomic, strong) id model;
/** 退货订单信息 */
@property (nonatomic,strong) OrderInfo *orderInfo;

@end
//
//  GoodEvaluationItem.m
//  EasyShop
//
//  Created by guojian on 16/7/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "GoodEvaluationItem.h"

@implementation GoodEvaluationItem
{
    CGFloat left,top,width,height;
    CGFloat margin;
}

+ (instancetype)itemWithInfo:(GoodsEvaluationInfo *)info
{
    GoodEvaluationItem *item = [[self alloc] init];
    item.evaluationInfo = info;
    return item;
}

- (void)setEvaluationInfo:(GoodsEvaluationInfo *)evaluationInfo
{
    _evaluationInfo = evaluationInfo;
    
    width = ScreenWidth;
    left = 15;
    top  = 6.5;
    CGFloat nameH = 20;
    CGFloat timeW = 120;
    CGFloat nameW = width - left*2 - timeW;
    _lineFrame=CGRectMake(15, 1, ScreenWidth-30, 0.5);
    //名字
    _nameFrame = CGRectMake(left, top, nameW, nameH);
    //时间
    left = CGRectGetMaxX(_nameFrame);
    _timeFrame = CGRectMake(left, top, timeW, nameH);
    //内容
    left = CGRectGetMinX(_nameFrame);
    top = CGRectGetMaxY(_nameFrame) + 2;
    CGFloat contentW = width - left*3;
    CGFloat contentH = [_evaluationInfo.content boundingRectWithSize:CGSizeMake(contentW, CGFLOAT_MAX)
                                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                          attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}
                                                             context:nil].size.height;
//    if (contentH < 30) {
//        contentH = 30;
//    }
    _contentFrame = CGRectMake(15, top, contentW, contentH);
    //图片高度 (最多4张)
    left = CGRectGetMinX(_contentFrame);
    top = CGRectGetMaxY(_contentFrame) + 5;
    CGFloat imageW = width - left*2;
    CGFloat imageH = 0;
    if (_evaluationInfo.image && _evaluationInfo.image.count > 0) {
        imageH = (imageW - 4*10)/4;
    }
    _imageFrame = CGRectMake(left, top, imageW, imageH);
    
    _cellHeight = CGRectGetMaxY(_imageFrame) + 5;
}

@end

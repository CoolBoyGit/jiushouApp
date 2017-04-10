//
//  ESSearchRecordCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/19.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESSearchRecordCell.h"

@interface ESSearchRecordCell()

@end

@implementation ESSearchRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self intalizedView];
    }
    return self;
}
-(void)intalizedView
{
    
}
-(void)setSubTitleArr:(NSArray *)subTitleArr
{
    _subTitleArr = subTitleArr;
    CGFloat minX = 15;
    for (int i = 0; i < subTitleArr.count; i++) {
        NSString *string = subTitleArr[i];
        CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:13]];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth-size.width-minX, 7, size.width+5, 30)];
        lab.font = ADeanFONT13;
        lab.text = string;
        lab.layer.cornerRadius = 5;
        lab.layer.masksToBounds = YES;
        lab.backgroundColor = [UIColor grayColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lab];
        minX = size.width+minX+10;
    }
}


@end

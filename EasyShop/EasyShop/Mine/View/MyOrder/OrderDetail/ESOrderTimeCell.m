//
//  ESOrderTimeCell.m
//  EasyShop
//
//  Created by 脉融LCJ on 16/5/12.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESOrderTimeCell.h"

@implementation ESOrderTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews
{
    NSArray *array = @[@"订单编号：31023982644629921",@"下单时间：2016-05-12 09：30：54"];
    for (int i = 0; i < array.count; i++) {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, 13+(13+13)*i, 200, 13)];
        lable.font = [UIFont systemFontOfSize:11];
        lable.text = array[i];
        [self.contentView addSubview:lable];
    }
}

@end

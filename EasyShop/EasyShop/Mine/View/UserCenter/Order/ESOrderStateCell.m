
//
//  HomePushCell.m
//  MFBank
//
//  Created by mairong on 15/12/19.
//  Copyright © 2015年 MFBank. All rights reserved.
//

#import "ESOrderStateCell.h"
#import "TIBTUIButton.h"
#import "ESRemindController.h"
#import "ICCollectShopController.h"
#import "ESMyOrderPageController.h"
#import "ESMyFootController.h"
#import "ESMyCLusterrPageCon.h"
@interface ESOrderStateCell()

@end
@implementation ESOrderStateCell
-(void)setItemArray:(NSMutableArray *)itemArray{
    _itemArray=itemArray;
    CGFloat w = ScreenWidth /(itemArray.count);
    for (int i=0; i<itemArray.count; i++) {
        UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(w*(i%5)+w-(w/2.0)+7, 9.5, 16, 16)];
        label.backgroundColor=[UIColor whiteColor];
        label.font=[UIFont systemFontOfSize:10];
        label.textColor=[UIColor whiteColor];
        label.layer.cornerRadius=8;
        label.layer.masksToBounds=YES;
        //        label.layer.borderColor=RGB(233, 40, 46).CGColor;
        label.backgroundColor=RGB(233, 40, 46);
        label.textAlignment=NSTextAlignmentCenter;
        
        //label.layer.borderWidth=0.9;
        
        
        if (_itemArray.count!=0) {
            NSString*cout=[_itemArray objectAtIndex:i];
            label.text=cout;
            int newCount=[ cout intValue];
            if (newCount==0 ) {
                
            }else{
                [self.contentView addSubview:label];
            }
            
        }
        if (kUserManager.isLogin) {
            
        }else{
            [label removeFromSuperview];
        }
        
    }
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
-(void)setImgArr:(NSArray *)imgArr
{
    _imgArr = imgArr;
    int count = (int)imgArr.count;
    CGFloat w = ScreenWidth / count;
    for (int i = 0; i < count; i++) {
        TIBTUIButton *btn = [[TIBTUIButton alloc]initWithFrame:CGRectMake(w*(i%5), 0, w, 70)];
        btn.tag = i;
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.cornerRadius = 5.0f;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.leftImg.contentMode = UIViewContentModeScaleToFill;
        if (kUserManager.isUseOtherImage) {
            NSFileManager*mangge=[NSFileManager defaultManager];
            NSString*newRoute=[kUserManager.themRootRoute stringByAppendingPathComponent:imgArr[i]];
            NSString*imagefile=[newRoute stringByAppendingPathComponent:@"@2x"];
            if ([mangge fileExistsAtPath:imagefile]==YES) {
                btn.leftImg.image=[UIImage imageWithContentsOfFile:newRoute];
                
                
            }else{
                NSString *image = imgArr[i];
                btn.leftImg.image = [UIImage imageNamed:image];
                
            }
            
        }else{
            NSString *image = imgArr[i];
            btn.leftImg.image = [UIImage imageNamed:image];
        }
        btn.rightLabel.text = self.titleArr[i] ;
        btn.rightLabel.textColor=RGB(40, 40, 40);
        [self.contentView addSubview:btn];
    }
}
- (void)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (self.tag == 0) {
        if (btn.tag == 0) {//我的收藏 0是收藏
            ESLoginVerify
            
            ESMyFootController*vc=[[ESMyFootController alloc]init];
            vc.flag=0;
            vc.hidesBottomBarWhenPushed = YES;
            
            [[AppDelegate shared]pushViewController:vc animated:YES];                   }
        if (btn.tag == 1){//心愿单 1是心愿单
            ESLoginVerify
            ESMyFootController*vc=[[ESMyFootController alloc]init];
            vc.flag=1;
            vc.hidesBottomBarWhenPushed = YES;
            
            [[AppDelegate shared]pushViewController:vc animated:YES];
            
        }
        if (btn.tag == 2) {//到货提醒 2是到货提醒
            ESLoginVerify
            ESMyFootController*vc=[[ESMyFootController alloc]init];
            vc.flag=2;
            vc.hidesBottomBarWhenPushed = YES;
            [[AppDelegate shared]pushViewController:vc animated:YES];
            
        }
        return;
    }
    if (self.tag==2) {
        ESLoginVerify
        ESMyCLusterrPageCon*vc=[[ESMyCLusterrPageCon alloc]init];
        vc.selectIndex=(int)btn.tag;
        vc.hidesBottomBarWhenPushed=YES;
        [[AppDelegate shared] pushViewController:vc animated:YES];
    }
    if (self.tag == 1) {
        ESLoginVerify
        ESMyOrderPageController *controller = [[ESMyOrderPageController alloc] init];
        controller.selectIndex = (int)btn.tag + 1;
        controller.hidesBottomBarWhenPushed = YES;
        [[AppDelegate shared] pushViewController:controller animated:YES];
    }
}
@end



//
//  ESPopController.m
//  EasyShop
//
//  Created by jiushou on 16/8/24.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESPopController.h"

@interface ESPopController ()

@end

@implementation ESPopController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
}
-(void)createPopVCWithRootVC:(ESHomeShopDetailController *)rootVC andPopView:(ICShareInfoView *)popView andGoods_id:(NSString *)goods_id{
    _rootVC = rootVC;
    _rootVC.goods_id=goods_id;
    _popView = popView;
    @weakify(self);
    
    _popView.tapHidenBLock=^(){
        @strongify(self);
        [self close];
    };
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    //显示详情的页面
    
  _rootVC.view.frame=kKeyWindow.bounds;
    _rootVC.view.backgroundColor = [UIColor colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000];
    _rootview = _rootVC.view;
    [self addChildViewController:_rootVC];
    [self.view addSubview:_rootview];
    
    //rootVC上的maskView
    _maskView = ({
        UIView * maskView = [[UIView alloc]initWithFrame:self.view.bounds];
        maskView.backgroundColor = [UIColor colorWithRed:0.502 green:0.000 blue:0.000 alpha:1.000];
        maskView.alpha = 0;
        maskView;
    });
    [_rootview addSubview:_maskView];
}

- (void)close
{
    CGRect frame = _popView.frame;
    frame.origin.y= _popView.frame.size.height;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //maskView隐藏
        [_maskView setAlpha:0.f];
        //popView下降
        _popView.frame = frame;
        
        //同时进行 感觉更丝滑
        [_rootview.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //变为初始值
            [_rootview.layer setTransform:CATransform3DIdentity];
            
        } completion:^(BOOL finished) {
            
            //移除
            [_popView removeFromSuperview];
        }];
        
    }];
    
    
    
}

- (void)show
{
    [[UIApplication sharedApplication].windows[0] addSubview:_popView];
    
    CGRect frame = _popView.frame;
    frame.origin.y =0;
    //self.view.bounds.size.height;
//    - _popView.frame.size.height+64;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [_rootview.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [_rootview.layer setTransform:[self secondTransform]];
            //显示maskView
            //[_maskView setAlpha:0.5f];
            //popView上升
            _popView.frame = frame;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
}

- (CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    
    t1.m34 = 1.0/-900;
    //带点缩小的效果
    //t1=CATransform3DMakeScale(0.95, 0.95, 0.95);
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/90.0, 1, 0, 0);
    return t1;
    
}

- (CATransform3D)secondTransform{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    //向上移
    t2 = CATransform3DTranslate(t2, 0, self.view.frame.size.height * (-0.08), 0);
    //第二次缩小
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    return t2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

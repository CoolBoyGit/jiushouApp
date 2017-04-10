//
//  WarningControlView.m
//  
//
//  Created by jiushou on 16/8/1.
//
//
#import <UIKit/UIKit.h>

#import "WarningControlView.h"
@interface WarningControlView()<UIAlertViewDelegate> 
@end
@implementation WarningControlView
-(instancetype)initShowTitle:(NSString *)title  andMessage:(NSString*)message {
    if (self==[super init]) {
       
            UIAlertController*com=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*cancelActio=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                self.cancelBlock();
            }];
            UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                self.sucessBlock();
            }];
            [com addAction:cancelActio];
            [com addAction:okAction];
            [[AppDelegate shared] presentViewController:com animated:YES completion:^{
                
            }];
        

    }
    return self;
}

@end

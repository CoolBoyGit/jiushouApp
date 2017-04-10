
//
//  ESImagePickerController.m
//  EasyShop
//
//  Created by wcz on 16/5/15.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESImagePickerController.h"
#import "ESPhotoBrowserController.h"

@interface ESImagePickerController ()

@end

@implementation ESImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.maximumNumberOfSelection = 10;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)browerPhotoes:(NSArray *)array page:(NSInteger)page
{
    ESPhotoBrowserController *controller = [[ESPhotoBrowserController alloc] init];
    controller.callBack = self.callBack;
//    controller.dataArray = array;
    [self.navigationController pushViewController:controller animated:NO];
}


@end

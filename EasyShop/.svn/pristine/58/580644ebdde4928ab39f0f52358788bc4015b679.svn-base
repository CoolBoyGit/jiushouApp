//
//  CreateCommentViewController.m
//  MFBank
//
//  Created by lyywhg on 15/12/5.
//  Copyright (c) 2015年 MFBank. All rights reserved.
//

#import "CreateCommentViewController.h"
#import "CreateCommentCell.h"
#import "ImageViewScrollView.h"
#import "JKImagePickerController.h"
#import "JKAssets.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+Extend.h"

#import "ESImagePickerController.h"

@interface CreateCommentViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,JKImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *gList;
@property (nonatomic, strong) NSMutableArray *gList1;
@property (nonatomic, assign) int    selectIndex;//是否商品相关

@end

@implementation CreateCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"牛爷爷";
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
//    [self initalizedCumstomNav];
    [self.view addSubview:self.tableView];
//    [self initalizedCumstomNav];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.bottom.equalTo(@-30);
    }];
}

-(void)setImageArray:(NSArray *)imageArray
{
    if (_selectIndex == 2) {//商品相关
        for (ALAsset *asset in imageArray) {
            UIImage *image  =   [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
            [self.gList1 addObject:image];
        }
    } else {
        for (ALAsset *asset in imageArray) {
            if ([asset isKindOfClass:[ALAsset class]]) {
                UIImage *image  =   [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                [self.gList addObject:image];
            } else if ([asset isKindOfClass:[UIImage class]]) {
                [self.gList addObject:asset];
            }
        }
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void)cAddPhotoActionWithCellIndex:(NSInteger)cellIndex {
    
    self.selectIndex = 1;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        UIActionSheet *actionSheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:(id<UIActionSheetDelegate>)self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", @"拍照上传", nil, nil];
        [actionSheet showInView:self.view];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *other1Action = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self photoLibraryAction];
        }];
        UIAlertAction *other2Action = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self cameraAction];
        }];
        [alertController addAction:other1Action];
        [alertController addAction:other2Action];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)cDeleteTouchAction:(NSInteger)btnIndex cellIndex:(NSInteger)cellIndex {
    
}

#pragma mark
#pragma mark Other Delegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 300;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *ShopCommentCellIdentifier = @"ShopCommentCellIdentifier";
        CreateCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopCommentCellIdentifier];
        if (cell == nil) {
            cell = [[CreateCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ShopCommentCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.gList.count > 0) {
            [cell updateViewInfoWithInfo:self.gList index:indexPath.section];
        } else
            [cell updateViewInfoWithInfo:nil index:indexPath.section];
        
        cell.commentTextView.tag = indexPath.section;
        cell.commentTextView.delegate = (id<UITextViewDelegate>)self;
        cell.delegate = (id<CreateCommentDelegate>)self;
        return cell;
    }
    static NSString *AboutShopCellIdentifier = @"AboutShopCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AboutShopCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AboutShopCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 15)];
    titleLab.text = @"  商品相关";
    titleLab.font = [UIFont systemFontOfSize:13];
    [cell.contentView addSubview:titleLab];
    
    ImageViewScrollView *imageScrollView  = [[ImageViewScrollView alloc] initWithFrame:CGRectMake(10, 35, ScreenWidth-20, 65)];
    imageScrollView.backgroundColor = [UIColor clearColor];
    imageScrollView.iDelegate = (id<ImageViewScrollViewDelegate>)self;
    
    if ( self.gList1.count == 0) {
        [imageScrollView updateViewInfoWithInfo:nil type:1];
    } else {
        [imageScrollView updateViewInfoWithInfo:self.gList1 type:1];
    }
    
    [cell.contentView addSubview:imageScrollView];
    return cell;
}


#pragma mark
#pragma mark Init & Add
- (NSMutableArray *)gList {
    if (!_gList) {
        _gList = [[NSMutableArray alloc] init];
    }
    return _gList;
}
- (NSMutableArray *)gList1 {
    if (!_gList1) {
        _gList1 = [[NSMutableArray alloc] init];
    }
    return _gList1;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

-(void)rightAction
{
   

}
-(void)leftAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)cameraAction {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = (id <UINavigationControllerDelegate, UIImagePickerControllerDelegate>)self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)addPhotoAction
{
    self.selectIndex = 2;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        UIActionSheet *actionSheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:(id<UIActionSheetDelegate>)self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", @"拍照上传", nil, nil];
        [actionSheet showInView:self.view];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        UIAlertAction *other1Action = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self photoLibraryAction];
        }];
        UIAlertAction *other2Action = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self cameraAction];
        }];
        [alertController addAction:other1Action];
        [alertController addAction:other2Action];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)photoLibraryAction {
    
    ESImagePickerController *controller = [[ESImagePickerController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [controller setCallBack:^(NSArray *array) {
        
        //        CreateCommentViewController *controller = [[CreateCommentViewController alloc] init];
        //        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        self.imageArray =array;
        //        [self presentViewController:navController animated:YES completion:^{
        //        }];
    }];
    [self presentViewController:nav animated:NO completion:^{
    }];
    
    //    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    //    imagePickerController.delegate = self;
    //    imagePickerController.showsCancelButton = YES;
    //    imagePickerController.allowsMultipleSelection = YES;
    //    imagePickerController.minimumNumberOfSelection = 1;
    //    imagePickerController.maximumNumberOfSelection = 9;
    //    //    imagePickerController.selectedAssetArray = self.assetsArray;
    //    [self.navigationController pushViewController:imagePickerController animated:YES];
}



@end

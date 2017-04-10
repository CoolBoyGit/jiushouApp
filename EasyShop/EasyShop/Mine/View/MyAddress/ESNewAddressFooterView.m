//
//  ESNewAddressFooterView.m
//  EasyShop
//
//  Created by 就手国际 on 16/12/27.
//  Copyright © 2016年 ldz. All rights reserved.
//

#import "ESNewAddressFooterView.h"
#import <UIActionSheet+BlocksKit.h>
#import "JKImagePickerController.h"
#import "PersonImageModel.h"
#import "JKAssets.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+Extend.h"
#import "JKAssets.h"
#import <ImageIO/ImageIO.h>
#import "DZPhotoBrowser.h"
@interface ESNewAddressFooterView()
<UIImagePickerControllerDelegate,JKImagePickerControllerDelegate,UINavigationControllerDelegate,DZPhotoBrowserDelegate>
@property(nonatomic,strong) UILabel*tipsLabel;
@property (nonatomic,strong) UILabel*titleLabel;
@property (nonatomic,strong) UILabel*attentionLabel;

@property (nonatomic,strong) UILabel*leftLable;
@property (nonatomic,strong) UILabel*rightLable;
@property (nonatomic,strong) UILabel*reasonLabel;
@property (nonatomic,strong) UIView*bgView;
//@property (nonatomic,strong) UICollectionView*imageCollectView;
@property (nonatomic,strong) UIImageView*frontTipsImageView;//正面+
@property (nonatomic,strong) UIImageView*backTipsImageView;//反面+
@property (nonatomic,strong) UIImageView*personid_frontImageView;//正面身份证
@property (nonatomic,strong) UIImageView*personid_backImageView;//反面身份证
@property (nonatomic,strong) UIImageView*personid_frontTipsImageView;//正面身份证提示
@property (nonatomic,strong) UIImageView*personid_backTipsImageView;//反面身份证提示
@property (nonatomic,strong) UIImagePickerController*imagePicker;
@property (nonatomic,strong) UIImagePickerController*imagePickerBack;
@property (nonatomic,strong) JKImagePickerController*imagePickerControllerFront;
@property (nonatomic,strong) JKImagePickerController*imagePickerControllerBack;

@property (nonatomic,strong) DZPhotoBrowser*photoBorwser;
@property (nonatomic,strong) NSMutableArray*frontArray;
@property (nonatomic,strong) NSMutableArray*backArrray;

@property (nonatomic,strong) UIButton*delectFrontButton;
@property (nonatomic,strong) UIButton*delectBackButton;

@end
@implementation ESNewAddressFooterView
-(UIButton *)delectBackButton{
    if (_delectBackButton==nil) {
        _delectBackButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _delectBackButton.layer.cornerRadius=10;
        _delectBackButton.layer.masksToBounds=YES;
        [_delectBackButton setTitle:@"x" forState:UIControlStateNormal];
        [_delectBackButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _delectBackButton.hidden=YES;
        _delectBackButton.backgroundColor=RGB(233, 40, 46);
        
        [_delectBackButton addTarget:self action:@selector(delectBackButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delectBackButton;
}
-(void)delectBackButtonAction{
    self.personid_backImageView.hidden=YES;
    self.delectBackButton.hidden=YES;
}
-(UIButton *)delectFrontButton{
    if (_delectFrontButton==nil) {
        _delectFrontButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _delectFrontButton.layer.cornerRadius=10;
        _delectFrontButton.hidden=YES;
        _delectFrontButton.layer.masksToBounds=YES;
        [_delectFrontButton setTitle:@"x" forState:UIControlStateNormal];
        [_delectFrontButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _delectFrontButton.backgroundColor=RGB(233, 40, 46);
        _delectFrontButton.titleLabel.textColor=[UIColor whiteColor];
        [_delectFrontButton addTarget:self action:@selector(delectFrontButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delectFrontButton;
}
-(void)delectFrontButtonAction{
    self.personid_frontImageView.hidden=YES;
    self.delectFrontButton.hidden=YES;
}
-(NSMutableArray *)frontArray{
    if (_frontArray==nil) {
        _frontArray=[[NSMutableArray alloc]init];
    }
    return _frontArray;
}
-(NSMutableArray *)backArrray{
    if (_backArrray==nil) {
        _backArrray=[[NSMutableArray alloc]init];
    }
    return _backArrray;
}
-(void)setBackModel:(PersonImageModel *)backModel{
    self.personid_backImageView.hidden=NO;
    self.delectBackButton.hidden=NO;
    self.personid_backImageView.image=backModel.image;
    [self.backArrray addObject:backModel.image];
    _backModel=backModel;
    
    
}
-(void)setFrontModel:(PersonImageModel *)frontModel{
    _frontModel=frontModel;
    [self.frontArray addObject:frontModel.image];
    self.delectFrontButton.hidden=NO;
    self.personid_frontImageView.hidden=NO;
    self.personid_frontImageView.image=frontModel.image;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=RGB(236, 236, 236);
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.top.equalTo(@0);
            make.height.equalTo(@40);
        }];
        [self addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
            make.height.equalTo(@(200+((ScreenWidth-40)/2.0*(212/335.0))));
        }];
        [self addSubview:self.tipsLabel];
        [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
//            make.height.equalTo(@60);
        }];
        [self addSubview:self.frontTipsImageView];
        [self.frontTipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(15);
            make.left.equalTo(@10);
            make.width.equalTo(@((ScreenWidth-40)/2.0));
            make.height.equalTo(@((ScreenWidth-40)/2.0*(212/335.0)));
        }];
        [self addSubview:self.personid_frontImageView];
        [self.personid_frontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(15);
            make.left.equalTo(@10);
            make.width.equalTo(@((ScreenWidth-40)/2.0));
            make.height.equalTo(@((ScreenWidth-40)/2.0*(212/335.0)));

        }];
        [self addSubview:self.delectFrontButton];
        [self.delectFrontButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(5);
            make.left.equalTo(self.frontTipsImageView.mas_right).offset(-10);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        [self addSubview:self.backTipsImageView];
        [self.backTipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(15);
            make.left.equalTo(self.frontTipsImageView.mas_right).offset(20);
            make.width.equalTo(@((ScreenWidth-40)/2.0));
            make.height.equalTo(@((ScreenWidth-40)/2.0*(212/335.0)));

        }];
        [self addSubview:self.personid_backImageView];
        [self.personid_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(15);
            make.left.equalTo(self.frontTipsImageView.mas_right).offset(20);
            make.width.equalTo(@((ScreenWidth-40)/2.0));
            make.height.equalTo(@((ScreenWidth-40)/2.0*(212/335.0)));
        }];
        [self addSubview:self.delectBackButton];
        [self.delectBackButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tipsLabel.mas_bottom).offset(5);
            make.left.equalTo(self.backTipsImageView.mas_right).offset(-10);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        [self addSubview:self.leftLable];
        [self.leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.frontTipsImageView.mas_bottom).offset(10);
            make.centerX.equalTo(self.frontTipsImageView.mas_centerX);
            make.height.equalTo(@30);
            
        }];
        [self addSubview:self.rightLable];
        [self.rightLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backTipsImageView.mas_bottom).offset(10);
            make.centerX.equalTo(self.backTipsImageView.mas_centerX);
            make.height.equalTo(@30);
        }];
        [self addSubview:self.personid_frontTipsImageView];
        [self.personid_frontTipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftLable.mas_bottom).offset(10);
            make.centerX.equalTo(self.frontTipsImageView.mas_centerX);
            make.width.equalTo(@80);
            make.height.equalTo(@52.8);
        }];
        [self addSubview:self.personid_backTipsImageView];
        [self.personid_backTipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightLable.mas_bottom).offset(10);
            make.centerX.equalTo(self.backTipsImageView.mas_centerX);
            make.width.equalTo(@80);
            make.height.equalTo(@52.8);
        }];
        [self addSubview:self.reasonLabel];
        [self.reasonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.left.right.equalTo(@0);
            make.top.equalTo(self.bgView.mas_bottom).offset(8);
            
        }];
        [self addSubview:self.attentionLabel];
        [self.attentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.equalTo(@-10);
            make.top.equalTo(self.reasonLabel.mas_bottom).offset(0);
        }];
        
    }
    return self;
}
-(UILabel *)reasonLabel{
    if (_reasonLabel==nil) {
        _reasonLabel=[[UILabel alloc]init];
        _reasonLabel.text=@"为什么需要实名认证";
        _reasonLabel.textAlignment=NSTextAlignmentCenter;
        _reasonLabel.backgroundColor=RGB(236, 236, 236);
        _reasonLabel.textColor=RGB(43, 43, 43);
        
    }
    return _reasonLabel;
}
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView=[[UIView alloc]init];
        _bgView.backgroundColor=[UIColor whiteColor];
        
    }
    return _bgView;
}
-(UILabel *)leftLable{
    if (_leftLable==nil) {
        _leftLable=[[UILabel alloc]init];
        _leftLable.textAlignment=NSTextAlignmentCenter;
        _leftLable.text=@"示例";
        _leftLable.textColor=RGB(168, 168, 168);
    }
    return _leftLable;
}
-(UILabel *)rightLable{
    if (_rightLable==nil) {
        _rightLable=[[UILabel alloc]init];
        _rightLable.textAlignment=NSTextAlignmentCenter;
        _rightLable.text=@"示例";
        _rightLable.textColor=RGB(168, 168, 168);
    }
    return _rightLable;
}
-(UILabel *)titleLabel{
    if (_titleLabel==nil) {
        _titleLabel=[[UILabel alloc]init];
        NSString*str=@"身份证正反面照片 (选填)";
        _titleLabel.backgroundColor=RGB(235, 235, 235);
        _titleLabel.textColor=RGB(70, 70, 70);
        NSMutableAttributedString*mustr=[[NSMutableAttributedString alloc]initWithString:str];
        [mustr addAttribute:NSForegroundColorAttributeName value:RGB(139, 139, 139) range:NSMakeRange(str.length-4, 4)];
        _titleLabel.attributedText=mustr;
        
        
    }
    return _titleLabel;
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        NSString*str=@"温馨提示: 请上传原始比例的身份证正反面照片,请不要裁剪修改,保证身份信息显示清晰,否则无法通过海关审刻,以免给您带来不便";
        _tipsLabel.numberOfLines=0;
        _tipsLabel.font=[UIFont systemFontOfSize:14];
        NSTextAttachment*ach=[[NSTextAttachment alloc]init];
        ach.image=[UIImage imageNamed:@"mine_address_plaint"];
        ach.bounds=CGRectMake(0, -3, 17, 17);
        NSAttributedString*aStr=[NSAttributedString attributedStringWithAttachment:ach];
        NSMutableAttributedString*muStr=[[NSMutableAttributedString alloc]initWithString:str];
        [muStr insertAttributedString:aStr atIndex:0];
        _tipsLabel.textColor=RGB(148, 148, 148);
        _tipsLabel.attributedText=muStr;
        
    }
    return _tipsLabel;
}
-(UILabel *)attentionLabel{
    if (_attentionLabel==nil) {
        _attentionLabel=[[UILabel alloc]init];
        _attentionLabel.numberOfLines=0;
        _attentionLabel.text=@".根据海关规定,购买跨境商品需要办理清关手续,请您配合进行实名认证,以确保您购买的商品顺利通过海关检查.(就手国际承诺您所上传的身份正品只用于办理跨境商品的清关手续,不作其他使用,其他人无法查看)\n.实名认证的规则:购买跨境商品需要填写收货人的真实姓名以及身份证号码,部分商品需要提供收货人的实名信息(包括身份证照片),具体以下单时候的提示为准";
        _attentionLabel.textColor=RGB(142, 142, 142);
        
    }
    return _attentionLabel;
}
- (UIImagePickerController *)imagePicker
{
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        //        _imagePicker.allowsEditing = YES;
    }
    return _imagePicker;
}
-(UIImagePickerController *)imagePickerBack{
    if (_imagePickerBack==nil) {
        _imagePickerBack=[[UIImagePickerController alloc]init];
        _imagePickerBack.delegate=self;
    }
    return _imagePickerBack;
}

-(UIImageView *)frontTipsImageView{
    if (_frontTipsImageView==nil) {
        _frontTipsImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_newaddress_fronttips"]];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(frontTipsImageViewAction)];
        _frontTipsImageView.userInteractionEnabled=YES;
        [_frontTipsImageView addGestureRecognizer:tap];
        
    }
    return _frontTipsImageView;
}

-(void)frontTipsImageViewAction{
    UIActionSheet *sheet = [[UIActionSheet alloc] init];
    @weakify(self);
    [sheet bk_addButtonWithTitle:@"拍照" handler:^{
        @strongify(self);
        self.imagePicker.sourceType= UIImagePickerControllerSourceTypeCamera;
        [[AppDelegate shared]presentViewController:self.imagePicker animated:YES completion:^{
            
        }];
        
    }];
    [sheet bk_addButtonWithTitle:@"从手机相册选择" handler:^{
        @strongify(self);
        [self photoLibraryAction];
    }];
    [sheet bk_setCancelButtonWithTitle:@"取消" handler:nil];
    [sheet showInView:kKeyWindow];
}
- (void)photoLibraryAction {
    JKImagePickerController *imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = 1;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [[AppDelegate shared] presentViewController:navigationController animated:YES completion:nil];
}
//原生相机的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
    UIImage*newImage= [self imageCompressForWidth:image targetWidth:ScreenWidth*1.5];

    if (picker==self.imagePicker) {
        PersonImageModel*model=[[PersonImageModel alloc]init];
        model.flag=1;
        model.image=newImage;
        if (self.frontBlock) {
            self.frontBlock(model);
        }
    }else{
        PersonImageModel*model=[[PersonImageModel alloc]init];
        model.flag=2;
        model.image=newImage;
        
        if (self.frontBlock) {
            self.frontBlock(model);
            
        }
        
    }
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    

}

#pragma mark - JKImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//代理方法
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
        
    }];
    if (imagePicker==self.imagePickerControllerBack) {
        for (int i = 0; i < assets.count; i++) {
            JKAssets *jka = assets[i];
            ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
            [lib extend_assetForURL:jka.assetPropertyURL resultBlock:^(ALAsset *asset) {
                if (asset) {
                    CGImageRef ref = [[asset  defaultRepresentation]fullScreenImage];
                    PersonImageModel*model=[[PersonImageModel alloc]init];
                    model.flag=2;
                    UIImage *image = [[UIImage alloc]initWithCGImage:ref];
                     model.image= [self imageCompressForWidth:image targetWidth:ScreenWidth*1.5];
                    model.image=image;
                    if (self.frontBlock) {
                        self.frontBlock(model);
                    }
                    
                }
                
            } failureBlock:^(NSError *error) {
                
            }];
            
        }

        
    }else{
        
        for (int i = 0; i < assets.count; i++) {
            JKAssets *jka = assets[i];
            ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
            [lib extend_assetForURL:jka.assetPropertyURL resultBlock:^(ALAsset *asset) {
                if (asset) {
                    CGImageRef ref = [[asset  defaultRepresentation]fullScreenImage];
                    PersonImageModel*model=[[PersonImageModel alloc]init];
                    model.flag=1;
                    UIImage *image = [[UIImage alloc]initWithCGImage:ref];
                   model.image= [self imageCompressForWidth:image targetWidth:ScreenWidth*1.5];
                    
                    if (self.frontBlock) {
                        self.frontBlock(model);
                    }
                    
                }
                
            } failureBlock:^(NSError *error) {
                
            }];
            
        }

        
    }
    
}

-(UIImageView *)backTipsImageView{
    if (_backTipsImageView==nil) {
        _backTipsImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_newaddress_backtips"]];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backTipsImageViewAction)];
        _backTipsImageView.userInteractionEnabled=YES;
        [_backTipsImageView addGestureRecognizer:tap];
    }
    return _backTipsImageView;
}
-(void)backTipsImageViewAction{
    UIActionSheet *sheet = [[UIActionSheet alloc] init];
    @weakify(self);
    [sheet bk_addButtonWithTitle:@"拍照" handler:^{
        @strongify(self);
        
        self.imagePickerBack .sourceType= UIImagePickerControllerSourceTypeCamera;
        
        [[AppDelegate shared]presentViewController:self.imagePickerBack animated:YES completion:^{
            
        }];
        
    }];
    [sheet bk_addButtonWithTitle:@"从手机相册选择" handler:^{
        @strongify(self);
        [self photoLibraryActionback];
    }];
    [sheet bk_setCancelButtonWithTitle:@"取消" handler:nil];
    [sheet showInView:kKeyWindow];
}- (void)photoLibraryActionback {
    self.imagePickerControllerBack = [[JKImagePickerController alloc] init];
    self.imagePickerControllerBack.delegate = self;
    self.imagePickerControllerBack.showsCancelButton = YES;
    self.imagePickerControllerBack.allowsMultipleSelection = YES;
    self.imagePickerControllerBack.minimumNumberOfSelection = 1;
    self.imagePickerControllerBack.maximumNumberOfSelection = 1;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.imagePickerControllerBack];
    [[AppDelegate shared] presentViewController:navigationController animated:YES completion:nil];
}
-(UIImageView*)personid_frontImageView{
    if (_personid_frontImageView==nil) {
        _personid_frontImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _personid_frontImageView.hidden=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personid_frontImageViewAction)];
        _personid_frontImageView.userInteractionEnabled=YES;
        [_personid_frontImageView addGestureRecognizer:tap];
    }
    return _personid_frontImageView;
}
-(void)personid_frontImageViewAction{
    
    [self showDZPhotoBrowser:0 andImageArray:self.frontArray];
    
    
    
}
-(UIImageView *)personid_backImageView{
    if (_personid_backImageView==nil) {
        _personid_backImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        _personid_backImageView.hidden=YES;
        _personid_backImageView.userInteractionEnabled=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(personid_backImageViewAction)];
        [_personid_backImageView addGestureRecognizer:tap];
    }
    return _personid_backImageView;
}
-(void)personid_backImageViewAction{
    
    [self showDZPhotoBrowser:0 andImageArray:self.backArrray];
    
    
    
}
-(void)showDZPhotoBrowser:(NSInteger)index andImageArray:(NSMutableArray*)imageArray{
    self.photoBorwser = [[DZPhotoBrowser alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.photoBorwser.delegate = self;
    self.photoBorwser.currentPage = index;
//    self.photoBrowserArray =[self.commentImageArray mutableCopy];
//    [self.photoBrowserArray removeLastObject];
    self.photoBorwser.imageArray=imageArray;
    self.photoBorwser.isShowDeleButton=NO;
    [self.photoBorwser show:YES];
    
}

-(UIImageView *)personid_frontTipsImageView{
    if (_personid_frontTipsImageView==nil) {
        _personid_frontTipsImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_newaddress_frontperson"]];
        
        
    }
    return _personid_frontTipsImageView;
}
-(UIImageView *)personid_backTipsImageView{
    if (_personid_backTipsImageView==nil) {
        _personid_backTipsImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_newaddress_backperson"]];
        
    }
    return _personid_backTipsImageView;
}
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *dataOf02 =UIImageJPEGRepresentation(newImage, 0.4);
    UIImage*image=[UIImage imageWithData:dataOf02];
    //UIImageJPEGRepresentation函数需要两个参数:图片的引用和压缩系数.而UIImagePNGRepresentation只需要图片引用作为参数.通过在实际使用过程中,比较发现: UIImagePNGRepresentation(UIImage* image) 要比UIImageJPEGRepresentation(UIImage* image, 1.0) 返回的图片数据量大很多.
    return image;
}

//-(UICollectionView *)imageCollectView{
//    if (_imageCollectView==nil) {
//        UICollectionViewFlowLayout*flow=[[UICollectionViewFlowLayout alloc]init];
//        flow.scrollDirection=UICollectionViewScrollDirectionVertical;
//        _imageCollectView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flow];
//        _imageCollectView.delegate=self;
//        _imageCollectView.dataSource=self;
//        _imageCollectView.scrollEnabled=NO;
//        _imageCollectView.showsVerticalScrollIndicator=NO;
//    }
//    return _imageCollectView;
//}
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return nil;
//}
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 2;
//}
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 1;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake((ScreenWidth-3)/2.0,(ScreenWidth-3)/2.0+65) ;
//}
////设置列间距
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 3;
//}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}












@end

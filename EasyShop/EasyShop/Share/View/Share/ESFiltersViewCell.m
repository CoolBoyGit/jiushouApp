//
//  ESFiltersViewCell.m
//  EasyShop
//
//  Created by wcz on 16/6/7.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ESFiltersViewCell.h"

@interface ESFiltersViewCell ()

@property (nonatomic, strong) UIImageView *photosView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation ESFiltersViewCell

- (UIImageView *)photosView
{
    if (_photosView == nil) {
        _photosView = [[UIImageView alloc] init];
    }
    return _photosView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"卡其色";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:9];
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.photosView];
        [self.photosView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
        }];
        
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.bottom.equalTo(@(-5));
        }];
    }
    return self;
}

- (void)setImageView:(UIImage *)imageView
{
    _imageView = imageView;
    self.photosView.image = imageView;
}

- (void)setFilterName:(NSString *)filterName
{
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//    if ([filterName isEqualToString:@"Origin"]) {
//        self.photosView.image = self.imageView;
//    }else{
//        CIImage *ciImage = [[CIImage alloc] initWithImage:self.photosView.image];
//        CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
//        [filter setDefaults];
//        CIContext *context = [CIContext contextWithOptions:nil];
//        CIImage *outputImage = [filter outputImage];
//        CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
//        UIImage *image = [UIImage imageWithCGImage:cgImage];
//        CGImageRelease(cgImage);
//        self.photosView.image = image;
////        [self.dataArray replaceObjectAtIndex:self.selectIndex withObject:image];
//    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if ([filterName isEqualToString:@"Origin"]) {
            self.photosView.image = self.imageView;
        }else{
            CIImage *ciImage = [[CIImage alloc] initWithImage:self.photosView.image];
            CIFilter *filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey, ciImage, nil];
            [filter setDefaults];
            CIContext *context = [CIContext contextWithOptions:nil];
            CIImage *outputImage = [filter outputImage];
            CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
            UIImage *image = [UIImage imageWithCGImage:cgImage];
//            CGImageRelease(cgImage);
            self.photosView.image = image;
            //        [self.dataArray replaceObjectAtIndex:self.selectIndex withObject:image];
        }
    });
    
//}

}




@end

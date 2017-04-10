//
//  DZPhotoBrowserColleCell.m
//  EasyShop
//
//  Created by 就手国际 on 16/12/5.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "DZPhotoBrowserColleCell.h"
#import "UIView+JKPicker.h"
@interface DZPhotoBrowserColleCell() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) UIImageView   *imageView;

@end

@implementation DZPhotoBrowserColleCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self scrollView];
        [self imageView];
        self.autoresizesSubviews = YES;
    }
    
    return self;
}

- (void)prepareForReuse{
    [super prepareForReuse];
    
    [self.scrollView setZoomScale:1.0];
    
}
- (void)setAsset:(ALAsset *)asset{
    if (_asset != asset) {
        _asset = asset;
        
        self.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
    }
}

#pragma mark- setter
- (void)setImage:(UIImage *)image{

        _image = image;
        
//        CGSize maxSize = self.scrollView.size;
//        CGFloat widthRatio = maxSize.width/image.size.width;
//    
//        CGFloat heightRatio = maxSize.height/image.size.height;
//        CGFloat initialZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
//        
//        if (initialZoom > 1) {
//            initialZoom = 1;
//        }
    
        CGRect r = self.scrollView.frame;
        r.size.width = ScreenWidth;
        r.size.height =  ScreenWidth * ((image.size.height)/(image.size.width));
        self.imageView.frame = r;
        self.imageView.center = CGPointMake(self.scrollView.width/2, self.scrollView.height/2);
        self.imageView.image = image;
        //设置放大 和缩小的倍数
        [self.scrollView setMinimumZoomScale:1];
        [self.scrollView setMaximumZoomScale:5];
    
        [self.scrollView setZoomScale:1.0];
    
}

#pragma mark- scroll
//实现这两个函数就可以实现放在scrollView上的控件的缩放和放大.
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    
    self.imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                        scrollView.contentSize.height * 0.5 + offsetY);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark- getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-20, self.frame.size.height)];
        _scrollView.delegate = self;
//        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.showsVerticalScrollIndicator = YES;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth;
        [self.scrollView addSubview:_imageView];
    }
    
    return _imageView;
}


@end

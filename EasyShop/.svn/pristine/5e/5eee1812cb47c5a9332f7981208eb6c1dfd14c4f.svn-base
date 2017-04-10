//
//  CreateCommentCell.m
//  MFBank
//
//  Created by lyywhg on 15/12/5.
//  Copyright (c) 2015年 MFBank. All rights reserved.
//

#import "PostCommentCell.h"
#import "ImageViewScrollView.h"
#import "LIRTUIButton.h"

@interface PostCommentCell ()<ImageViewScrollViewDelegate>

@property (nonatomic, strong) UIImageView *shopImageView;
@property (nonatomic, strong) UILabel *line1Label;
@property (nonatomic, strong) ImageViewScrollView *imageScrollView;

@property (nonatomic, assign) NSInteger cellIndex;

@property (nonatomic, strong) NSDictionary *cellInfoDict;

@end

@implementation PostCommentCell

- (void)setImageItems:(NSArray *)imageItems
{
    _imageItems = imageItems;
    
    if ([_imageItems count] == 0 ) {
        [self.imageScrollView updateViewInfoWithInfo:nil type:1];
    } else {
        [self.imageScrollView updateViewInfoWithInfo:_imageItems type:1];
    }}

- (void)updateViewInfoWithInfo:(NSDictionary *)dict index:(NSInteger)index {
    self.cellInfoDict = dict;
    self.userInteractionEnabled = YES;
    self.shopImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:dict[@"goodsImgUrl"]] placeholderImage:[UIImage imageNamed:@"page3"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error == nil) {
            self.shopImageView.contentMode = UIViewContentModeScaleAspectFit;
        }
    }];

    self.line1Label.alpha = 1.0f;
    self.commentTextView.alpha = 1.0f;
    self.commentTextView.text = dict[@"goodsComment"];
    _cellIndex = index;
    
    
//    NSArray *imageArray = dict[@"imageList"];
//    if ([imageArray count] == 0 ) {
//        [self.imageScrollView updateViewInfoWithInfo:nil type:1];
//    } else {
//        [self.imageScrollView updateViewInfoWithInfo:imageArray type:1];
//    }
    
    NSArray *array = @[@"好评",@"中评",@"差评"];
    NSArray *array1 = @[@"haoping1",@"haoping1",@"chaping"];
    for (int i = 0; i < 3; i++) {
        LIRTUIButton *button1 = [[LIRTUIButton alloc] initWithFrame:CGRectMake(ScreenWidth/3.0*i, 100 + 70, ScreenWidth/3.0, 30)];
        button1.frame = CGRectMake(ScreenWidth/3.0*i, 100 + 70, ScreenWidth/3.0, 30);
        button1.tag = i;
        [button1 addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
        button1.rightLabel.text = array[i];
        button1.leftImg.image = [UIImage imageNamed:array1[i]];
        [self addSubview:button1];
    }
}

-(void)btnClick1:(LIRTUIButton *)btn
{
    NSArray *array1 = @[@"haoping1",@"haoping1",@"chaping"];
    NSArray *array2 = @[@"haoping",@"haoping",@"chaping1"];
    
    if ([self.delegate respondsToSelector:@selector(didSelectResult:)]) {
        [self.delegate didSelectResult:btn.tag];
    }
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        btn.leftImg.image = [UIImage imageNamed:array2[btn.tag]];
    } else
        btn.leftImg.image = [UIImage imageNamed:array1[btn.tag]];
}

- (void)btnTouchAction:(NSInteger)btnIndex {
    if (_delegate && [_delegate respondsToSelector:@selector(cBtnTouchAction:cellIndex:)]) {
        [_delegate cBtnTouchAction:btnIndex cellIndex:_cellIndex];
    }
}

- (void)addPhotoAction {
    if (_delegate && [_delegate respondsToSelector:@selector(cAddPhotoActionWithCellIndex:)]) {
        [_delegate cAddPhotoActionWithCellIndex:_cellIndex];
    }
}

- (void)deleteTouchAction:(NSInteger)btnIndex {
    
    NSMutableArray *imageArray = self.cellInfoDict[@"imageList"];
    [imageArray removeObjectAtIndex:(int)btnIndex-1001];
    if (imageArray.count == 0 ) {
        [self.imageScrollView updateViewInfoWithInfo:nil type:1];
    } else {
        [self.imageScrollView updateViewInfoWithInfo:self.cellInfoDict[@"imageList"] type:1];
    }
}

#pragma mark
#pragma mark Init & Add
- (UIImageView *)shopImageView {
    if (!_shopImageView) {
        _shopImageView = [[UIImageView alloc] init];
        _shopImageView.layer.masksToBounds = YES;
        [self addSubview:_shopImageView];
        [_shopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(10);
            make.top.equalTo(self.mas_top).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(60, 60));
        }];
    }
    return _shopImageView;
}
- (UILabel *)line1Label {
    if (!_line1Label) {
        _line1Label = [[UILabel alloc] init];
        _line1Label.backgroundColor = ADeanHEXCOLOR(0xcccccc);
        [self addSubview:_line1Label];
        [_line1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.top.equalTo(self.imageScrollView.mas_bottom).with.offset(10);
            make.height.equalTo(@0.5);
        }];
    }
    return _line1Label;
}
- (PlaceholderTextView *)commentTextView {
    if (!_commentTextView) {
        _commentTextView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth - 10, 60)];
        _commentTextView.placeholder = @"亲，评价可以用语音了，帮你码字的事交给我们吧！";
        _commentTextView.placeholderFont=[UIFont boldSystemFontOfSize:13];
        [self addSubview:_commentTextView];
        [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.shopImageView.mas_right).with.offset(5);
            make.right.equalTo(self.mas_right).with.offset(-35);
            make.top.equalTo(self.mas_top).with.offset(10);
            make.height.equalTo(@60);
        }];
    }
    return _commentTextView;
}
- (ImageViewScrollView *)imageScrollView {
    if (!_imageScrollView) {
        _imageScrollView = [[ImageViewScrollView alloc] init];
        _imageScrollView.backgroundColor = [UIColor clearColor];//ADeanHEXCOLOR(0xf5f5f5);
        _imageScrollView.iDelegate = (id<ImageViewScrollViewDelegate>)self;
        [self addSubview:_imageScrollView];
        [_imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(10);
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.top.equalTo(self.commentTextView.mas_bottom).with.offset(30);
            make.height.equalTo(@50);
        }];
    }
    return _imageScrollView;
}



@end

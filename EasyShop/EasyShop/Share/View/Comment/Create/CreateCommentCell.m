//
//  CreateCommentCell.m
//  MFBank
//
//  Created by lyywhg on 15/12/5.
//  Copyright (c) 2015年 MFBank. All rights reserved.
//

#import "CreateCommentCell.h"
#import "ImageViewScrollView.h"

@interface CreateCommentCell ()<ImageViewScrollViewDelegate>

@property (nonatomic, strong) UILabel *line1Label;
@property (nonatomic, strong) UILabel *line2Label;
@property (nonatomic, strong) ImageViewScrollView *imageScrollView;
@property (nonatomic, assign) NSInteger cellIndex;
@property (nonatomic, strong) NSDictionary *cellInfoDict;

@end

@implementation CreateCommentCell

- (void)updateViewInfoWithInfo:(NSArray *)array index:(NSInteger)index {
    self.userInteractionEnabled = YES;

    self.line1Label.alpha = 1.0f;
    self.line2Label.alpha = 1.0f;
    self.commentTextView.alpha = 1.0f;
    _cellIndex = index;

    [self.imageScrollView updateViewInfoWithInfo:array type:1];
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
//    if (_delegate && [_delegate respondsToSelector:@selector(cDeleteTouchAction:cellIndex:)]) {
//        [_delegate cDeleteTouchAction:btnIndex cellIndex:_cellIndex];
//    }
    
    [self.cellInfoDict[@"imageList"] removeObjectAtIndex:(int)btnIndex-1001];

    if ((self.cellInfoDict[@"imageList"]) || ([(NSArray *)self.cellInfoDict[@"imageList"] count] == 0) ) {
        [self.imageScrollView updateViewInfoWithInfo:nil type:1];
    } else {
        [self.imageScrollView updateViewInfoWithInfo:self.cellInfoDict[@"imageList"] type:1];
    }
}

#pragma mark
#pragma mark Init & Add
- (UILabel *)line1Label {
    if (!_line1Label) {
        _line1Label = [[UILabel alloc] init];
        _line1Label.backgroundColor = ADeanHEXCOLOR(0xcccccc);
        [self addSubview:_line1Label];
        [_line1Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            make.height.equalTo(@0.5);
        }];
    }
    return _line1Label;
}

- (UILabel *)line2Label {
    
    if (!_line2Label) {
        _line2Label = [[UILabel alloc] init];
        _line2Label.backgroundColor = ADeanHEXCOLOR(0x999999);
        [self addSubview:_line2Label];
        [_line2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.bottom.equalTo(self.commentTextView.mas_bottom).with.offset(1);
            make.height.equalTo(@0.5);
        }];
    }
    return _line2Label;
}

- (PlaceholderTextView *)commentTextView {
    if (!_commentTextView) {
        _commentTextView = [[PlaceholderTextView alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth - 10, 60)];
        _commentTextView.placeholder = @"填写照片介绍或描述，让你的照片更受欢迎";
        _commentTextView.placeholderFont=[UIFont boldSystemFontOfSize:13];
        [self addSubview:_commentTextView];
        [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(5);
            make.right.equalTo(self.mas_right).with.offset(-5);
            make.top.equalTo(self.mas_top).with.offset(10);
            make.height.equalTo(@120);
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
            make.top.equalTo(self.commentTextView.mas_bottom).with.offset(10);
            make.height.equalTo(@50);
        }];
    }
    return _imageScrollView;
}


@end

//
//  MyCommentCell.m
//  MFBank
//
//  Created by lyywhg on 15/12/5.
//  Copyright (c) 2015年 MFBank. All rights reserved.
//

#import "ESCommentCell.h"
#import "ImageViewScrollView.h"
#import "GSTimeTool.h"
@interface ESCommentCell ()

@property (nonatomic, strong) UILabel *userMobile;//用户
@property (nonatomic, strong) UILabel *timeLable;//评价时间
@property (nonatomic, strong) UILabel *commentLabel;//评价内容
@property (nonatomic, strong) UIScrollView *imageScrollView;//评价的图片
@property (nonatomic, strong) UILabel *lineLabel;//分割线
@property (nonatomic, strong) UIScrollView *showImageScrollview;//显示放大图片
@property (nonatomic,strong) UIView  *bgView;
@end



@implementation ESCommentCell

- (void)setEvaluationInfo:(GoodsEvaluationInfo *)evaluationInfo
{
    _evaluationInfo = evaluationInfo;
    
    self.userMobile.text = [_evaluationInfo.member_name stringByReplacingCharactersInRange:NSMakeRange(4, 4) withString:@"****"];
    self.timeLable.text  =[GSTimeTool formatterNumber:_evaluationInfo.create_time toType:GSTimeType_YYYYMMdd];
    
    self.commentLabel.text = _evaluationInfo.content;
    if (evaluationInfo.image.count==0) {
        
    }else{
        self.imageScrollView.contentSize=CGSizeMake(55*evaluationInfo.image.count, 50);
        self.showImageScrollview.contentSize=CGSizeMake(ScreenWidth*evaluationInfo.image.count, ScreenWidth);
        for (int i =0; i<evaluationInfo.image.count; i++) {
            UIImageView*iamge=[[UIImageView alloc]initWithFrame:CGRectMake(55*i, 0, 50, 50)];
            iamge.userInteractionEnabled=YES;
            iamge.tag=100+i;
            UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showImageView)];
            
            [iamge addGestureRecognizer:tap];
            [iamge sd_setImageWithURL:[NSURL URLWithString:[_evaluationInfo.image objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"bg"]];
            [self.imageScrollView addSubview:iamge];
        }
        
        
    }
    
}
-(void)showImageView{
//    DZLog(@"%ld",tap.view.tag-100);
    [kKeyWindow addSubview:self.bgView];
    
    for (int j=0; j<self.evaluationInfo.image.count; j++) {
        UIImageView*iamge=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth*j, 0, ScreenWidth  , ScreenWidth)];
        iamge.userInteractionEnabled=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImageView)];
        [iamge addGestureRecognizer:tap];

        [iamge sd_setImageWithURL:[NSURL URLWithString:[_evaluationInfo.image objectAtIndex:j]] placeholderImage:[UIImage imageNamed:@"bg"]];
        [self.showImageScrollview addSubview:iamge];
        
        
    }
    [self.bgView addSubview:self.showImageScrollview];
   // [self.showImageScrollview setContentOffset:CGPointMake((tap.view.tag-100)*ScreenWidth, 0) animated:NO];
}
-(void)hideImageView{
    [self.showImageScrollview removeFromSuperview];
    //[self.showImageScrollview setContentOffset:CGPointMake(0*ScreenWidth, 0) animated:YES];
    [self.bgView removeFromSuperview];
}
#pragma mark
#pragma mark Init & Add
-(UIView *)bgView{
    if (_bgView==nil) {
        _bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _bgView.backgroundColor=[UIColor blackColor];
    }
    return _bgView;
}
-(UIScrollView *)showImageScrollview{
    if (_showImageScrollview==nil) {
        _showImageScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
        _showImageScrollview.center=kKeyWindow.center;
        _showImageScrollview.showsHorizontalScrollIndicator=NO;
        _showImageScrollview.pagingEnabled=YES;
        
    }
    return _showImageScrollview;
}
-(UIScrollView *)imageScrollView{
    if (_imageScrollView==nil) {
        _imageScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        _imageScrollView.pagingEnabled=YES;
        _imageScrollView.showsHorizontalScrollIndicator=NO;
       // _imageScrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 5);
        //_imageScrollView.scrollIndicatorInsets=UIEdgeInsetsMake(0, 0, 0, 10);
        
        
    }
    return _imageScrollView;
}
- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc] init];
        _lineLabel.backgroundColor = ADeanHEXCOLOR(0xeeeeee);
    }
    return _lineLabel;
}
- (UILabel *)userMobile {
    if (!_userMobile) {
        _userMobile = [[UILabel alloc] init];
        _userMobile.font = ADeanFONT14;
        _userMobile.textAlignment = NSTextAlignmentLeft;
        _userMobile.textColor = ADeanHEXCOLOR(0x333333);
    }
    return _userMobile;
}
- (UILabel *)timeLable {
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.font = ADeanFONT14;
        _timeLable.textAlignment = NSTextAlignmentRight;
        _timeLable.textColor = ADeanHEXCOLOR(0x999999);
    }
    return _timeLable;
}
- (UILabel *)commentLabel {
    
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.numberOfLines = 0;
        _commentLabel.font = ADeanFONT14;
        _commentLabel.textColor = ADeanHEXCOLOR(0x999999);
    }
    return _commentLabel;
}
//- (ImageViewScrollView *)imageScrollView {
//    if (!_imageScrollView) {
//        _imageScrollView = [[ImageViewScrollView alloc] init];
//        _imageScrollView.iDelegate = (id<ImageViewScrollViewDelegate>)self;
//    }
//    return _imageScrollView;
//}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self intalizedView];
    }
    return self;
}


-(void)intalizedView
{
    [self.contentView addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-20));
        make.top.equalTo(@(0.5));
        make.height.equalTo(@0.5);
    }];
    
    [self.contentView addSubview:self.userMobile];
    [self.userMobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.top.equalTo(@(10));
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    [self.contentView addSubview:self.timeLable];
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.top.equalTo(@(10));
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    [self.contentView addSubview:self.commentLabel];
    [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.top.equalTo(self.timeLable.mas_bottom);
        make.left.equalTo(@(15));
        //make.height.equalTo(@20);
    }];
    
    [self.contentView addSubview:self.imageScrollView];
    [self.imageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.right.equalTo(@(-10));
        make.top.equalTo(self.commentLabel.mas_bottom).with.offset(5);
        make.height.equalTo(@50);
    }];
}

- (void)setModel:(id)model
{
    self.lineLabel.alpha = 1.0f;
    NSString *mobile = [@"13270720072" stringByReplacingCharactersInRange:NSMakeRange(3, 5) withString:@"*****"];
    self.userMobile.text = [NSString stringWithFormat:@"用户%@",mobile];
    self.timeLable.text = @"2012-1-12";
    self.commentLabel.text = @"好用，快递很给力，下次还来。";
   // NSArray *arr = @[@"page1",@"page1",@"page1"];
   // [self.imageScrollView updateViewInfoWithInfo:arr type:0];
}

- (void)btnTouchAction:(NSInteger)btnIndex {
    
}
- (void)addPhotoAction {
    
    
    
}



@end

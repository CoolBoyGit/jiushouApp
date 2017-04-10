//
//  ImagesSkimView.m
//  EasyShop
//
//  Created by guojian on 16/7/18.
//  Copyright © 2016年 wcz. All rights reserved.
//

#import "ImagesSkimView.h"

@interface ImagesSkimView()<UIScrollViewDelegate>

/** 所在位置 */
@property (nonatomic,assign) NSInteger atIndex;
/** images */
@property (nonatomic,strong) NSArray *images;

/** scrollView */
@property (nonatomic,weak) UIScrollView *scrollView;
/**所有的图片张数**/
@property (nonatomic,assign) int allCount;
/**当前的图片位置**/
@property (nonatomic,assign) int nowImagDex;
/**提示**/
@property (nonatomic,strong)  UIImageView *imageView;
@property (nonatomic,strong) UILabel *tipsLabel;
/**捏合手势**/
@property (nonatomic,strong) UIPinchGestureRecognizer*pinGesture;
/**旋转手势**/
@property (nonatomic,strong) UIRotationGestureRecognizer*rotationGesture;
@end

@implementation ImagesSkimView
{
    CGFloat left,top,width,height;
    CGFloat margin;
}

+ (void)showImages:(NSArray *)images atIndex:(NSInteger)atIndex
{
    
    ImagesSkimView *skim = [[ImagesSkimView alloc] init];
    skim.images = images;
    skim.atIndex = atIndex;
    
    [skim showView];
}
-(UILabel *)tipsLabel{
    if (_tipsLabel==nil) {
        _tipsLabel=[[UILabel alloc]init];
        _tipsLabel.textColor=[UIColor yellowColor];
        _tipsLabel.frame=CGRectMake(0, 0, 30, 30);
       
    }
    return _tipsLabel;
}
- (void)setImages:(NSArray *)images
{
    //[self addGesture];
    _images = images;
    self.allCount=(int)images.count;
    width = ScreenWidth;
    height = ScreenWidth;
    for (int i = 0 ; i < images.count ; i++) {
        UIImageView* imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(i*width, 0, width, height);
        imageView.centerY=self.centerY;
        imageView.userInteractionEnabled = YES;
        UIPinchGestureRecognizer*pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinGestureAction:)];
        [imageView addGestureRecognizer:pinch];
        //[self.imageView addGestureRecognizer:self.pinGesture];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"bg"]];
        [self.scrollView addSubview:imageView];
    }
    self.scrollView.contentSize = CGSizeMake(width * images.count, height);
}
-(void)addGesture{
    self.pinGesture=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinGestureAction:)];
    self.rotationGesture=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationAction:)];
    
    
}
-(void)pinGestureAction:(UIPinchGestureRecognizer*)pinch{
    UIImageView*imageV=(UIImageView*)pinch.view;
    imageV. transform=CGAffineTransformMakeScale(pinch.scale, pinch.scale);
}
-(void)rotationAction:(UIRotationGestureRecognizer*)rotation{
    self.imageView.transform=CGAffineTransformMakeRotation(rotation.rotation);
}
- (void)setAtIndex:(NSInteger)atIndex
{
    self.nowImagDex=(int)atIndex+1;
    _atIndex = atIndex;
    
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth*atIndex, 0) animated:NO];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor=[UIColor blackColor];
               self.frame = kKeyWindow.bounds;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];

        self.hidden = YES;
                UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        scrollView.center=self.center;
        scrollView.delegate=self;
       // scrollView.backgroundColor=[UIColor whiteColor];
        scrollView.backgroundColor =  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator=NO;
        //[scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] init]];
        [self addSubview:scrollView];
        
        self.scrollView = scrollView;
        
    }
    return self;
}

- (void)tapAction
{
    [self hideView];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.nowImagDex =  scrollView.contentOffset.x/ScreenWidth+1;
    self. tipsLabel.text=[NSString stringWithFormat:@"%d/%d",self.nowImagDex,self.allCount];
}
- (void)showView
{
     self. tipsLabel.text=[NSString stringWithFormat:@"%d/%d",self.nowImagDex,self.allCount];
    self.hidden = NO;
   

    [kKeyWindow addSubview:self];
    [kKeyWindow addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-20));
        make.width.equalTo(@40);
        make.height.equalTo(@20);
        make.left.equalTo(@((ScreenWidth-40)/2.0));
    }];
}

- (void)hideView
{
    self.hidden = YES;
    [self.tipsLabel removeFromSuperview];
    [self removeFromSuperview];
}



@end


//
//  ICProductMessageCell.m
//  
//
//  Created by wcz on 16/3/30.
//
//

#import "ICProductMessageCell.h"
#import "EMMessage.h"

#define kImageWidth 60
#define kImageHeight 60
#define kTitleHeight 20

#define BUBBLE_LEFT_IMAGE_NAME @"chat_receiver_bg" // bubbleView 的背景图片
#define BUBBLE_RIGHT_IMAGE_NAME @"chat_sender_bg"
#define BUBBLE_ARROW_WIDTH 5 // bubbleView中，箭头的宽度
#define BUBBLE_VIEW_PADDING 8 // bubbleView 与 在其中的控件内边距

#define BUBBLE_RIGHT_LEFT_CAP_WIDTH 5 // 文字在右侧时,bubble用于拉伸点的X坐标
#define BUBBLE_RIGHT_TOP_CAP_HEIGHT 35 // 文字在右侧时,bubble用于拉伸点的Y坐标

#define BUBBLE_LEFT_LEFT_CAP_WIDTH 35 // 文字在左侧时,bubble用于拉伸点的X坐标
#define BUBBLE_LEFT_TOP_CAP_HEIGHT 35 // 文字在左侧时,bubble用于拉伸点的Y坐标

#define BUBBLE_PROGRESSVIEW_HEIGHT 10 // progressView 高度

#define KMESSAGEKEY @"message"

@interface ICProductMessageCell ()

@property (nonatomic, strong) UILabel *productTitleLabel;
@property (nonatomic, strong) UIImageView *productImageView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *groundImageView;
@property (nonatomic ,strong) UILabel *priceLabel;


@end

@implementation ICProductMessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(id<IMessageModel>)model
{
    if (self = [super  initWithStyle:style
                     reuseIdentifier:reuseIdentifier
                               model:model])
    {
        [self initalizedView];
    } ;
    return self;
}

- (UIImageView *)groundImageView
{
    if (_groundImageView == nil) {
        _groundImageView = [[UIImageView alloc] init];
        _groundImageView.image =   [[UIImage imageNamed:@"icon_sender"] stretchableImageWithLeftCapWidth:5 topCapHeight:15];
    }
    return _groundImageView;
}

- (void)initalizedView;
{
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
        _topLabel.font = [UIFont systemFontOfSize:12.0];
        _topLabel.text = @"我正在看";
        _topLabel.backgroundColor = [UIColor clearColor];
        [self.bubbleView addSubview:_topLabel];
        
        _productImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_topLabel.frame) + 5, kImageWidth, kImageHeight)];
        [self.bubbleView addSubview:_productImageView];
        
        _productTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productImageView.frame) + 5, CGRectGetMaxY(_topLabel.frame) + 5, 120, 35)];
        _productTitleLabel.numberOfLines = 2;
        _productTitleLabel.font = [UIFont systemFontOfSize:13.0];
        _productTitleLabel.textColor = [UIColor blackColor];
        _productTitleLabel.backgroundColor = [UIColor clearColor];
        [self.bubbleView addSubview:_productTitleLabel];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_productImageView.frame) + 5, CGRectGetMaxY(_productTitleLabel.frame), 120, 15)];
        _priceLabel.font = [UIFont systemFontOfSize:13.0];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = [UIColor redColor];
        [self.bubbleView addSubview:_priceLabel];
        [self.bubbleView insertSubview:self.groundImageView atIndex:0];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _productImageView.frame = CGRectMake(10, CGRectGetMaxY(_topLabel.frame) + 5, kImageWidth, kImageHeight);
    _productTitleLabel.frame = CGRectMake(CGRectGetMaxX(_productImageView.frame) + 5, CGRectGetMaxY(_topLabel.frame) + 5, (130 * ScreenWidth / 375.0), 35);
    _priceLabel.frame = CGRectMake(CGRectGetMaxX(_productImageView.frame) + 5, CGRectGetMaxY(_productTitleLabel.frame) + 5, 150*ScreenWidth / 375.0, 15);

    self.bubbleView.frame = CGRectMake(ScreenWidth - (220 * ScreenWidth / 375.0) - 50 , self.bubbleView.frame.origin.y, (220 * ScreenWidth / 375.0), 110);
    
    self.groundImageView.frame = CGRectMake(0, 0, (220 * ScreenWidth / 375.0), 100);
}

#pragma mark - setter


- (void)setModel:(id<IMessageModel> )model
{
    [super setModel:model];
    self.sendBubbleBackgroundImage =nil;
    EMMessage *message =   [model message];
    NSDictionary *dic = [message.ext objectForKey:@"msgtype"];
    NSDictionary *itemDic = [dic objectForKey:@"order"] ? [dic objectForKey:@"order"] : [dic objectForKey:@"track"];
    
    _topLabel.text = [itemDic objectForKey:@"title"];
    _productTitleLabel.text = [itemDic objectForKey:@"desc"];
    _priceLabel.text = [itemDic objectForKey:@"price"];
    NSString *imageName = [itemDic objectForKey:@"img_url"];
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"bg100"]];
    if ([imageName length] > 0) {
//        [_productImageView setImageWithURLText:imageName placeholderImage:nil];
    }
    else{
        _productImageView.image = [UIImage imageNamed:@"imageDownloadFail.png"];
    }
}




@end

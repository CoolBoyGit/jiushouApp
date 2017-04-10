//
//  ICAlertView.m
//  iCare
//
//  Created by YURI_JOU on 15/12/2.
//  Copyright © 2015年 oenius. All rights reserved.
//

#import "ICAlert.h"
#import "ICShareInfoView.h"
#import "ICCardTypePickerView.h"

#define IC_ALERT_NIB_NAME @"ICAlertView"

@interface
ICAlert ()<UITableViewDelegate,UITableViewDataSource,ICPickerViewDelegate>

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UIView *animateView;
@property (nonatomic, strong) UIView *bg;
@property (nonatomic, weak) UIView *textField;
@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray*dataArray;
@property (nonatomic, strong) void (^callBack)(NSInteger);

@end

@implementation ICAlert

- (NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[@"我的订单",@"现金券",@"消息"];
    }
    return _dataArray;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.layer.cornerRadius=8;
        _tableView.layer.masksToBounds=YES;
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


+ (instancetype)alert
{
  static ICAlert *alert;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    alert = [[self.class alloc]init];
  });
  return alert;
}

- (instancetype)init
{
  self = [super init];
  if (self)
  {
    if (!_bg)
    {
      self.bg = [[UIView alloc] initWithFrame:CGRectZero];
      self.bg.backgroundColor = RGBA(241, 241, 241, 0.2);
      self.bg.hidden = YES;
        //_bg.backgroundColor=[UIColor yellowColor];
        //_bg.backgroundColor=RGB(212, 224, 235);
        //_bg.backgroundColor=[UIColor yellowColor];
      [self.window addSubview:self.bg];
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleHide:)];
      tap.numberOfTapsRequired = 1;
      [self.bg addGestureRecognizer:tap];
      [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.window);
      }];
    }
  }
  return self;
}

#pragma mark - getter
- (UIWindow *)window
{
  if (!_window)
  {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
      window.backgroundColor = [UIColor clearColor];
    window.windowLevel = UIWindowLevelNormal;
    _window = window;
  }
  return _window;
}
/**显示退款页面的原因**/
-(void)showPickerVieTextField:(UIView *)textField andComFromRefound:(BOOL)isComfromRefund{
    //可以用父类来接受子类的创建
    ICPickerView *pickerView=[[ICCardTypePickerView alloc]initWithFrame:CGRectZero andIsComFromRefound:isComfromRefund];
    if (pickerView == nil)
    {
        return;
    }
    pickerView.delegate = self;
    self.textField = textField;
    [self.window addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@204.f);
        make.left.right.bottom.equalTo(@0);
    }];
    
    self.animateView = pickerView;
    [self show];

    
}
//点击确定按钮
/**用来给退款理由赋值**///ICCardTypePickerView的协议方法
- (void)ICPickerViewDidPickerInfoBeSure:(NSString *)info
{
    [self.textField setValue:info forKey:@"text"];
    [self hide];
    if (self.delegate && [self.delegate respondsToSelector:@selector(ICAlertDidPickerSource:)])
    {
        [self.delegate ICAlertDidPickerSource:info];
    }
}
- (void)ICPickerViewDidPickerInfoBeCancel:(NSString *)info
{
    [self hide];
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self hide];
}



- (void)showShareViewDelegate:(id<ICAlertDelegate>)delegate
{
    if (self.animateView) return;

    ICShareInfoView*view = [[ICShareInfoView alloc] initWithFrame:CGRectZero];;
    
    [view setSelectShareButton:^(NSInteger index) {
        [self hide];
        if (delegate && [delegate respondsToSelector:@selector(ICAlertShareDidSelectIndex:)]) {
            [delegate ICAlertShareDidSelectIndex:index];
        }
    }];
    
    [self.window addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@180.f);
        make.left.right.bottom.equalTo(@0);
    }];
    
    self.animateView = view;
    [self show];
}

/*这里是首页的按钮*/
- (void)selectTypeInfoCallBack:(void (^)(NSInteger))callBack
{
    [self show];
    [self.window addSubview:self.tableView];
    self.tableView.layer.borderWidth=1;
    self.tableView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@64);
        make.width.equalTo(@100);
        make.height.equalTo(@120);
    }];
    self.callBack =callBack;
    self.animateView = self.tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.contentView. backgroundColor = RGB(253, 253, 253);
    //cell.contentView.alpha=0.1;
//    UIView *view=[[UIView alloc]initWithFrame:cell.bounds];
//    view.backgroundColor= RGB(138, 138, 138);
////    view.alpha=0.2;
//    [cell.contentView addSubview:view];
    //cell.textLabel.backgroundColor=[UIColor yellowColor];
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:15.5];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.callBack(indexPath.row);
    [self hide];

}

#pragma mark - private

- (void)show
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
  [self.window makeKeyAndVisible];
  self.window.hidden = NO;
  self.bg.hidden = NO;
}

- (void)hide
{
  [self.window resignKeyWindow];
  self.window.hidden = YES;
  [self.animateView removeFromSuperview];
    self.animateView = nil;
    self.callBack = nil;
}

- (void)popOverFromBottomWithHeight:(CGFloat)height
{
  CALayer *layer = self.animateView.layer;
  CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"position.y"];
  translation.fromValue = @(height);
  translation.toValue = @(0);
  translation.duration = .25;
  [layer addAnimation:translation forKey:nil];
}


- (void)handleHide:(UIGestureRecognizer *)gesture
{
  [self hide];
}

@end

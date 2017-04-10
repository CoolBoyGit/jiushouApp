//
//  RichScanViewController.m
//  BagWord
//
//  Created by LDZPro on 16/1/14.
//  Copyright © 2016年 LDZPro. All rights reserved.
//

#import "RichScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ESScanWebController.h"
@interface RichScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *borderImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineTopto;

@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;

//屏幕的刷新频率
@property(nonatomic,strong) CADisplayLink*displayLink;
@property(strong,nonatomic) AVCaptureSession*session;
@property(assign,nonatomic) BOOL isLineMoveUp;
@end

@implementation RichScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor grayColor];
    self.view.alpha=0.5;
    [self createUI];
    [self initAnmiation];
    [self initScanner];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.session startRunning];
}
-(void)initAnmiation{
    //屏幕刷新的时候调用[]
    self.displayLink=[CADisplayLink displayLinkWithTarget:self selector:@selector(updateAnimation)];
    //启动刷新
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}
-(void)initScanner{
    //将摄像头获取的图片数据转换位字符串
    //图片->Device->input->session->output->字符串
//                              |
//                              V
//                             Layer
    
    
    //获取摄像头的设备
    AVCaptureDevice*device=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //2.生成对象
    NSError*error;
    AVCaptureDeviceInput*input=[AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    if (error) {
        NSLog(@"获取摄像头失败:%@",error);
    }
    //3 创建输出对象(原数据输出对象)
    AVCaptureMetadataOutput*output=[[AVCaptureMetadataOutput alloc]init];
    //将输入和输出通过session连接起来
    //4.1创建session对象
    self.session=[[AVCaptureSession alloc]init];
    //4.2 给session对象添加输入
    [self.session addInput:input];
    //4.3 给session对象添加输出
    [self.session addOutput:output];
    //5 配置输出对象
    //5.1 给输出对象添加代理
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //5.2 给输出对像设置输出格式
    
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    //6 s设置预览层
    AVCaptureVideoPreviewLayer*previewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
    previewLayer.frame=[UIScreen mainScreen].bounds ;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    //7启动session
    [self.session startRunning];
    
    
}
-(void)updateAnimation{
    if (CGRectGetMaxY(self.lineImageView.frame)>CGRectGetMaxY(self.borderImageView.frame)) {
        self.isLineMoveUp=YES;
    }if (CGRectGetMinY(self.lineImageView.frame)<CGRectGetMinY(self.borderImageView.frame)) {
        self.isLineMoveUp=NO;
    }
    if (self.isLineMoveUp) {
        self.lineTopto.constant-=1.0;
        self.lineImageView.transform=CGAffineTransformMakeRotation(M_PI);
        
    }else{
        self.lineTopto.constant+=1.0;
        self.lineImageView.transform=CGAffineTransformIdentity;
    }
 
}
-(void)createUI{
    self.title=@"扫一扫";
//    [self setNavigationTitle:@"扫一扫"];
//    [self addLeftNavigationItem:@"返回" backImage:@"" target:self selector:@selector(leftButtonAction)];
}
//当扫描成功之后调用的代理方法
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count>0) {
        //停止扫描
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject*obj=[metadataObjects lastObject];
        ESScanWebController*scanVc=[[ESScanWebController alloc]init];
        scanVc.url=[obj stringValue];
        [self.navigationController pushViewController:scanVc animated:YES];
        
 }
}
-(void)leftButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
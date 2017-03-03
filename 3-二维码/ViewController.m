//
//  ViewController.m
//  3-二维码
//
//  Created by huangbq on 2017/3/3.
//  Copyright © 2017年 huangbq. All rights reserved.
//

#import "ViewController.h"
#import "BQPreView.h"

/**
 二维码实现思路
 1、输入设备
 2、输出设备()
 3、会话(AVCaptureSession)
 4、预览图层(medatapreviweLayer)
 */
@interface ViewController () <AVCaptureMetadataOutputObjectsDelegate>
// 1、输入设备
@property(nonatomic, strong) AVCaptureDeviceInput *input;
// 2、输出设备()
@property(nonatomic, strong) AVCaptureMetadataOutput *output;
// 3、会话(AVCaptureSession)
@property(nonatomic, strong) AVCaptureSession *session;
// 4、预览图层(medatapreviweLayer)
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property(nonatomic, strong) BQPreView *preview;

@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setupCaptureSession];
}

- (void)setupCaptureSession
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
    
    _output = [[AVCaptureMetadataOutput alloc] init];
    
    _session = [[AVCaptureSession alloc] init];
    
    // 设置扫描大小
    [_session setSessionPreset:AVCaptureSessionPreset352x288];
    
    // 会话跟输入、输出绑定
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    if ([_session canAddOutput:_output]) {
        
        [_session addOutput:_output];
    }
    
    // 指定输出设备的代理
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置元数据类型
    [_output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    
    _previewLayer.frame = self.view.bounds;
    
//    [self.view.layer addSublayer:_previewLayer];
    self.preview = [[BQPreView alloc] initWithFrame:self.view.bounds];
    self.preview.session = _session;
    
    [self.view addSubview:self.preview];
    
    // 启动会话
    [_session startRunning];
}


/**
 会话代理

 @param captureOutput 输出设备
 @param metadataObjects 元数据对象数组
 @param connection 连接
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // 停止会话
    [_session stopRunning];
    
    // 删除layer
//    [_previewLayer removeFromSuperlayer];
    [self.preview removeFromSuperview];

    // 遍历数组，获取数据
    for (AVMetadataMachineReadableCodeObject *obj in metadataObjects) {
//        NSLog(@"%@", obj.stringValue);
        self.label.text = obj.stringValue;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

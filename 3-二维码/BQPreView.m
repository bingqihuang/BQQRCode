//
//  BQPreView.m
//  二维码扫描
//
//  Created by huangbq on 15/8/10.
//  Copyright (c) 2015年 huangbq. All rights reserved.
//

#import "BQPreView.h"
@interface BQPreView ()
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)UIImageView *lineImageView;
@property (nonatomic,strong)NSTimer *timer;
@end
@implementation BQPreView
/**
 *  layer的类型
 *
 *  @return AVCaptureVideoPreviewLayer 特殊的layer 可以展示输入设备采集到得信息
 */
+ (Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (void)setSession:(AVCaptureSession *)session
{
    _session = session;
    
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)  self.layer;
    layer.session = session;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUiConfig];
    }
    return self;
}

#define TimerRepeatInSeconds 6.0

- (void)initUiConfig
{
    //设置背景图片
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg.png"]];
    //设置位置到界面的中间
    _imageView.frame = CGRectMake(self.bounds.size.width * 0.5 - 140, self.bounds.size.height * 0.5 - 140, 280, 280);
    //添加到视图上
    [self addSubview:_imageView];
    
    //初始化二维码的扫描线的位置
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    _lineImageView.image = [UIImage imageNamed:@"line.png"];
    [_imageView addSubview:_lineImageView];
    
    //开启定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:TimerRepeatInSeconds target:self selector:@selector(animation) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)animation
{
    [UIView animateWithDuration:TimerRepeatInSeconds/2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        _lineImageView.frame = CGRectMake(30, 260, 220, 2);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:TimerRepeatInSeconds/2 animations:^{
            _lineImageView.frame = CGRectMake(30, 10, 220, 2);
        }];
    }];
}

@end

//
//  BQPreView.h
//  二维码扫描
//
//  Created by huangbq on 15/8/10.
//  Copyright (c) 2015年 huangbq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BQPreView : UIView
@property (nonatomic,strong)AVCaptureSession *session;
@end

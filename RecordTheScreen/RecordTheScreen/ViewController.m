//
//  ViewController.m
//  RecordTheScreen
//
//  Created by youxin on 2019/3/27.
//  Copyright © 2019年 yst. All rights reserved.
//

#import "ViewController.h"
#import "GIFImageView.h"
#import <ReplayKit/ReplayKit.h>

@interface ViewController (){
    UIImageView *image1;
    UIImageView *image2;
}

@end

@implementation ViewController

//监测是否录屏
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // 监测当前设备是否处于录屏状态
    UIScreen * sc = [UIScreen mainScreen];
    if (@available(iOS 11.0, *)) {
        if (sc.isCaptured) {
            [self screenshots];
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 11.0, *)) {
        // 检测到当前设备录屏状态发生变化
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(screenshots) name:UIScreenCapturedDidChangeNotification object:nil];
    } else {
        // Fallback on earlier versions
    }
}

-(void) screenshots
{
    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:nil message:@"小老弟禁止截屏！" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert1 show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
#warning !!!  ios Error Domain=com.apple.ReplayKit.RPRecordingErrorDomain Code=-5807  需要重启手机 暂时还没有发现其他方法
    [self creatUI];
    
}
-(void)creatUI{
    
    for(int i = 0;i<5;i++){
        
        GIFImageView *fly1 = [[GIFImageView alloc] initWithFrame:CGRectMake(50 +i*50, 100+i*50, 100, 83)];
        [self.view addSubview:fly1];
        fly1.gifPath = [[NSBundle mainBundle] pathForResource:@"butterfly" ofType:@"gif"];
        [fly1 startGIF];
    }
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake((self.view.frame.size.width-200)/2, 500, 200, 40);
    btn.backgroundColor = [UIColor greenColor];
    [self.view addSubview:btn];
    [btn setTitle:@"开始录制" forState:(UIControlStateNormal)];
    [btn setTitle:@"结束录制" forState:(UIControlStateSelected)];
    [btn addTarget:self action:@selector(replayKitAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
//启动或者停止录制回放
- (void)replayKitAction:(UIButton *)sender {
    //判断是否已经开始录制回放
    if (sender.isSelected) {
        //停止录制回放，并显示回放的预览，在预览中用户可以选择保存视频到相册中、放弃、或者分享出去
        [[RPScreenRecorder sharedRecorder] stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@", error);
                //处理发生的错误，如磁盘空间不足而停止等
            }
            if (previewViewController) {
                //设置预览页面到代理
                previewViewController.previewControllerDelegate = self;
                [self presentViewController:previewViewController animated:YES completion:nil];
            }
        }];
        sender.selected = NO;
        return;
    }
    
    //如果还没有开始录制，判断系统是否支持
    if ([RPScreenRecorder sharedRecorder].available) {
        NSLog(@"OK");
        sender.selected = YES;
        //如果支持，就使用下面的方法可以启动录制回放
        [[RPScreenRecorder sharedRecorder] startRecordingWithMicrophoneEnabled:YES handler:^(NSError * _Nullable error) {
            NSLog(@"%@", error);
            //处理发生的错误，如设用户权限原因无法开始录制等
        }];
    } else {
        NSLog(@"录制回放功能不可用");
    }
}

//回放预览界面的代理方法
- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController {
    //用户操作完成后，返回之前的界面
    [previewController dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)dealloc
{
    if (@available(iOS 11.0, *)) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenCapturedDidChangeNotification object:nil];
    } else {
        // Fallback on earlier versions
    }
}

@end

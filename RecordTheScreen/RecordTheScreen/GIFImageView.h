/*******************************************************
 *  依赖:
 *      - QuartzCore.framework
 *      - ImageIO.framework
 *  参数:
 *      以下传参2选1：
 *      - gifData       GIF图片的NSData
 *      - gifPath       GIF图片的本地路径
 *  调用:
 *      - startGIF      开始播放
 *      - stopGIF       结束播放
 *      - isGIFPlaying  判断是否正在播放
 *  另外：
 *      想用 category？请使用 UIImageView+PlayGIF.h/m
 
 //蝴蝶1
 
 _fly1 = [[GIFImageView alloc] initWithFrame:CGRectMake1(204, 187, 60, 43)];
 [_scrollView addSubview:_fly1];
 _fly1.gifPath = [[NSBundle mainBundle] pathForResource:@"butterfly" ofType:@"gif"];
 [_fly1 startGIF];
 */



#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>

@interface GIFImageView : UIImageView
@property (nonatomic, strong) NSString *gifPath;
@property (nonatomic, strong) NSData   *gifData;

- (void)startGIF;
- (void)stopGIF;
- (BOOL)isGIFPlaying;
- (void)imageOffset;

@end
















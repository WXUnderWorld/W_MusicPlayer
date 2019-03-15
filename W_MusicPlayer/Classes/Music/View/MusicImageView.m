//
//  MusicImageView.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/13.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "MusicImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MusicImageView ()

@property (nonatomic,strong) UIImageView *audioImageView;
@property (nonatomic,strong) CAShapeLayer *shapeLayer;

@end

@implementation MusicImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    _audioImageView = [[UIImageView alloc] init];
    _audioImageView.center = self.center;
    _audioImageView.bounds = CGRectMake(0, 0, ScreenW-100, ScreenW-100);
    _audioImageView.layer.masksToBounds = YES;
    _audioImageView.layer.cornerRadius = (ScreenW-100)/2;
    [self addSubview:_audioImageView];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_audioImageView.frame];
    _shapeLayer = [[CAShapeLayer alloc] init];
    _shapeLayer.path = path.CGPath;
    _shapeLayer.fillColor = [UIColor redColor].CGColor;
    _shapeLayer.strokeColor = [UIColor colorWithWhite:0.1 alpha:0.9].CGColor;
    _shapeLayer.lineWidth = 15;
    [self.layer addSublayer:_shapeLayer];
    [_shapeLayer addSublayer:_audioImageView.layer];
}


- (void)setImageUrl:(NSString *)imageUrl
{
    if (imageUrl.length) {
        [_audioImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }else{
        [_audioImageView sd_setImageWithURL:[NSURL URLWithString:@"http://star.kuwo.cn/star/starheads/180/42/50/1391111203.jpg"]];
    }
}

- (void)startAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI*2);
    animation.duration = 20;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_audioImageView.layer addAnimation:animation forKey:@"transform.rotation.z"];
}


// 暂停旋转
- (void)pauseAnimation
{
    CFTimeInterval pausedTime = [_audioImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    _audioImageView.layer.speed = 0.0;
    _audioImageView.layer.timeOffset = pausedTime;
}

- (void)continueAnimation
{
    CFTimeInterval pausedTime = _audioImageView.layer.timeOffset;
    _audioImageView.layer.speed = 1.0;
    _audioImageView.layer.timeOffset = 0.0;
    _audioImageView.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [_audioImageView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    _audioImageView.layer.beginTime = timeSincePause;  // 从暂停的时间点开始旋转
}

@end

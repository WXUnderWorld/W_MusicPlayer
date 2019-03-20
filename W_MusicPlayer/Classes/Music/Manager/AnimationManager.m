//
//  AnimationManager.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/19.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "AnimationManager.h"

@implementation AnimationManager


+ (void)startAnimation:(CALayer *)layer
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = @(M_PI*2);
    animation.duration = 20;
    animation.repeatCount = MAXFLOAT;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [layer addAnimation:animation forKey:@"transform.rotation.z"];
}

+(void)pauseAnimation:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

+ (void)continueAnimation:(CALayer *)layer
{
    CFTimeInterval pausedTime = layer.timeOffset;
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;  // 从暂停的时间点开始旋转
}

@end

//
//  ShakeView.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/19.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "ShakeView.h"
#import "AnimationManager.h"
@interface ShakeView ()

@property (nonatomic,strong) CAReplicatorLayer * repliLayer;
@property (nonatomic,strong) CALayer *singlelayer;

@end

@implementation ShakeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _repliLayer = [CAReplicatorLayer  layer];
        _repliLayer.frame = self.bounds;
        _repliLayer.instanceCount = 5;
        _repliLayer.instanceTransform = CATransform3DMakeTranslation(5, 0, 0);
        _repliLayer.instanceDelay = 0.3;
        [self.layer addSublayer:_repliLayer];
        
        //创建一个振动条
        _singlelayer = [CALayer layer];
        _singlelayer.backgroundColor = [UIColor whiteColor].CGColor;
        _singlelayer.bounds = CGRectMake(0, 0, 2, 20);
        _singlelayer.anchorPoint = CGPointMake(0, 1);
        _singlelayer.position = CGPointMake(10, self.bounds.size.height/2 + 10);
        [_repliLayer addSublayer:_singlelayer];
        
        [self startAnimation];
    }
    return self;
}

- (void)setLayerColor:(UIColor *)layerColor
{
    _layerColor = layerColor;
    _singlelayer.backgroundColor = layerColor.CGColor;
}

- (void)startAnimation
{
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0;
    anim.repeatCount = MAXFLOAT;
    anim.duration = 0.5;
    anim.autoreverses = YES;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [_singlelayer addAnimation:anim forKey:nil];
}

- (void)continueAnimation
{
    [AnimationManager continueAnimation:_singlelayer];
}
- (void)pauseAnimation
{
    [AnimationManager pauseAnimation:_singlelayer];
}


@end

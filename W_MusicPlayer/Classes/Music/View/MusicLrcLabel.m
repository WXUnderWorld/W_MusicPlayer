//
//  MusicLrcLabel.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/14.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "MusicLrcLabel.h"

@implementation MusicLrcLabel

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (self.text.length == 0) {
        return;
    }
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * _progress, self.bounds.size.height);
    [[UIColor greenColor] set];
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

@end

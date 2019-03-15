//
//  PlayScrollView.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/14.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "PlayScrollView.h"
#import "MusicImageView.h"
#import "LrcView.h"

@interface PlayScrollView ()
@property (nonatomic,strong) MusicImageView *musicImgView;
@property (nonatomic,strong) LrcView *musicLrcView;
@end

@implementation PlayScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        _musicImgView = [[MusicImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_musicImgView];
        
        _musicLrcView = [[LrcView alloc] initWithFrame:CGRectMake(ScreenW, 80, ScreenW, self.bounds.size.height-100)];
        [self addSubview:_musicLrcView];
        
    }
    return self;
}

- (void)setLrcDataList:(NSArray *)lrcDataList
{
    _musicLrcView.lrcArray = lrcDataList;
}

- (void)setCurrentPlayTime:(NSTimeInterval)currentPlayTime
{
    _musicLrcView.currentPlayTime = currentPlayTime;
}

- (void)setPlayerDuration:(NSTimeInterval)playerDuration
{
    _musicLrcView.playerDuration = playerDuration;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _musicImgView.imageUrl = imageUrl;
}

- (void)startAnimation
{
    [_musicImgView startAnimation];
}

- (void)pauseAnimation
{
    [_musicImgView pauseAnimation];
}

- (void)continueAnimation
{
    [_musicImgView continueAnimation];
}

@end

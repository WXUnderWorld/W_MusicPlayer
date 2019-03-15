//
//  MusicManager.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/12.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "MusicManager.h"
#import "MusicListModel.h"

@interface MusicManager ()
@property (nonatomic,assign) CGFloat current_Time;
@end

@implementation MusicManager

+ (instancetype)shareManager
{
    static MusicManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[MusicManager alloc] init];
    });
    return _manager;
}

- (AVPlayer *)musicPlayer
{
    if (!_musicPlayer) {
        _musicPlayer = [[AVPlayer alloc] init];
    }
    return _musicPlayer;
}


- (void)startPlayWithUrl:(NSURL *)url
{
    [self removeObservers];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    [self.musicPlayer replaceCurrentItemWithPlayerItem:playerItem];
    [self addObservers];
    
    if (self.musicArray.count) {
        if ([self.delegate respondsToSelector:@selector(playerCurrentPlayData:)]) {
            [self.delegate playerCurrentPlayData:self.musicArray[_currentIndex]];
        }
    }
    
}


- (void)addObservers
{
    //监测状态
    [self.musicPlayer.currentItem addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew) context:nil];
    
    [self.musicPlayer.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    //监控播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.musicPlayer.currentItem];
    
    //监控时间进度
    __weak typeof(self) weakSelf = self;
    self.timeObserver = [self.musicPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1, 10) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        AVPlayerItem *item = weakSelf.musicPlayer.currentItem;
        //获取歌曲的时长
        CGFloat total = CMTimeGetSeconds(item.duration);
        //当前播放时间
        CGFloat currentTime = item.currentTime.value/item.currentTime.timescale;
        if ((NSInteger)weakSelf.current_Time == (NSInteger)currentTime) {
            weakSelf.current_Time += 0.1;
        }else{
            weakSelf.current_Time = currentTime;
        }
        if (currentTime) {
            //更新播放进度
            if ([weakSelf.delegate respondsToSelector:@selector(updateProgress:currentTime:startTime:)]) {
                [weakSelf.delegate updateProgress:weakSelf.current_Time/total currentTime:weakSelf.current_Time startTime:[weakSelf changeStringForTime:currentTime]];
            }
            
            //监测播放状态；暂停、播放中
            if ([weakSelf.delegate respondsToSelector:@selector(playerPlayingState:)]) {
                [weakSelf.delegate playerPlayingState:(NSInteger)weakSelf.musicPlayer.rate];
            }
        }
        
    }];
    
    
}



- (void)playbackFinished:(NSNotification *)notifi {
    NSLog(@"播放完成");
    [self playNext];
    if ([self.delegate respondsToSelector:@selector(playerPlayFinished)]) {
        [self.delegate playerPlayFinished];
    }
}


//拖动h进度条控制播放进度
- (void)setSliderValue:(CGFloat)sliderValue
{
    _sliderValue = sliderValue;
    CGFloat total = CMTimeGetSeconds(self.musicPlayer.currentItem.duration);
    CGFloat seconds = total * _sliderValue;
    [self.musicPlayer seekToTime:CMTimeMakeWithSeconds(seconds, 1) toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
        [self.musicPlayer play];
    }];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerItemStatus status = [change[@"new"] integerValue];
        switch (status) {
            case AVPlayerItemStatusReadyToPlay:
            {
                // 开始加载准备播放
                [self.musicPlayer play];
            }
                break;
            case AVPlayerItemStatusFailed:
            {
                NSLog(@"加载失败:%@",self.playingName);
                [self playNext];
            }
                break;
            case AVPlayerItemStatusUnknown:
            {
                NSLog(@"未知资源:%@",self.playingName);
                [self playNext];
            }
                break;
            default:
                break;
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        
        NSArray *array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        NSTimeInterval totalBuffer = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval duration = CMTimeGetSeconds(playerItem.duration);
        CGFloat loadProgress = totalBuffer/duration;
        //加载进度
        if ([self.delegate respondsToSelector:@selector(updateLoadProgress:duration:totalTime:)]) {
            [self.delegate updateLoadProgress:loadProgress duration:duration totalTime:[self changeStringForTime:duration]];
        }
        
    }else{
        
    }
}


- (void)play
{
    [self.musicPlayer play];
}
- (void)pause
{
    [self.musicPlayer pause];
}

- (void)playPrevious
{
    if (_currentIndex == 0) {
        _currentIndex = _musicArray.count - 1;
    }else{
        _currentIndex = _currentIndex -1;
    }
    
    MusicListModel *model = _musicArray[_currentIndex];
    [self startPlayWithUrl:[NSURL URLWithString:model.audioUrl]];

}
- (void)playNext
{
    if (_currentIndex == _musicArray.count-1) {
        _currentIndex = 0;
    }else{
        _currentIndex = _currentIndex + 1;
    }
    
    MusicListModel *model = _musicArray[_currentIndex];
    [self startPlayWithUrl:[NSURL URLWithString:model.audioUrl]];
}

- (NSString *)playingName
{
    if (_musicArray.count) {
        MusicListModel *model = _musicArray[_currentIndex];
        return model.audioName;
    }
    return @"";
}

- (NSString *)musciLrc
{
    if (_musicArray.count) {
        MusicListModel *model = _musicArray[_currentIndex];
        return model.audioLyric;
    }
    return @"暂无歌词";
}

- (void)removeObservers
{
    [self.musicPlayer.currentItem removeObserver:self  forKeyPath:@"status"];
    [self.musicPlayer.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [self.musicPlayer removeTimeObserver:self.timeObserver];
    
}

- (NSString *)changeStringForTime:(NSInteger)timeInterval
{
    NSString *minutes = @"00";
    NSInteger minute = timeInterval/60;
    if (minute < 10) {
        minutes = [NSString stringWithFormat:@"0%ld",minute];
    }else{
        minutes = [NSString stringWithFormat:@"%ld",minute];
    }
    
    NSString *secondStr = @"00";
    NSInteger seconds = timeInterval%60;
    if (seconds < 10) {
        secondStr = [NSString stringWithFormat:@"0%ld",seconds];
    }else{
        secondStr = [NSString stringWithFormat:@"%ld",seconds];
    }
    return [NSString stringWithFormat:@"%@:%@",minutes,secondStr];
}

@end

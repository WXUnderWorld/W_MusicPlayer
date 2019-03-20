//
//  MusicManager.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/12.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MusicManagerDelegate <NSObject>

//更新播放进度、播放时间
- (void)updateProgress:(CGFloat)progress
           currentTime:(NSTimeInterval)currentTime
             startTime:(NSString *)startTime;

//更新加载进度、结束时间
- (void)updateLoadProgress:(CGFloat)progress
                  duration:(NSTimeInterval)duration
                 totalTime:(NSString *)totalTime;

//是否正在播放状态
- (void)playerPlayingState:(BOOL)state;

//播放完成后
- (void)playerPlayFinished;

//当前播放的资源
- (void)playerCurrentPlayData:(id)musicData;

@end







@interface MusicManager : NSObject
//播放器
@property (nonatomic,strong) AVPlayer *musicPlayer;
//播放时间频率
@property (nonatomic,strong) id timeObserver;
@property (nonatomic,weak) id <MusicManagerDelegate> delegate;
//拖动进度条
@property (nonatomic,assign) CGFloat sliderValue;
//播放歌曲数组
@property (nonatomic,strong) NSArray *musicArray;
//当前播放下标
@property (nonatomic,assign) NSInteger currentIndex;
//当前播放的歌曲详情
@property (nonatomic,strong) id currentPlayData;
//当前播放歌曲的进度
@property (nonatomic,assign) CGFloat playProgress;
//当前歌曲播放时间
@property (nonatomic,strong) NSString *startTime;
//当前播放时间进度
@property (nonatomic,assign) CGFloat currentPlayTime;
//当前播放歌曲的加载进度
@property (nonatomic,assign) CGFloat loadProgress;
//当前歌曲结束时间
@property (nonatomic,strong) NSString *endTime;
//时长
@property (nonatomic,assign) CGFloat musicDuration;

@property (nonatomic,assign) BOOL isPause;

+ (instancetype)shareManager;
- (void)startPlayWithUrl:(NSURL *)url;
- (void)pause;
- (void)play;
- (void)playPrevious;
- (void)playNext;

@end

NS_ASSUME_NONNULL_END

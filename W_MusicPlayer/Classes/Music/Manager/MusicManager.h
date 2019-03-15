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

//更新加载进度
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

@property (nonatomic,strong) AVPlayer *musicPlayer;
@property (nonatomic,strong) id timeObserver;
@property (nonatomic,weak) id <MusicManagerDelegate> delegate;
@property (nonatomic,assign) CGFloat sliderValue;
@property (nonatomic,strong) NSArray *musicArray;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSString *playingName;
@property (nonatomic,strong) NSString *musciLrc;

+ (instancetype)shareManager;
- (void)startPlayWithUrl:(NSURL *)url;
- (void)pause;
- (void)play;
- (void)playPrevious;
- (void)playNext;

@end

NS_ASSUME_NONNULL_END

//
//  PlayerBackgroundView.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/12.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerSliderDelegate <NSObject>

- (void)changeSliderValue:(CGFloat)value;

- (void)playOrPause:(BOOL)play;

- (void)playNext;

- (void)playPrevious;

@end

@interface PlayerBackgroundView : UIView

@property (nonatomic,weak) id <PlayerSliderDelegate> delegate;

@property (nonatomic,strong) UIButton *playerBtn;
@property (nonatomic,assign) CGFloat loadProgress;
@property (nonatomic,assign) CGFloat playProgress;
@property (nonatomic,strong) UILabel *startTime;
@property (nonatomic,strong) UILabel *endTime;
//专辑图片
@property (nonatomic,strong) NSString *musicImageUrl;
//播放、暂停
@property (nonatomic,assign) BOOL isPlaying;
//歌词数据
@property (nonatomic,strong) NSArray *musicLrcArray;

@property (nonatomic,assign) NSTimeInterval currentPlayTime;
@property (nonatomic,assign) NSTimeInterval playerDuration;



//重置进度条
- (void)resetProgress;

@end

NS_ASSUME_NONNULL_END

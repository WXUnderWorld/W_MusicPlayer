//
//  PlayerBackgroundView.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/12.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PlayerMaxViewDelegate <NSObject>

- (void)changeSliderValue:(CGFloat)value;

- (void)playOrPause:(BOOL)play;

- (void)playNext;

- (void)playPrevious;

- (void)dissmiss;

@end

@interface PlayerMaxView : UIView

@property (nonatomic,weak) id <PlayerMaxViewDelegate> delegate;

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIButton *playerBtn;
@property (nonatomic,assign) CGFloat loadProgress;
@property (nonatomic,assign) CGFloat playProgress;
@property (nonatomic,strong) UILabel *startTime;
@property (nonatomic,strong) UILabel *endTime;
@property (nonatomic,strong) NSString *musicImageUrl;
@property (nonatomic,assign) BOOL isPlaying;
@property (nonatomic,strong) NSArray *musicLrcArray;
@property (nonatomic,assign) NSTimeInterval currentPlayTime;
@property (nonatomic,assign) NSTimeInterval playerDuration;

//重置进度条
- (void)resetProgress;

@end

NS_ASSUME_NONNULL_END

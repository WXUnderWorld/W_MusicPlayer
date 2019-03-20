//
//  MusicPlayerViewController.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/11.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "MusicManager.h"
#import "PlayerMaxView.h"
#import "MusicLrcModel.h"

@interface MusicPlayerViewController ()<MusicManagerDelegate,PlayerMaxViewDelegate>

@property (nonatomic,strong) PlayerMaxView *maxView;

@end

@implementation MusicPlayerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _maxView = [[PlayerMaxView alloc] initWithFrame:self.view.bounds];
    _maxView.delegate = self;
    [self.view addSubview:_maxView];
    
    MusicManager *playerManager = [MusicManager shareManager];
    playerManager.delegate = self;
    playerManager.musicArray = _listArray;
    if (playerManager.currentIndex != _currentIndex) {
        playerManager.currentIndex = _currentIndex;
        NSString *aduioUrl = [self.listModel.audioUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [playerManager startPlayWithUrl:[NSURL URLWithString:aduioUrl]];
    }else{
        //如果是当前播放歌曲
        [self playerCurrentPlayData:playerManager.currentPlayData];
        [self updateLoadProgress:playerManager.loadProgress duration:playerManager.musicDuration totalTime:playerManager.endTime];
        [self updateProgress:playerManager.playProgress currentTime:playerManager.currentPlayTime startTime:playerManager.startTime];
        [self playerPlayingState:playerManager.isPause];
    }
}

#pragma mark---- MusicManagerDelegate
//播放进度
- (void)updateProgress:(CGFloat)progress
           currentTime:(NSTimeInterval)currentTime
             startTime:(NSString *)startTime
{
    _maxView.playProgress = progress;
    _maxView.startTime.text = startTime;
    _maxView.currentPlayTime = currentTime;
}
//加载进度
- (void)updateLoadProgress:(CGFloat)progress
                  duration:(NSTimeInterval)duration
                 totalTime:(NSString *)totalTime
{
    _maxView.loadProgress = progress;
    _maxView.endTime.text = totalTime;
    _maxView.playerDuration = duration;
}

//当前播放的资源信息
- (void)playerCurrentPlayData:(id)musicData
{
    MusicListModel *model = musicData;
    _maxView.titleLab.text = model.audioName;
    _maxView.musicImageUrl = model.audioImage;
    _maxView.musicLrcArray = [MusicLrcModel musicLrcListWithFileName:model.audioLyric];
}


//是否正在播放
- (void)playerPlayingState:(BOOL)state{
    _maxView.isPlaying = state;
}

//播放完成
- (void)playerPlayFinished{
    [_maxView resetProgress];
}










#pragma mark---- PlayerMaxViewDelegate
- (void)changeSliderValue:(CGFloat)value
{
    [MusicManager shareManager].sliderValue = value;
}

- (void)playOrPause:(BOOL)play
{
    if (play) {
        [[MusicManager shareManager] play];
    }else{
        [[MusicManager shareManager] pause];
    }
}

- (void)playNext
{
    [[MusicManager shareManager] playNext];
}

- (void)playPrevious
{
    [[MusicManager shareManager] playPrevious];
}

- (void)dissmiss
{
    [self dismissViewControllerAnimated:YES completion:^{}];
    if (self.getCurrentPlayDataBlock) {
        self.getCurrentPlayDataBlock();
    }
}



@end

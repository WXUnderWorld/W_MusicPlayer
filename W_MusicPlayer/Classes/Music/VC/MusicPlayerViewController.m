//
//  MusicPlayerViewController.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/11.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "MusicManager.h"
#import "PlayerBackgroundView.h"
#import "MusicLrcModel.h"
@interface MusicPlayerViewController ()<MusicManagerDelegate,PlayerSliderDelegate>

@property (nonatomic,strong) PlayerBackgroundView *groundView;

@end

@implementation MusicPlayerViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    _groundView = [[PlayerBackgroundView alloc] initWithFrame:self.view.bounds];
    _groundView.delegate = self;
    [self.view addSubview:_groundView];
    
    [MusicManager shareManager].delegate = self;
    [MusicManager shareManager].musicArray = _listArray;
    [MusicManager shareManager].currentIndex = _currentIndex;
    
    NSString *aduioUrl = [self.listModel.audioUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[MusicManager shareManager] startPlayWithUrl:[NSURL URLWithString:aduioUrl]];
    
}

#pragma mark---- MusicManagerDelegate
//播放进度
- (void)updateProgress:(CGFloat)progress currentTime:(NSTimeInterval)currentTime startTime:(NSString *)startTime
{
    _groundView.playProgress = progress;
    _groundView.startTime.text = startTime;
    _groundView.currentPlayTime = currentTime;
}
//加载进度
- (void)updateLoadProgress:(CGFloat)progress duration:(NSTimeInterval)duration totalTime:(NSString *)totalTime
{
    _groundView.loadProgress = progress;
    _groundView.endTime.text = totalTime;
    _groundView.playerDuration = duration;
}

//是否正在播放
- (void)playerPlayingState:(BOOL)state
{
    _groundView.isPlaying = state;
}

//播放完成
- (void)playerPlayFinished
{
    [_groundView resetProgress];
}

//当前播放的资源信息
- (void)playerCurrentPlayData:(id)musicData
{
    MusicListModel *model = musicData;
    self.title = model.audioName;
    _groundView.musicImageUrl = model.audioImage;
    _groundView.musicLrcArray = [MusicLrcModel musicLrcListWithFileName:model.audioLyric];
}



#pragma mark---- PlayerSliderDelegate
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




@end

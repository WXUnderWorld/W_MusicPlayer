//
//  PlayerBackgroundView.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/12.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "PlayerMaxView.h"
#import "PlayScrollView.h"
#import "ShakeView.h"

@interface PlayerMaxView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIImageView *bgImgView;
@property (nonatomic,strong) UISlider *playSlider;//播放进度
@property (nonatomic,strong) PlayScrollView *scrollView;
@property (nonatomic,strong) UISlider *loadSlider;//加载进度
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) ShakeView *shakeView;


@end


@implementation PlayerMaxView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgImgView];
        [self addSubview:self.titleLab];
        [self setupUI];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        [self addSubview:self.backBtn];
        [self addSubview:self.shakeView];
    }
    return self;
}

- (void)setupUI{
    
    _playerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playerBtn.frame = CGRectMake(ScreenW/2-30, self.bounds.size.height - 120, 60, 60);
    [_playerBtn setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateSelected];
    [_playerBtn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    [self addSubview:_playerBtn];
    [_playerBtn addTarget:self action:@selector(playOrPauseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *lastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lastBtn.frame = CGRectMake(ScreenW/4-25, _playerBtn.frame.origin.y + 5, 50, 50);
    [lastBtn setImage:[UIImage imageNamed:@"shangyishou"] forState:UIControlStateNormal];
    [self addSubview:lastBtn];
    [lastBtn addTarget:self action:@selector(playLast:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(ScreenW/4 *3 -25, _playerBtn.frame.origin.y + 5, 50, 50);
    [nextBtn setImage:[UIImage imageNamed:@"xiayishou"] forState:UIControlStateNormal];
    [self addSubview:nextBtn];
    [nextBtn addTarget:self action:@selector(playNext:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //加载进度
    _loadSlider = [[UISlider alloc] initWithFrame:CGRectMake(60, self.bounds.size.height - 160, ScreenW - 120, 20)];
    _loadSlider.minimumValue = 0;
    _loadSlider.maximumValue = 1.0;
    _loadSlider.minimumTrackTintColor = [UIColor whiteColor];
    _loadSlider.maximumTrackTintColor = [UIColor lightGrayColor];
    _loadSlider.thumbTintColor = [UIColor clearColor];
    [self addSubview:_loadSlider];
    
//    播放进度
    _playSlider = [[UISlider alloc] initWithFrame:CGRectMake(60, self.bounds.size.height - 160, ScreenW - 120, 20)];
    _playSlider.minimumValue = 0;
    _playSlider.maximumValue = 1.0;
    _playSlider.minimumTrackTintColor = [UIColor greenColor];
    _playSlider.maximumTrackTintColor = [UIColor clearColor];
    [_playSlider setThumbImage:[UIImage imageNamed:@"sliderImg"] forState:UIControlStateNormal];
    [_playSlider addTarget:self action:@selector(sliderChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_playSlider];
    

    _startTime = [[UILabel alloc] init];
    _startTime.bounds = CGRectMake(0, 0, 60, 25);
    _startTime.center = CGPointMake(30, _playSlider.center.y);
    _startTime.text = @"00:00";
    _startTime.textColor = [UIColor groupTableViewBackgroundColor];
    _startTime.font = [UIFont systemFontOfSize:13];
    _startTime.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_startTime];
    
    _endTime = [[UILabel alloc] init];
    _endTime.bounds = CGRectMake(0, 0, 60, 25);
    _endTime.center = CGPointMake(ScreenW-30, _playSlider.center.y);
    _endTime.text = @"00:00";
    _endTime.textColor = [UIColor groupTableViewBackgroundColor];
    _endTime.font = [UIFont systemFontOfSize:13];
    _endTime.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_endTime];
    
}






//拖拽进度条
- (void)sliderChange:(UISlider *)slider
{
    _playSlider.value = slider.value;
    if ([self.delegate respondsToSelector:@selector(changeSliderValue:)]) {
        [self.delegate changeSliderValue:slider.value];
    }
}


//暂停、播放
- (void)playOrPauseAction:(UIButton *)btn
{
    if ([_startTime.text isEqualToString:@"00:00"]) {
        return;
    }
    btn.selected = !btn.selected;
    if ([self.delegate respondsToSelector:@selector(playOrPause:)]) {
        [self.delegate playOrPause:btn.selected];
    }
    
    if (btn.selected) {
        [_scrollView continueAnimation];
        [_shakeView continueAnimation];
    }else{
        [_scrollView pauseAnimation];
        [_shakeView pauseAnimation];
    }
    
}

//播放上一首
- (void)playLast:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(playPrevious)]) {
        [self.delegate playPrevious];
    }
    [self resetProgress];
}

//播放下一首
- (void)playNext:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(playNext)]) {
        [self.delegate playNext];
    }
    [self resetProgress];
}


- (void)resetProgress
{
    self.playProgress = 0;
    self.loadProgress = 0;
    self.startTime.text = @"00:00";
    self.endTime.text = @"00:00";
}



//播放进度条
- (void)setPlayProgress:(CGFloat)playProgress
{
    _playProgress = playProgress;
    [_playSlider setValue:_playProgress animated:YES];
}

//加载进度条
- (void)setLoadProgress:(CGFloat)loadProgress
{
    _loadProgress = loadProgress;
    if (_loadProgress >= 0.999){
        _playSlider.maximumTrackTintColor = [UIColor whiteColor];
        _loadProgress = 0;
    }else{
        _playSlider.maximumTrackTintColor = [UIColor clearColor];
    }
    [_loadSlider setValue:_loadProgress animated:YES];
}

//设置专辑图片
- (void)setMusicImageUrl:(NSString *)musicImageUrl
{
    _musicImageUrl = musicImageUrl;
    _scrollView.imageUrl = _musicImageUrl;
}

//歌词数组
- (void)setMusicLrcArray:(NSArray *)musicLrcArray
{
    _musicLrcArray = musicLrcArray;
    _scrollView.lrcDataList = musicLrcArray;
}


//播放状态
- (void)setIsPlaying:(BOOL)isPlaying
{
    _isPlaying = isPlaying;
    self.playerBtn.selected = isPlaying;
    
}


//当前播放的时间点
- (void)setCurrentPlayTime:(NSTimeInterval)currentPlayTime{
    _currentPlayTime = currentPlayTime;
    _scrollView.currentPlayTime = currentPlayTime;
}

//歌曲时长
- (void)setPlayerDuration:(NSTimeInterval)playerDuration{
    _playerDuration = playerDuration;
    _scrollView.playerDuration = playerDuration;
}


- (void)dismissAction
{
    if ([self.delegate respondsToSelector:@selector(dissmiss)]) {
        [self.delegate dissmiss];
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int x = scrollView.contentOffset.x/ScreenW;
    self.pageControl.currentPage = x;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[PlayScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, _playSlider.frame.origin.y - 60)];
        _scrollView.contentSize = CGSizeMake(ScreenW *2, 0);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.center = CGPointMake(ScreenW/2, _playSlider.frame.origin.y - 50);
        _pageControl.bounds = CGRectMake(0, 0, 100, 20);
        _pageControl.numberOfPages = 2;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(15, 20, 44, 44);
        [backBtn setImage:[UIImage imageNamed:@"jiantou_xia"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
        _backBtn = backBtn;
    }
    return _backBtn;
}

- (UIImageView *)bgImgView
{
    if (!_bgImgView) {
        UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgImgView.userInteractionEnabled = YES;
        bgImgView.image = [UIImage imageNamed:@"bgplay.jpg"];
        _bgImgView = bgImgView;
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithFrame:bgImgView.bounds];
        effectView.effect = blur;
        effectView.alpha = 0.9;
        [bgImgView addSubview:effectView];
    }
    return _bgImgView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.frame = CGRectMake(80, 20, ScreenW-160, 44);
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont boldSystemFontOfSize:17];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}


- (ShakeView *)shakeView
{
    if (!_shakeView) {
        _shakeView = [[ShakeView alloc] initWithFrame:CGRectMake(ScreenW-60, 20, 60, 44)];
    }
    return _shakeView;
}

@end

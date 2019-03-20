//
//  PlayerMinView.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/18.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "PlayerMinView.h"
#import "ShakeView.h"
#import "AnimationManager.h"

@interface PlayerMinView ()

@property (nonatomic,strong) ShakeView *shakeView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *playBtn;
@property (nonatomic,strong) UILabel *playName;

@end

@implementation PlayerMinView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.shakeView];
        [self addSubview:self.playBtn];
        [self addSubview:self.imageView];
        [self addSubview:self.playName];
    }
    return self;
}



- (void)setImgUrl:(NSString *)imgUrl
{
    _imgUrl = imgUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    [AnimationManager startAnimation:self.imageView.layer];
}

- (void)setPlayMusicName:(NSString *)playMusicName
{
    _playMusicName = playMusicName;
    self.playName.text = playMusicName;
}

- (ShakeView *)shakeView
{
    if (!_shakeView) {
        _shakeView = [[ShakeView alloc] initWithFrame:CGRectMake(self.bounds.size.width-50, 0, 40, self.bounds.size.height)];
        _shakeView.layerColor = [UIColor lightGrayColor];
    }
    return _shakeView;
}

- (UIButton *)playBtn
{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.frame = CGRectMake(self.bounds.size.width - 90, 9, 32, 32);
        [_playBtn setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateSelected];
    }
    return _playBtn;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(10, 5, 40, 40);
        _imageView.userInteractionEnabled = YES;
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 20;
        _imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _imageView;
}

- (UILabel *)playName
{
    if (!_playName) {
        _playName = [[UILabel alloc] initWithFrame:CGRectMake(60, 0,  self.playBtn.frame.origin.x - 80, self.bounds.size.height)];
        _playName.font = [UIFont systemFontOfSize:14];
        _playName.textColor = [UIColor blackColor];
    }
    return _playName;
}

@end

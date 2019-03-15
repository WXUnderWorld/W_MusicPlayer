//
//  PlayScrollView.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/14.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface PlayScrollView : UIScrollView


@property (nonatomic,strong) NSString *imageUrl;
//歌词数组
@property (nonatomic,strong) NSArray *lrcDataList;
@property (nonatomic,assign) NSTimeInterval currentPlayTime;
@property (nonatomic,assign) NSTimeInterval playerDuration;


- (void)startAnimation;
- (void)continueAnimation;
- (void)pauseAnimation;

@end

NS_ASSUME_NONNULL_END

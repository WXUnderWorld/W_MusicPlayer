//
//  ShakeView.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/19.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShakeView : UIView

@property (nonatomic,strong) UIColor *layerColor;

- (void)startAnimation;
- (void)continueAnimation;
- (void)pauseAnimation;

@end

NS_ASSUME_NONNULL_END

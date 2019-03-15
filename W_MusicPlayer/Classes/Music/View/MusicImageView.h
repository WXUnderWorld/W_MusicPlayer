//
//  MusicImageView.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/13.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicImageView : UIView

@property (nonatomic,strong) NSString *imageUrl;

- (void)startAnimation;
- (void)continueAnimation;
- (void)pauseAnimation;
@end


NS_ASSUME_NONNULL_END

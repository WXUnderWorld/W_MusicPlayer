//
//  AnimationManager.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/19.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface AnimationManager : NSObject

+ (void)startAnimation:(CALayer *)layer;
+ (void)pauseAnimation:(CALayer *)layer;
+ (void)continueAnimation:(CALayer *)layer;

@end

NS_ASSUME_NONNULL_END

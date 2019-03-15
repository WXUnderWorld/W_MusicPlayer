//
//  LrcView.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/14.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicLrcModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LrcView : UIView

@property (nonatomic,strong) NSArray<MusicLrcModel *> *lrcArray;

@property (nonatomic,assign) NSTimeInterval currentPlayTime;
@property (nonatomic,assign) NSTimeInterval playerDuration;

@end

NS_ASSUME_NONNULL_END

//
//  MusicPlayerViewController.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/11.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MusicPlayerViewController : UIViewController

@property (nonatomic,strong) MusicListModel *listModel;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSArray<MusicListModel *> *listArray;

@property (nonatomic,copy) void(^getCurrentPlayDataBlock)(void);

@end

NS_ASSUME_NONNULL_END

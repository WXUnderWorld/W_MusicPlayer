//
//  MusicLrcModel.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/14.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicLrcModel : NSObject

@property (nonatomic,assign) NSTimeInterval time;

@property (nonatomic,copy) NSString *lrcText;

+ (NSArray <MusicLrcModel *>*)musicLrcListWithFileName:(NSString *)fileName;


@end

NS_ASSUME_NONNULL_END

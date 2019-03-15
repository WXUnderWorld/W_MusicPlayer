//
//  MusicListModel.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/11.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicListModel : NSObject

/**音频地址*/
@property (nonatomic, copy) NSString    *audioUrl;

/**音频名*/
@property (nonatomic, copy) NSString    *audioName;

/**歌手名*/
@property (nonatomic, copy) NSString    *audioSinger;

/**专辑名*/
@property (nonatomic, copy) NSString    *audioAlbum;

/**专辑图片*/
@property (nonatomic, copy) NSString    *audioImage;

/**歌词*/
@property (nonatomic, copy) NSString    *audioLyric;

@end

NS_ASSUME_NONNULL_END

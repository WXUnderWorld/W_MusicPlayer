//
//  LrcTableViewCell.h
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/14.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicLrcLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LrcTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet MusicLrcLabel *lrcLabel;

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView;

@property (nonatomic,assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END

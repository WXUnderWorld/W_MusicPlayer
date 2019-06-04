//
//  LrcTableViewCell.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/14.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "LrcTableViewCell.h"

@implementation LrcTableViewCell

+ (instancetype)lrcCellWithTableView:(UITableView *)tableView
{
    NSString *className = NSStringFromClass([self class]);
    LrcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:className];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:className owner:self options:nil] firstObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = 0;
    }
    return cell;
}


- (void)setIsSelected:(BOOL)isSelected
{
    if (isSelected) {
         _lrcLabel.font = [UIFont systemFontOfSize:18];
    }else{
        _lrcLabel.font = [UIFont systemFontOfSize:15];
        _lrcLabel.progress = 0;
    }
}

@end

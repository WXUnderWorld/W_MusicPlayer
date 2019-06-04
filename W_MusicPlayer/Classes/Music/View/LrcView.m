//
//  LrcView.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/14.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "LrcView.h"
#import "LrcTableViewCell.h"
@interface LrcView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *lrcTableView;
@property (nonatomic,assign) NSInteger currentIndex;

@end

#define CellHeight 30

@implementation LrcView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.lrcTableView];
        self.currentIndex = 0;
    }
    return self;
}


- (UITableView *)lrcTableView
{
    if (!_lrcTableView) {
        _lrcTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _lrcTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _lrcTableView.delegate = self;
        _lrcTableView.dataSource = self;
        _lrcTableView.backgroundColor = [UIColor clearColor];
        _lrcTableView.contentInset = UIEdgeInsetsMake(self.bounds.size.height/2-CellHeight/2, 0, 0, 0);
    }
    return _lrcTableView;
}



- (void)setLrcArray:(NSArray<MusicLrcModel *> *)lrcArray
{
    _lrcArray = lrcArray;
    [self.lrcTableView reloadData];
    if (_lrcArray.count) {
        [self.lrcTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _lrcArray.count?_lrcArray.count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LrcTableViewCell *cell = [LrcTableViewCell lrcCellWithTableView:tableView];
    if (_lrcArray.count) {
        MusicLrcModel *model = self.lrcArray[indexPath.row];
        cell.lrcLabel.text = model.lrcText;
        if (indexPath.row == self.currentIndex) {
            cell.isSelected = YES;
        }else{
            cell.isSelected = NO;
        }
    }else{
        cell.lrcLabel.text = @"暂无歌词";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}


- (void)setCurrentPlayTime:(NSTimeInterval)currentPlayTime
{
    [self updateMusicLrcForRowAtCurrentTime:currentPlayTime];
}

- (void)setPlayerDuration:(NSTimeInterval)playerDuration
{
    _playerDuration = playerDuration;
}

//动态更新歌词
- (void)updateMusicLrcForRowAtCurrentTime:(NSTimeInterval)currentTime
{
    for (NSInteger i=0; i< _lrcArray.count; i++) {
        MusicLrcModel *model = _lrcArray[i];
       
        NSInteger next = i+1;
        MusicLrcModel *nextLrcModel = nil;
        if (next < _lrcArray.count) {
            nextLrcModel = _lrcArray[next];
        }
        
        if (self.currentIndex != i && currentTime >= model.time)
        {
            BOOL show = NO;
            if (nextLrcModel) {
                if (currentTime < nextLrcModel.time) {
                    show = YES;
                }
            }else{
                show = YES;
            }
            
            if (show) {
                NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
                
                self.currentIndex = i;
                
                LrcTableViewCell *currentCell = [self.lrcTableView cellForRowAtIndexPath:currentIndexPath];
                LrcTableViewCell *previousCell = [self.lrcTableView cellForRowAtIndexPath:previousIndexPath];
                
                //设置当前行的状态
                currentCell.isSelected = YES;
                //取消上一行的选中状态
                previousCell.isSelected = NO;

                [self.lrcTableView scrollToRowAtIndexPath:currentIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
             
            }
        }
        
        
        if (self.currentIndex == i) {
            LrcTableViewCell *cell = [self.lrcTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            CGFloat totalTime = 0;
            if (nextLrcModel) {
                totalTime = nextLrcModel.time - model.time;
            }else{
                //最后一句
                totalTime =  _playerDuration - model.time;
            }
            CGFloat progressTime = currentTime - model.time;
            cell.lrcLabel.progress = progressTime / totalTime;
        }
        
    }
}

@end

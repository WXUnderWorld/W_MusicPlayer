//
//  MusicViewController.m
//  W_MusicPlayer
//
//  Created by wangxiaolei on 2019/3/11.
//  Copyright © 2019年 wxl. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicPlayerViewController.h"
#import "MusicListModel.h"
#import "MusicManager.h"
#import "PlayerMinView.h"

@interface MusicViewController ()<UITableViewDelegate,UITableViewDataSource,MusicManagerDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) PlayerMinView *minView;

@end




@implementation MusicViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [MusicManager shareManager].delegate = self;
    _currentIndex = [MusicManager shareManager].currentIndex;
    [_tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"音乐";
    _currentIndex = -1;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-50) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self.view addSubview:self.minView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellid];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    MusicListModel *model = self.listArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row,model.audioName];
    if (indexPath.row == _currentIndex) {
        cell.detailTextLabel.text = @"正在播放";
    }else{
        cell.detailTextLabel.text = @"";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _currentIndex = indexPath.row;
    MusicPlayerViewController *playerVC = [[MusicPlayerViewController alloc] init];
    playerVC.listModel = self.listArray[indexPath.row];
    playerVC.listArray = self.listArray;
    playerVC.currentIndex = indexPath.row;
    [self presentViewController:playerVC animated:YES completion:^{
        [tableView reloadData];
    }];
    playerVC.getCurrentPlayDataBlock = ^{
        MusicListModel *model = [MusicManager shareManager].currentPlayData;
        self.minView.playMusicName = model.audioName;
        self.minView.imgUrl = model.audioImage;
    };
    
}


- (NSMutableArray *)listArray
{
    if (!_listArray) {
        _listArray = [NSMutableArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AudioData" ofType:@".plist"];
        NSMutableArray *arr = [[NSMutableArray alloc] initWithContentsOfFile:path];
        for (int i = 0; i < arr.count; i++) {
            MusicListModel *model = [[MusicListModel alloc] init];
            [model setValuesForKeysWithDictionary:arr[i]];
            [_listArray addObject:model];
        }
    }
    
    return _listArray;
}

- (PlayerMinView *)minView
{
    if (!_minView) {
        _minView = [[PlayerMinView alloc] initWithFrame:CGRectMake(0, ScreenH-50, ScreenW, 50)];
    }
    return _minView;
}

- (void)playerCurrentPlayData:(id)musicData
{
    NSLog(@"切换完成");
    _currentIndex = [MusicManager shareManager].currentIndex;
    [_tableView reloadData];
}



@end

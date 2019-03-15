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


@interface MusicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *listArray;
@end




@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
   
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    MusicListModel *model = self.listArray[indexPath.row];
    cell.textLabel.text = model.audioName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicPlayerViewController *playerVC = [[MusicPlayerViewController alloc] init];
    playerVC.listModel = self.listArray[indexPath.row];
    playerVC.listArray = self.listArray;
    playerVC.currentIndex = indexPath.row;
    playerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playerVC animated:YES];
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


@end

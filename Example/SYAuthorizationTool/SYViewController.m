//
//  ViewController.m
//  SYAuthorizationTool
//
//  Created by YIXUN on 2018/4/11.
//  Copyright © 2018年 shenyuan. All rights reserved.
//

#import "SYViewController.h"
#import "SYAuthorizationManager.h"

static NSString *const kCellId = @"cellId";
@interface SYViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation SYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}
- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"权限列表";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellId];
    }
    NSString *msg = [@(indexPath.row + 1).stringValue stringByAppendingString:@"、"];
    cell.textLabel.text = [msg stringByAppendingString:self.dataArray[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [SYAuthorizationManager requestAccessType:SYAuthorizationType_LocationSercices accessStatus:^(BOOL isAccces, BOOL isFirst) {
                [self handCompletionWithGranted:isAccces firstTime:isFirst];
            }];
        }
            break;
        case 1:{
            [SYAuthorizationManager requestAccessType:SYAuthorizationType_Contacts accessStatus:^(BOOL isAccces, BOOL isFirst) {
                [self handCompletionWithGranted:isAccces firstTime:isFirst];
            }];
        }
            break;
        case 2:{
            [SYAuthorizationManager requestAccessType:SYAuthorizationType_Photos accessStatus:^(BOOL isAccces, BOOL isFirst) {
                [self handCompletionWithGranted:isAccces firstTime:isFirst];
            }];
        }
            
            break;
        case 3:{
            [SYAuthorizationManager requestAccessType:SYAuthorizationType_Camera accessStatus:^(BOOL isAccces, BOOL isFirst) {
                [self handCompletionWithGranted:isAccces firstTime:isFirst];
            }];
        }
            
            break;
            
        default:
            break;
    }
}

- (void)handCompletionWithGranted:(BOOL)access firstTime:(BOOL)firstTime
{
    //没有权限，且不是第一次获取权限
    if ( !access && !firstTime )
    {
        [SYAuthorizationAlert showAlertToDislayPrivacySettingWithTitle:@"提示" msg:@"没有 xxx 权限，是否前往设置" cancel:@"取消" setting:@"设置"];
    }
    NSLog(@"success");
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.tableView.tableFooterView = [UIView new];
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[@"定位", @"通讯录",
                       @"照片", @"相机",
                       ];
    }
    return _dataArray;
}


@end


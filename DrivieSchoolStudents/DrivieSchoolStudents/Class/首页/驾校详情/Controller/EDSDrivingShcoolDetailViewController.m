//
//  EDSDrivingShcoolDetailViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDrivingShcoolDetailViewController.h"

@interface EDSDrivingShcoolDetailViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIView *subViews;

@property (nonatomic, strong) UITableView  *tableView;
@end

@implementation EDSDrivingShcoolDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollViewHeight.constant = 139 - 45 - 64 +  kScreenHeight;
    
    self.view4.alpha = 0.0;
    self.view1.alpha = 1.0;
    
    self.scrollView.delegate = self;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.subViews addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"UITableViewCell";
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行",(long)indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.view4.alpha = scrollView.contentOffset.y/45.0;
    self.view1.alpha = 1 - scrollView.contentOffset.y/94.0;
    
    CGFloat placeHolderHeight = 194 - 100;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= 0 && offsetY <= placeHolderHeight) {
        self.topView.wz_y = -offsetY;
    }
    else if (offsetY > placeHolderHeight) {
        self.topView.wz_y = - placeHolderHeight;
    }
    else if (offsetY <0) {
        self.topView.wz_y =  - offsetY;
    }
    
    
}

@end

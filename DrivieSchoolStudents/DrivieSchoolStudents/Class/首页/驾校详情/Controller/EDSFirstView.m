//
//  EDSFirstView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSFirstView.h"
#import "EDSEDSDrivingDetailsHeaderView.h"
#import "EDSFirstTableViewCell.h"

@interface EDSFirstView ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (nonatomic, strong) UITableView  *tableView;
@end

@implementation EDSFirstView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup{
    
    self.backgroundColor = WhiteColor;
    
    self.tableView.bounces = NO;
    self.tableView = [[UITableView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorColor = ClearColor;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)setAppContent:(NSString *)appContent
{
    _appContent = appContent;
    [self.tableView reloadData];
}

#pragma mark ------------------------ tableView --------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.确定重用标示:
    static NSString *ID = @"EDSFirstTableViewCell";
    // 2.从缓存池中取
    EDSFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[EDSFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.contentView.backgroundColor = [EDSToolClass getColorWithHexString:@"f5f5f5"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 10;
    if (self.appContent == nil) {
        
    }else{
       cell.descripLbl.attributedText = [[NSAttributedString alloc]initWithString:self.appContent attributes:@{NSParagraphStyleAttributeName: style}];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

//#pragma mark - firstTableView的代理方法scrollViewDidScroll
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGFloat placeHolderHeight = self.topView.wz_height - self.topView.itemHeight;
//    
//    CGFloat offsetY = scrollView.contentOffset.y;
//    
//    if (offsetY >= 0 && offsetY <= placeHolderHeight) {
//        
//        self.topView.wz_y = -offsetY;
//        self.topView.commentBgView.alpha = offsetY/placeHolderHeight;
//        self.topView.driveSchoolBgView.alpha = 1 - offsetY/placeHolderHeight;
//    }
//    else if (offsetY > placeHolderHeight) {
//        self.topView.wz_y = - placeHolderHeight;
//        self.topView.commentBgView.alpha = 1.0;
//        self.topView.driveSchoolBgView.alpha = 0.0;
//    }
//    else if (offsetY <0) {
//        self.topView.wz_y =  - offsetY;
//        self.topView.commentBgView.alpha = 0.0;
//        self.topView.driveSchoolBgView.alpha = 1.0;
//    }
//}

@end

//
//  EDSSecondView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSecondView.h"
#import "HomeConstants.h"
#import "EDSElegantDemeanourViewController.h"

#import "EDSTeachingStyleCollectionViewCell.h"//教学风采cell
#import "EDSEDSDrivingDetailsHeaderView.h"
#import "UICollectionViewLeftAlignedLayout.h"

#import "EDSSchoolStyleRequest.h"

#import "EDSSchoolStyleModel.h"

@interface EDSSecondView ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** collectionView */
@property (nonatomic, strong) UICollectionView  *collectionView;
/** 数据 */
@property (nonatomic, strong) NSArray<EDSSchoolStyleModel *> *modelArr;

@property (nonatomic, assign) NSInteger page;

@end

@implementation EDSSecondView

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
    self.modelArr = [[NSArray alloc] init];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.bounces = YES;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData2)];
    
    
}

#pragma mark ------------------------ 网络请求 --------------------------------
- (void)requestData
{
    self.page = 1;
    @weakify(self);
    EDSSchoolStyleRequest *request = [EDSSchoolStyleRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        if (errCode == 1) {
            
            self.modelArr = model;
            [self.collectionView reloadData];
            
        }
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer resetNoMoreData];
    } failureBlock:^(NSError *error) {
         [self.collectionView.mj_header endRefreshing];
        
    }];
    request.schoolId = self.schoolId;
    request.page = self.page;
    request.phone = [EDSToolClass isBlankString:[EDSSave account].phone] ? @"" : [EDSSave account].phone;
    [request  startRequest];
}

- (void)requestData2
{
    self.page++;
    @weakify(self);
    EDSSchoolStyleRequest *request = [EDSSchoolStyleRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, NSArray* model) {
        @strongify(self);
        NSMutableArray *data = [self.modelArr mutableCopy];
        if (errCode == 1) {
            if (model.count > 0) {
                [data addObjectsFromArray:model];
                [self.collectionView.mj_footer endRefreshing];
            }else{
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            self.modelArr = data;
            [self.collectionView reloadData];
        }else{
           [self.collectionView.mj_footer endRefreshing];
        }
    } failureBlock:^(NSError *error) {
        [self.collectionView.mj_footer endRefreshing];
        
    }];
    request.schoolId = self.schoolId;
    request.page = self.page;
    request.phone = [EDSToolClass isBlankString:[EDSSave account].phone] ? @"" : [EDSSave account].phone;
    [request  startRequest];
}

- (void)setSchoolId:(NSString *)schoolId
{
    _schoolId = schoolId;
    [self requestData];
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"EDSTeachingStyleCollectionViewCell";
    
    EDSTeachingStyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.styleModel = self.modelArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EDSElegantDemeanourViewController *vc = [[EDSElegantDemeanourViewController alloc] initWithNibName:@"EDSElegantDemeanourViewController" bundle:[NSBundle mainBundle]];
    vc.schoolId = self.modelArr[indexPath.item].styleId;
    [self.parentView.navigationController pushViewController:vc animated:YES];
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        return CGSizeMake(EDSTeachingStyleCollectionViewCellW-1, EDSTeachingStyleCollectionViewCellH);
}




- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        //1.初始化layout
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        layout.minimumLineSpacing = KLineY(15);//设置最小行间距
        layout.minimumInteritemSpacing = KLineY(15);//item间距(最小值)
        layout.sectionInset = UIEdgeInsetsMake(KLineY(15), KLineY(15), KLineY(15), KLineY(15));//设置section的编距
        //2.初始化collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = WhiteColor;
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([EDSTeachingStyleCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"EDSTeachingStyleCollectionViewCell"];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
    }
    return _collectionView ;
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

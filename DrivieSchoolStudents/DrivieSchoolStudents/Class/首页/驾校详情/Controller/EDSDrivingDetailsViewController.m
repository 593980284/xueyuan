//
//  EDSDrivingDetailsViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSDrivingDetailsViewController.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "HomeConstants.h"
#import "EDSCoachInformationViewController.h"//教练信息

#import "EDSDrivingDetailsFooterView.h"
#import "EDSEDSDrivingDetailsHeaderView.h"
#import "EDSTeachingStyleCollectionViewCell.h"//教学风采cell
#import "EDSCheckSiteCollectionViewCell.h"//查看场地cell
#import "EDSCoachCollectionViewCell.h"//教练员cell

@interface EDSDrivingDetailsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** collectionView */
@property (nonatomic, strong) UICollectionView  *collectionView;

@end

@implementation EDSDrivingDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"驾校详情";
    
    [self setup];
}

- (void)setup{
    
    EDSDrivingDetailsFooterView *footerView = [[EDSDrivingDetailsFooterView alloc] init];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(EDSDrivingDetailsFooterViewH);
    }];
    
    [self.collectionView reloadData];
}

#pragma mark ------------------------ tableView --------------------------------


#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *ID = @"EDSCoachCollectionViewCell";
    
    EDSCoachCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    return cell;
    
//    static NSString *ID = @"EDSCheckSiteCollectionViewCell";
//
//    EDSCheckSiteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//
//    cell.layer.borderColor = SeparatorCOLOR.CGColor;
//    cell.layer.borderWidth = 1;
//    cell.layer.masksToBounds = YES;
//    cell.layer.cornerRadius = 5;
//
//    return cell;
    
//    static NSString *ID = @"EDSTeachingStyleCollectionViewCell";
//
//    EDSTeachingStyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//
//    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EDSCoachInformationViewController *vc = [[EDSCoachInformationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(EDSCheckSiteCollectionViewCellW, 80);
//    return CGSizeMake(EDSCheckSiteCollectionViewCellW, EDSCheckSiteCollectionViewCellH);
    //    return CGSizeMake(EDSTeachingStyleCollectionViewCellW, EDSTeachingStyleCollectionViewCellH);
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    //    BHYHomeCollectionReusableView *header = [[BHYHomeCollectionReusableView alloc] init];
    return CGSizeMake(kScreenWidth, EDSDrivingDetailsHeaderViewH);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, KLineY(50));
}

//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        
        EDSEDSDrivingDetailsHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EDSEDSDrivingDetailsHeaderView" forIndexPath:indexPath];
        
        headerView.headerModel = @[];
        
        return headerView;
        
    }else{
        
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        
        return headerView;
    }
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
        [self.view addSubview:_collectionView];
        
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = WhiteColor;
        //3.注册collectionViewCell
        //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([EDSCoachCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"EDSCoachCollectionViewCell"];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([EDSTeachingStyleCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"EDSTeachingStyleCollectionViewCell"];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([EDSCheckSiteCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"EDSCheckSiteCollectionViewCell"];
        
        [_collectionView registerClass:[EDSEDSDrivingDetailsHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"EDSEDSDrivingDetailsHeaderView"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionReusableView"];
        
        //4.设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.bottom.mas_equalTo(KLineY(-EDSDrivingDetailsFooterViewH));
        }];
        
    }
    return _collectionView ;
}
@end

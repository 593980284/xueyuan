//
//  cyhCalenbarview.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "cyhCalenbarview.h"
#import "cyhCalenbardate.h"
#import "calenCollectionViewCell.h"

@interface cyhCalenbarview ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong)UICollectionView * calenCollectionview;
@property (nonatomic , strong)cyhCalenbardate * cyhcalendate;
@property (nonatomic , strong)NSDate * mydate;
@property (nonatomic , strong)NSDateComponents * todaycomp ;
@property NSInteger colleItemNum;

@property (nonatomic , strong)NSMutableArray * fisrtdata;

@property (nonatomic , assign)NSInteger  f_week_firsday_month;//上一个月的第一天是星期几
@property (nonatomic , assign)NSInteger f_days;//总天数

@property (nonatomic , strong)NSMutableArray * lastdata;
@property (nonatomic , assign)NSInteger l_remainder;//上个月求余

@property (nonatomic , assign)NSInteger  l_week_firsday_month;//下一个月的第一天是星期几
@property (nonatomic , assign)NSInteger l_days;//总天数

@property (nonatomic , assign)NSInteger f_remainder;//上个月求余

@end

@implementation cyhCalenbarview

- (id)initD_calenbarframe:(CGRect)frame
{
    if (!_daycalenbarview) {
        _daycalenbarview = [[cyhCalenbarview alloc] init];
    }
    _daycalenbarview.frame = frame;
    
    return self;
}


- (void)daycalenbarviewNSdate
{
    self.cyhcalendate = [[cyhCalenbardate alloc] init];
    
    self.mydate = [NSDate date];
//    self.todaycomp = [[NSDateComponents alloc] init];
//    self.todaycomp = [self.cyhcalendate year_month_todayInthisMonth:[NSDate date]];

    [self getdatesource:self.mydate];//拿到一个月的日期
 //拿下一个月和上一个月的数据放在最后一排和第一排
    [self createfirstsection:_mydate];
    [self createlastsection:_mydate];
    
//创建collectionview
    
    [self creatCollectionview];
    [self createweekdayLabel];//创建上七天排列
    
    [self add_Y_M_Dlabel];
    
}
- (void)add_Y_M_Dlabel
{
    //WithFrame:CGRectMake(self.daycalenbarview.bounds.size.width/2, 15, 150, 30)
    _Y_M_Dlabel = [[UILabel alloc] init];
    _Y_M_Dlabel.font = [UIFont boldSystemFontOfSize:16];
    _Y_M_Dlabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld",self.comp.year,self.comp.month,self.comp.day];
    _Y_M_Dlabel.textAlignment = NSTextAlignmentLeft;
//    _Y_M_Dlabel.backgroundColor = [UIColor colorWithRed:0.2 green:0.9 blue:0.2 alpha:0.5];
    [self.daycalenbarview addSubview:_Y_M_Dlabel];
    [_Y_M_Dlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(15);
    }];

}
- (void)createweekdayLabel
{
    NSArray * weekarray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
//    self.daycalenbarview.backgroundColor = [UIColor orangeColor];
    
    for (int i = 0; i < 7; i ++) {
        
        self.daycalenlabel = [[UILabel alloc] initWithFrame:CGRectMake(i * self.daycalenbarview.frame.size.width/7, 50, self.daycalenbarview.frame.size.width/7, 20)];
        self.daycalenlabel.textColor = SecondColor;
        self.daycalenlabel.font = kFont(16);
        self.daycalenlabel.text = weekarray[i];
        self.daycalenlabel.textAlignment = 1;
        [self.daycalenbarview addSubview:self.daycalenlabel];
    }
}

- (void)creatCollectionview
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    if (self.daycalenbarview.frame.size.height < 122.0) {
        CGRect  frame = self.daycalenbarview.frame;
        frame.size.height = 122.0;
        self.daycalenbarview.frame = frame;
    }
    
    CGFloat  S_bottom = 37.5/120.0;
    CGFloat  S_top = 37.5/120.0;
    layout.sectionInset = UIEdgeInsetsMake(S_top * self.daycalenbarview.frame.size.height, 0, S_bottom * self.daycalenbarview.frame.size.height, 0);
    self.calenCollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0,30, self.daycalenbarview.frame.size.width,self.daycalenbarview.frame.size.height) collectionViewLayout:layout];
//    NSLog(@"今天是%ld页",self.offpage);
    
    [self.calenCollectionview setContentOffset:CGPointMake(self.offpage * self.daycalenbarview.frame.size.width, 0)];
    
    self.calenCollectionview.pagingEnabled = YES;
    self.calenCollectionview.delegate = self;
    self.calenCollectionview.dataSource = self;
    [self.calenCollectionview registerClass:[calenCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
//    [self.calenCollectionview registerClass:[selectCollectionViewCell class] forCellWithReuseIdentifier:@"select"];
    self.calenCollectionview.showsHorizontalScrollIndicator = NO;
    
    [self.daycalenbarview addSubview:self.calenCollectionview];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    return self.colleItemNum;

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cyhCalenbardate * daycalen = [[cyhCalenbardate alloc] init];
    self.todaycomp = [[NSDateComponents alloc] init];
    self.todaycomp = [daycalen year_month_todayInthisMonth:[NSDate date]];
    
    UICollectionViewCell * allcell = [[UICollectionViewCell alloc] init];

    calenCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if (cell.numberlabel) {
        
        [cell.numberlabel removeFromSuperview];
    }
#warning ------------------------------
    if (_comp.year == 2018 && _comp.month == 9 && (indexPath.row + 1 -_week_firsday_month - 7) == 15) {
        
        cell.tagview.hidden = NO;
    }else{
        cell.tagview.hidden = YES;
    }
    
    
    if (indexPath.row >(_week_firsday_month - 1 + 7) && indexPath.row < (_days+ (_week_firsday_month + 7))) {

        
        [cell TodayLabel:indexPath comp:self.comp todaycomp:_todaycomp week_firsday_month:_week_firsday_month number:self.datesource[indexPath.row -(_week_firsday_month) - 7] todayNumBGcolor:_todayNumBGcolor];
        
        if ((_comp.year == _todaycomp.year && _todaycomp.month == _comp.month && _comp.day == _todaycomp.day &&indexPath.row ==( _week_firsday_month - 1 + _comp.day + 7 )) )
        {
            
            NSString * datestr = [NSString stringWithFormat:@"%ld-%ld-%ld",_comp.year,_comp.month,(indexPath.row + 1 -_week_firsday_month - 7)];
            _Y_M_Dlabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld",_comp.year,_comp.month,(indexPath.row + 1 -_week_firsday_month - 7)];
            [self.daydelegate getDatestring:datestr];
            
            NSIndexPath *monthindexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:0];
            [self.calenCollectionview selectItemAtIndexPath:monthindexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
            
            allcell = cell;
    }
#pragma mark 最后一排的数据
    else if(indexPath.row >= (self.colleItemNum - 7 + _l_week_firsday_month)&& indexPath.row <= self.colleItemNum - 1)
    {
        
        [cell TodayLabel:indexPath comp:self.comp todaycomp:_todaycomp week_firsday_month:_week_firsday_month number:self.lastdata[(indexPath.row % 7) -  _l_week_firsday_month] todayNumBGcolor:_todayNumBGcolor];
        
        allcell = cell;

    }
#pragma mark 第一排的数据
    else if (indexPath.row >= 0  && indexPath.row < self.f_remainder)
    {
//        [cell TodayLabel:indexPath comp:self.comp todaycomp:_todaycomp week_firsday_month:_week_firsday_month  number:self.fisrtdata[(self.f_days - self.f_remainder + indexPath.row)]];
        
        [cell TodayLabel:indexPath comp:self.comp todaycomp:_todaycomp week_firsday_month:_week_firsday_month number:self.fisrtdata[(self.f_days - self.f_remainder + indexPath.row)] todayNumBGcolor:_todayNumBGcolor];
        
        allcell = cell;
   
        
    }
    else
    {
       cell.numberlabel.text = @"";
        
        allcell = cell;
    }
    
    return allcell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.daycalenbarview.frame.size.width/7, self.daycalenbarview.frame.size.width/7);
    
}

- (void)getdatesource:(NSDate *)date
{
    cyhCalenbardate * daycalen = [[cyhCalenbardate alloc] init];
    
  NSDateComponents * today_month = [[NSDateComponents alloc] init];
    today_month = [daycalen year_month_todayInthisMonth:[NSDate date]];
    NSDateComponents * allday_month = [[NSDateComponents alloc] init];
    allday_month = [daycalen year_month_todayInthisMonth:date];
    
    if (today_month.year == allday_month.year && today_month.month == allday_month.month) {
        date = [NSDate date];
    }
    self.comp = [[NSDateComponents alloc] init];
    self.comp = [daycalen year_month_todayInthisMonth:date];
    _week_firsday_month = [daycalen firstWeekdayInThisMonth:date];
    
    if ((_comp.day + _week_firsday_month) % 7 != 0) {
        
        self.offpage = (_comp.day + _week_firsday_month)/7 + 1;
//         NSLog(@"不能整除7");
    }
    else
    {
        self.offpage = (_comp.day + _week_firsday_month)/7;
//        NSLog(@"能整除7");
        
    }
    
    self.weekstr = [daycalen weekday:date];
    
    self.days = [daycalen daysInthisMonth:date];//这个月的天数
    self.week_firsday_month = [daycalen firstWeekdayInThisMonth:date];//这个月的第一天是星期几
    
    if (self.days == 30 && self.week_firsday_month == 6) {
        self.colleItemNum = 56;
    }else if (self.days == 31 && self.week_firsday_month >= 5) {
        
        self.colleItemNum = 56;
    }
    else if (self.days == 28 && self.week_firsday_month == 0)
    {
    
        self.colleItemNum = 42;
    }
    else{
        self.colleItemNum = 49;
    }
    
    
//    NSLog(@"这个月的第一天%ld\n这个月的总天数：%ld",_week_firsday_month,_days);
    self.datesource = [NSMutableArray new];
    for (NSInteger i = 1; i <= _days; i ++) {
        
        [_datesource addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    
//    NSLog(@"%@",_datesource);
//    [self.calenCollectionview setContentOffset:CGPointMake(self.calenCollectionview.frame.size.width * (self.colleItemNum/7 - 1) , 0)];
   [self.calenCollectionview reloadData];

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >(_week_firsday_month - 1 + 7) && indexPath.row < (_days+ (_week_firsday_month + 7))){
    collectionView = self.calenCollectionview;
//    NSLog(@"%ld - %ld - %ld",_comp.year,_comp.month,(indexPath.row + 1 -_week_firsday_month - 7) );
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",_comp.year,_comp.month,(indexPath.row + 1 -_week_firsday_month - 7)]];
        _cyhcalendate = [[cyhCalenbardate alloc] init];
//        NSString * week_str = [_cyhcalendate weekday:date];
        
        NSString * datestr = [NSString stringWithFormat:@"%ld-%ld-%ld",_comp.year,_comp.month,(indexPath.row + 1 -_week_firsday_month - 7)];
//      _Y_M_Dlabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld %@",_comp.year,_comp.month,(indexPath.row + 1 -_week_firsday_month - 7),week_str];
        _Y_M_Dlabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld",_comp.year,_comp.month,(indexPath.row + 1 -_week_firsday_month - 7)];
        
        [self.daydelegate getDatestring:datestr];     //回调一个日期的字符串回去
        
        calenCollectionViewCell * cell = (calenCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        cell.numberlabel.backgroundColor = _SelecNumBGcolor;
        
        cell.numberlabel.textColor = WhiteColor;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    calenCollectionViewCell * cell = (calenCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.numberlabel.backgroundColor = [UIColor clearColor];
    cell.numberlabel.textColor = SecondColor;
    
//    [cell TodayLabeltextcolor:indexPath comp:self.comp todaycomp:_todaycomp week_firsday_month:_week_firsday_month  number:self.datesource[indexPath.row -(_week_firsday_month) - 7]];
#pragma mark 取消选择
    [cell TodayLabelindexPath:indexPath comp:self.comp todaycomp:_todaycomp week_firsday_month:_week_firsday_month number:self.datesource[indexPath.row -(_week_firsday_month) - 7] textcolor:_todaytextColor];
    
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{

    scrollView.delegate = self;
    
    if (self.calenCollectionview.contentOffset.x == self.calenCollectionview.frame.size.width * (self.colleItemNum/7 - 1)) {
        
        [self nextMonthData];
        
    }
    else if(self.calenCollectionview.contentOffset.x == 0) {
     
        [self lastMonthcalenbardata];
//        NSLog(@"能跳回去");
    }
    
    
    if (self.calenCollectionview.contentOffset.x == self.calenCollectionview.frame.size.width * (self.colleItemNum/7 - 2)) {
        
        [self createlastsection:_mydate];
        
    }
    
    else if(self.calenCollectionview.contentOffset.x == self.calenCollectionview.frame.size.width) {
      
          [self createfirstsection:_mydate];
        
    }
    
}

- (void)lastMonthcalenbardata
{
//    [self.calenCollectionview setContentOffset:CGPointMake(self.calenCollectionview.frame.size.width * (self.colleItemNum/7 - 1) , 0)];
    self.cyhcalendate = [[cyhCalenbardate alloc] init];
    NSDate * lastMonthdate = [self.cyhcalendate lastMonthDate:_mydate];
    
    _mydate = lastMonthdate;
//    NSLog(@"%@",lastMonthdate);

    [self getdatesource:_mydate];
    
    if (_Y_M_Dlabel) {
        
        [_Y_M_Dlabel removeFromSuperview];
    }
    [self add_Y_M_Dlabel];
    [self.calenCollectionview reloadData];
[self.calenCollectionview setContentOffset:CGPointMake(self.calenCollectionview.frame.size.width * (self.colleItemNum/7 - 2) , 0)];


}

- (void)nextMonthData
{
    self.cyhcalendate = [[cyhCalenbardate alloc] init];
    NSDate * nextMonthdate = [self.cyhcalendate nextMonthDate:_mydate];
    _mydate = nextMonthdate;
//    NSLog(@"%@",lastMonthdate);
    
    [self getdatesource:_mydate];
    
    if (_Y_M_Dlabel) {
        
        [_Y_M_Dlabel removeFromSuperview];
    }
    [self add_Y_M_Dlabel];
    [self.calenCollectionview reloadData];
 
[self.calenCollectionview setContentOffset:CGPointMake(self.calenCollectionview.frame.size.width, 0)];
    
}


//======================================添加轮番的第一排和最后一排===========================

//上个月
- (void)createfirstsection:(NSDate *)date
{
    
    self.cyhcalendate = [[cyhCalenbardate alloc] init];
    NSDate * lastMonthdate = [self.cyhcalendate lastMonthDate:date];
   
    self.f_days = [self.cyhcalendate daysInthisMonth:lastMonthdate];//这个月的天数
    self.f_week_firsday_month = [self.cyhcalendate firstWeekdayInThisMonth:lastMonthdate];//这个月的第一天是星期几
    self.f_remainder = (self.f_days + _f_week_firsday_month)%7;
    
//    NSLog(@"上个月的天数：%ld",_f_days);
    if (self.f_remainder == 0) {
        self.f_remainder = 7;
    }
    
    self.fisrtdata = [NSMutableArray new];
    for (NSInteger i = 1; i <= self.f_days; i ++) {
        
        [_fisrtdata addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    
    [self.calenCollectionview reloadData];
    
    
}

//下个月
- (void)createlastsection:(NSDate *)date
{
    self.cyhcalendate = [[cyhCalenbardate alloc] init];
    NSDate * nextMonthdate = [self.cyhcalendate nextMonthDate:date];
    self.l_days = [self.cyhcalendate daysInthisMonth:nextMonthdate];//这个月的天数
    self.l_week_firsday_month = [self.cyhcalendate firstWeekdayInThisMonth:nextMonthdate];//这个月的第一天是星期几
    self.lastdata= [NSMutableArray new];
//    NSLog(@"下个月的天数：%ld",_l_days);
    for (NSInteger i = 1; i <= self.l_days; i ++) {
        
        [_lastdata addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    
    [self.calenCollectionview reloadData];

}

- (void)setWeekBGcolor:(UIColor *)WeekBGcolor
{
    _WeekBGcolor = WeekBGcolor;
    
    self.daycalenlabel.backgroundColor = WeekBGcolor;
}

- (void)setCalenbarBGcolor:(UIColor *)calenbarBGcolor
{
    self.calenCollectionview.backgroundColor = calenbarBGcolor;
    _calenbarBGcolor = calenbarBGcolor;
    
}

- (void)setSelecNumBGcolor:(UIColor *)SelecNumBGcolor
{
    _SelecNumBGcolor = SelecNumBGcolor;
}
- (void)setTodayNumBGcolor:(UIColor *)todayNumBGcolor
{

    _todayNumBGcolor = todayNumBGcolor;
}

- (void)setTodaytextColor:(UIColor *)todaytextColor
{
    _todaytextColor = todaytextColor;
}

@end

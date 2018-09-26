//
//  EDSMyHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/27.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSMyHeaderView.h"

@interface EDSMyHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *avarterImgView;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLbl;
@property (weak, nonatomic) IBOutlet UILabel *learnProgressLbl;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *phoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *calssLbl;

@end

@implementation EDSMyHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.avarterImgView.userInteractionEnabled = YES;
    @weakify(self);
    [self.avarterImgView bk_whenTapped:^{
        @strongify(self);
        
        if (self.headerImgViewDidClick) {
            
            self.headerImgViewDidClick();
        }
    }];
}

- (void)setHeaderArr:(NSArray *)headerArr
{
    _headerArr = headerArr;
    
    NSURL *url = [NSURL URLWithString:[EDSSave account].photo];

    [self.avarterImgView sd_setImageWithURL:url placeholderImage:PLACEHOLDERGOODSIMAGE];
    
    self.carTypeLbl.text = [EDSSave account].applyDriveCar.length > 0 ? [EDSSave account].applyDriveCar : @"";
    self.calssLbl.font = kFont(18);
    self.learnProgressLbl.text = [EDSSave account].learnProgress.length > 0 ?  [NSString stringWithFormat:@"%@",[EDSSave  account].learnProgress] : @"";
    self.learnProgressLbl.font = kFont(18);
    self.schoolNameLbl.text = [EDSSave account].schoolName.length > 0 ? [EDSSave account].schoolName : @"";
    self.schoolNameLbl.font = kFont(18);
    
    self.phoneLbl.text = [EDSSave account].phone.length > 0 ? [EDSSave account].phone : @"";
    self.calssLbl.text = [EDSSave account].learnProgress.length > 0 ? [NSString stringWithFormat:@"班级：%@",[EDSSave account].learnProgress]  : @"";
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSMyHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSMyHeaderView" owner:self options:nil] lastObject];
        
    }
    return self;
}

@end

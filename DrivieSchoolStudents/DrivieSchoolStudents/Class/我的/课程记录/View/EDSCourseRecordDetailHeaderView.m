//
//  EDSCourseRecordDetailHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/31.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCourseRecordDetailHeaderView.h"

#import "EDSDriveStarView.h"
#import "EDSCourseRecordModel.h"
#import "LEEStarRating.h"

@interface EDSCourseRecordDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *coursNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageSubjectLbl;
@property (nonatomic, strong) LEEStarRating * starView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImage;
@property (weak, nonatomic) IBOutlet UIImageView *Image1;
@property (weak, nonatomic) IBOutlet UIImageView *Image2;

@end

@implementation EDSCourseRecordDetailHeaderView

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"EDSCourseRecordDetailHeaderView" owner:self options:nil] lastObject];
        _starView = [[LEEStarRating alloc]initWithFrame:CGRectMake(0, 0, 80, 1) Count:5];
        _starView.maximumScore = 5;
        _starView.type = RatingTypeHalf;
        _starView.checkedImage = [UIImage imageNamed:@"star_content_icon_selected"];
        _starView.uncheckedImage = [UIImage imageNamed:@"star_content_icon_default"];
      
        
        [self addSubview:_starView];
        [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.height.mas_equalTo(8);
            make.width.mas_equalTo(110);
            make.right.mas_equalTo(self.mas_right).offset(-15);
        }];
    }
    return self;
}

- (void)setCourseRecordModel:(EDSCourseRecordModel *)courseRecordModel
{
    _courseRecordModel = courseRecordModel;
    
    _starView.currentScore = courseRecordModel.coachStar/2.0;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:courseRecordModel.coachPhoto] placeholderImage:AvatarPlaceholderImage];
    self.coursNameLbl.text = courseRecordModel.coachName;
    self.ageSubjectLbl.text = courseRecordModel.showSubjectAge;
     _sexImage.image = [UIImage imageNamed:[courseRecordModel.coachSex isEqualToString:@"女"]? @"ic-woman":@"ic-man"];
    NSArray *logs = [courseRecordModel.identity componentsSeparatedByString:@","];
    BOOL isJ = [logs containsObject:@"131000"];
    BOOL isS = [logs containsObject:@"132000"];
    if (isJ && isS) {
        self.Image1.hidden = NO;
        self.Image1.image = [UIImage imageNamed:@"ic-金牌教练"];
        self.Image2.hidden = NO;
        self.Image2.image = [UIImage imageNamed:@"ic-十佳党员"];
    }else if(!isS && !isJ){
        self.Image1.hidden = YES;
        self.Image2.hidden = YES;
    }else{
        self.Image1.hidden = NO;
        self.Image2.hidden = YES;
        self.Image1.image = [UIImage imageNamed:isJ ? @"ic-金牌教练": @"ic-十佳党员"];
    }

}
@end

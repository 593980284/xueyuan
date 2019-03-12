//
//  EDSCoachInformationHeaderView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/28.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSCoachInformationHeaderView.h"
#import "EDSCoachListModel.h"
#import "EDSDriveStarView.h"

@interface EDSCoachInformationHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *carLbl;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *driveStarView;
//@property (weak, nonatomic) IBOutlet UILabel *scoceLbl;
@property (weak, nonatomic) IBOutlet UILabel *sexLbl;

@end

@implementation EDSCoachInformationHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSCoachInformationHeaderView" owner:self options:nil] lastObject];
    }
    return self;
}


- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (void)setCoachModel:(EDSCoachListModel *)coachModel
{
    _coachModel = coachModel;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:coachModel.showCoachPhoto] placeholderImage:AvatarPlaceholderImage];
    self.nameLbl.text = coachModel.coachName;
    self.carLbl.text = coachModel.teachType;
    self.driveStarView.selectNumber = coachModel.showCoachStarInterger;
//    self.scoceLbl.text = [NSString stringWithFormat:@"%@分",coachModel.coachStar.length > 0 ? coachModel.coachStar : @"0"];
    self.sexLbl.text = coachModel.coachSex;
}
@end

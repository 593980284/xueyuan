//
//  MyCoachTableViewCell.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/2.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDSDriveStarView.h"
#import "CoachModel.h"

@interface MyCoachTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UILabel *sexLb;
@property (weak, nonatomic) IBOutlet UILabel *detailLb;
@property (weak, nonatomic) IBOutlet EDSDriveStarView *starView;
@property (nonatomic, copy) void(^changeApplyBlock)(CoachModel * model);
@property (nonatomic, copy) void(^callBlock)(CoachModel * model);
@property (nonatomic, strong) CoachModel *model;
@property (weak, nonatomic) IBOutlet UIButton *applyBtn;

@end

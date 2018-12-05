//
//  EDSMessageDetailTableViewCell.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/4.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSMessageDetailTableViewCell : UITableViewCell

/** 是否是问题 */
@property (nonatomic, assign) BOOL isQuestion;

@property (nonatomic, strong) UILabel  *typeLbl;
@property (nonatomic, strong) UILabel  *titleLbl;
@property (nonatomic, strong) UILabel  *descrpLbl;
@property (nonatomic, strong) UILabel  *timeLbl;

@end

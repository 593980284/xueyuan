//
//  SchoolStyleVIew.h
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/12/9.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDSSchoolStyleModel.h"


@interface SchoolStyleVIew : UIView
@property(nonatomic, strong)EDSSchoolStyleModel *model;

@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)UILabel *titleLb;
@property(nonatomic, strong)UIImageView *flgImgView;
@property(nonatomic, copy)void(^block)(EDSSchoolStyleModel *model);
@end

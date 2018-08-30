//
//  EDSTheoryLearningSubjectOneView.h
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDSTheoryLearningSubjectOneView : UIView

//练习
@property (weak, nonatomic) IBOutlet UIView *practiceBgView;
//考试
@property (weak, nonatomic) IBOutlet UIView *examBgView;
//背题
@property (weak, nonatomic) IBOutlet UIView *speakTextBgView;
//收藏
@property (weak, nonatomic) IBOutlet UIView *collectBgView;
//错题
@property (weak, nonatomic) IBOutlet UIView *mistakesBgView;

@end

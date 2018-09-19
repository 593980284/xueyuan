//
//  EDSSubjectFourExamViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/19.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSSubjectFourExamViewController.h"
#import "EDSFourSubjectExamBase.h"

@interface EDSSubjectFourExamViewController ()

@end

@implementation EDSSubjectFourExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[EDSFourSubjectExamBase sharedDataBase] getFourSubjectExam];
}

@end

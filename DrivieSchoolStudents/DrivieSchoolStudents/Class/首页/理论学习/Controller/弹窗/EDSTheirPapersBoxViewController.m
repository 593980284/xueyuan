//
//  EDSTheirPapersBoxViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/11.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSTheirPapersBoxViewController.h"

@interface EDSTheirPapersBoxViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultsLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation EDSTheirPapersBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



- (void)setErrortCount:(NSInteger)errortCount
{
    _errortCount = errortCount;
    
    self.resultsLbl.text = self.correctCount >= 90 ? @"成绩合格" : @"成绩不合格";
    
    self.titleLbl.text = [NSString stringWithFormat:@"已答错%ld题,剩余%ld道未答,是否继续答题？",(long)self.errortCount,100 - self.correctCount - self.errortCount];
}

- (void)setCorrectCount:(NSInteger)correctCount
{
    _correctCount = correctCount;
}

- (IBAction)commitClick:(id)sender {
    
    DLog(@"交卷");
    if (self.theirPapersBoxViewBackDidBtnString) {
        
        self.theirPapersBoxViewBackDidBtnString(@"交卷");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)continueClick:(id)sender {
    
    DLog(@"继续");
    if (self.theirPapersBoxViewBackDidBtnString) {
        
        self.theirPapersBoxViewBackDidBtnString(@"继续");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

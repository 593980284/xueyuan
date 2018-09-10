//
//  EDSClearRecordViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/9/10.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSClearRecordViewController.h"


@interface EDSClearRecordViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation EDSClearRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)setAllCount:(NSString *)allCount
{
    _allCount = allCount;
}

- (void)setErrorsCount:(NSString *)errorsCount
{
    _errorsCount = errorsCount;
}

- (void)setCorrectCount:(NSString *)correctCount
{
    _correctCount = correctCount;
    
    self.titleLbl.text = [NSString stringWithFormat:@"你共做了%@道题，做对%@道做错%@道错，确定清空所有记录吗？",self.allCount,self.correctCount,self.errorsCount];
    
}

- (IBAction)closeClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)commitClick:(id)sender {
    
    if (self.clearRecordDidCommitBtn) {
        
        self.clearRecordDidCommitBtn();
    }
    
    [self  dismissViewControllerAnimated:YES completion:nil];
}


@end

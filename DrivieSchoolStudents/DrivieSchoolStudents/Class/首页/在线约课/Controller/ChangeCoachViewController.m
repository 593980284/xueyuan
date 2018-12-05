//
//  ChangeCoachViewController.m
//  DrivieSchoolStudents
//
//  Created by 胡胡超 on 2018/11/3.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "ChangeCoachViewController.h"
#import "UITextView+placeholder.h"
#import "ChangeCoachRequest.h"

@interface ChangeCoachViewController ()
@property (weak, nonatomic) IBOutlet UIView *textViewBg;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLb;
@property (weak, nonatomic) IBOutlet UILabel *coachNameLb;
@property (weak, nonatomic) IBOutlet UILabel *subjectName;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ChangeCoachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"申请更换教练";
    self.view.backgroundColor = [UIColor whiteColor];
    _textView.placeHolder = @"请输入申请原因，不得超过500汉字";
    _subjectName.text = _model.name;
    _coachNameLb.text = _model.CoachName;
    _studentNameLb.text = _model.studentName;
    _textViewBg.layer.borderColor = [UIColor grayColor].CGColor;
    _textViewBg.layer.borderWidth = 0.5;
}
- (IBAction)submitBtnTap:(id)sender {
    NSString * applyReason = _textView.text;
    if (applyReason.length == 0) {
        [self.view makeToast:@"请输入申请原因" delay:1.5];
        return;
    }
     @weakify(self);
    ChangeCoachRequest * request = [ChangeCoachRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        [weak_self performSelector:@selector(gobackList) withObject:nil afterDelay:1.5];
        [weak_self.view makeToast:responseDict[@"msg"] delay:1.5];
        
    } failureBlock:^(NSError *error) {
        [weak_self.view makeToast:error.description delay:1.5];
    }];
    request.phone =  [EDSSave account].phone;
    request.applyReason = applyReason;
    request.coachId = _model.coachId;
    request.classId = _model.classId;
    request.subjectId = _model.subjectId;
    
    [request startRequest];
}

-(void)gobackList{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

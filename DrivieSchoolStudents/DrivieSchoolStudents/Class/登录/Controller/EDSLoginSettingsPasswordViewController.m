//
//  EDSLoginSettingsPasswordViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/25.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSLoginSettingsPasswordViewController.h"
#import "EDSAppTouristRegistRequest.h"


@interface EDSLoginSettingsPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pswTextF;
@property (weak, nonatomic) IBOutlet UITextField *againTextF;

@end

@implementation EDSLoginSettingsPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = WhiteColor;
}

- (IBAction)commitClik:(id)sender {
    
    if (self.pswTextF.text.length == 0 || self.againTextF.text.length == 0 ) {

        [SVProgressHUD showErrorWithStatus:@"请输入完整信息"];
        [SVProgressHUD dismissWithDelay:1.5];

        return ;
    }

    if ([self.pswTextF.text  isEqualToString:self.againTextF.text] ) {

        [SVProgressHUD showErrorWithStatus:@"密码输入不一致"];
        [SVProgressHUD dismissWithDelay:1.5];

        return ;
    }

    EDSAppTouristRegistRequest *request = [EDSAppTouristRegistRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {

        if (errCode == 1) {
            
            [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
        
    } failureBlock:^(NSError *error) {

    }];
    request.phone = self.phone;
    request.password = self.pswTextF.text;
    [request startRequest];
}

@end

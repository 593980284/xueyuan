//
//  EDSLoginSettingsPasswordViewController.m
//  DrivieSchoolStudents
//
//  Created by 班文政 on 2018/9/25.
//  Copyright © 2018 班文政. All rights reserved.
//

#import "EDSLoginSettingsPasswordViewController.h"
#import "EDSAppTouristRegistRequest.h"
#import "EDSPSWLogoViewController.h"


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


        [self.view makeToast:@"请输入完整信息"];
        return ;
    }

    if (![self.pswTextF.text isEqualToString:self.againTextF.text] ) {

        [self.view makeToast:@"密码输入不一致"];

        return ;
    }

    EDSAppTouristRegistRequest *request = [EDSAppTouristRegistRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {

        if (errCode == 1) {
            
            [self.view makeToast:@"注册成功,欢迎进入学员端"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] initWithNibName:@"EDSPSWLogoViewController" bundle:[NSBundle mainBundle]];
                [self presentViewController:vc animated:YES completion:nil];
            });
        }
        
    } failureBlock:^(NSError *error) {

    }];
    request.phone = self.phone;
    request.password = self.pswTextF.text;
    [request startRequest];
}

@end

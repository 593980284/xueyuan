//
//  EDSPersonalSettingsViewController.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/29.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPersonalSettingsViewController.h"
#import "EDSChangePasswordViewController.h"//修改密码
#import "EDSChangePhoneOneViewController.h"//跟换手机号


#import <MobileCoreServices/MobileCoreServices.h>
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "STConfig.h"

#import "EDSUploadStudentImgRequest.h"
#import "EDSFourDataBase.h"
#import "EDSDataBase.h"

@interface EDSPersonalSettingsViewController ()<UIImagePickerControllerDelegate, UIActionSheetDelegate, STPhotoKitDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *changePasswordBgview;
@property (weak, nonatomic) IBOutlet UIView *changephoneBgView;
@property (weak, nonatomic) IBOutlet UIView *avarimgView;

/** 头像 */
@property (nonatomic, strong) UIImageView  *avaimg;


@end

@implementation EDSPersonalSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"个人设置";
    
    NSURL *url = [NSURL URLWithString:[EDSSave account].photo];
    [self.avaimg sd_setImageWithURL:url placeholderImage:PLACEHOLDERGOODSIMAGE];
    
    @weakify(self);
    [self.changePasswordBgview bk_whenTapped:^{
        @strongify(self);
        EDSChangePasswordViewController *vc = [[EDSChangePasswordViewController alloc] initWithNibName:@"EDSChangePasswordViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.changephoneBgView bk_whenTapped:^{
        
        @strongify(self);
        EDSChangePhoneOneViewController *vc = [[EDSChangePhoneOneViewController alloc] initWithNibName:@"EDSChangePhoneOneViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.avarimgView bk_whenTapped:^{
        @strongify(self);
        
        [self changeAvarImgView];
    }];
}



- (void)changeAvarImgView
{
    //修改头像
    UIAlertController *alertController = [[UIAlertController alloc]init];
    
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        
        if ([controller isAvailableCamera] && [controller isSupportTakingPhotos]) {
            [controller setDelegate:self];
            [self presentViewController:controller animated:YES completion:nil];
        }else {
            [SVProgressHUD showErrorWithStatus:@"相机权限受限"];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *controller = [UIImagePickerController imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [controller setDelegate:self];
        if ([controller isAvailablePhotoLibrary]) {
            [self presentViewController:controller animated:YES completion:nil];
        }    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - 1.STPhotoKitDelegate的委托
- (void)photoKitController:(STPhotoKitController *)photoKitController resultImage:(UIImage *)resultImage
{
    NSData *imgdata = UIImageJPEGRepresentation(resultImage, 0.8f);
    
    NSString *imageBase64Str = [imgdata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    @weakify(self);
    
    EDSUploadStudentImgRequest *request = [EDSUploadStudentImgRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        if (errCode == 1) {
            
            self.avaimg.image = resultImage;
        }
        
    } failureBlock:^(NSError *error) {
    
    }];
    
    request.phone = [EDSSave account].phone;
    request.imageCode = imageBase64Str;
    request.showHUD = YES;
    [request startRequest];
    
//    [self editInfomationWithNiceName:@"" sex:@"" birthday:@"" images:@[resultImage]];
}


#pragma mark - 退出登录

- (IBAction)gooutClick:(id)sender {
    
    [SVProgressHUD showSuccessWithStatus:@"退出登录成功"];
    [SVProgressHUD dismissWithDelay:1.5];
    EDSAccount *account = [EDSSave account];
    account.userID = @"";
    account.firstSubjectID = @"";
    account.fourSubjectID = @"";
    [[EDSFourDataBase  sharedDataBase] clearFourSubjectAllWrongQuestions];
    [[EDSDataBase  sharedDataBase] clearFirstSubjectAllWrongQuestions];
    [EDSSave save:account];
    
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        self.navigationController.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}

#pragma mark - 2.UIImagePickerController的委托
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *imageOriginal = [info objectForKey:UIImagePickerControllerOriginalImage];
        STPhotoKitController *photoVC = [STPhotoKitController new];
        [photoVC setDelegate:self];
        [photoVC setImageOriginal:imageOriginal];
        [photoVC setSizeClip:CGSizeMake((kScreenWidth - 6*10), (kScreenWidth - 6*10))];
        [self presentViewController:photoVC animated:YES completion:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
        
    }];
}


- (UIImageView *)avaimg
{
    if (!_avaimg) {
        
        _avaimg = [UIImageView imageViewWithSuperView:self.avarimgView];
        _avaimg.layer.masksToBounds = YES;
        _avaimg.layer.cornerRadius = 20;
        _avaimg.userInteractionEnabled = YES;
        [_avaimg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    
    return _avaimg;
}

@end

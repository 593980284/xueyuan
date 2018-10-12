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
#import "XGPush.h"
#import "EDSPSWLogoViewController.h"
#import "LZActionSheet.h"
#import "UIImage+Ext.h"
#import "EDSStudentLogoutRequest.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import "STPhotoKitController.h"
#import "UIImagePickerController+ST.h"
#import "STConfig.h"

#import "EDSUploadStudentImgRequest.h"
#import "EDSFourDataBase.h"
#import "EDSDataBase.h"

@interface EDSPersonalSettingsViewController ()<LZActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    NSInteger _photoType;
    UIImage *_img;
}
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
    [self.avaimg sd_setImageWithURL:url placeholderImage:AvatarPlaceholderImage];
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([EDSToolClass isBlankString:[EDSSave account].userID]) {
        
        EDSPSWLogoViewController *vc = [[EDSPSWLogoViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
}


- (void)changeAvarImgView
{
    LZActionSheet *actionSheet = [[LZActionSheet alloc]initWithDelegate:self cancelButtonTitle:@"取消" otherButtonTitles:@[@"拍照",@"从相册选择"]]; //@[@"从相册选择",@"拍照"]
    [actionSheet show];
}
#pragma mark   - <LZActionSheetDelegate>
- (void)LZActionSheet:(LZActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)index{
    if(index == 0){
        //相机
        _photoType = 1;
        [self openPicOrVideoWithSign:_photoType];
    }
    if (index == 1) {
        //相册
        _photoType = 0;
        [self openPicOrVideoWithSign:_photoType];
    }
}

#pragma mark - privateMethod
- (void)openPicOrVideoWithSign:(NSInteger)photoType {
    if (photoType == 0) {
        //本地相簿
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: @"public.image", nil];
        imagePicker.delegate = self;
        [self presentImagepickView:imagePicker];
    }else if(photoType == 1) {
        //相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes =  [[NSArray alloc] initWithObjects: @"public.image", nil];
            imagePicker.delegate = self;
            [self presentImagepickView:imagePicker];
        }
    }
}
- (void)presentImagepickView:(UIImagePickerController *)imagePicker {
    [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
}

/// 上传头像操作
- (void)uploadHeaderImage:(UIImage *)headerImage {
    NSData *imageData = UIImageJPEGRepresentation(headerImage, 0);
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    @weakify(self);
    EDSUploadStudentImgRequest *request = [EDSUploadStudentImgRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        @strongify(self);
        if (errCode == 1) {
            
            self.avaimg.image = headerImage;
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    request.phone = [EDSSave account].phone;
    request.imageCode = encodedImageStr;
    request.showHUD = YES;
    [request startRequest];
}

//相机操作
-  (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    // 这就是我们想要的image 头像
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"])
    {
        _img = [info objectForKey:UIImagePickerControllerEditedImage];
        
        if (_photoType == 1)
        {
            UIImageWriteToSavedPhotosAlbum(_img,self, nil, nil);
        }
        //缩减图片
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = _img;
        CGSize imgSize = [imageView image].size;
        
        if (imgSize.width > 256 )
        {
            _img = [UIImage imageWithImage:_img scaledToSize:CGSizeMake(256, 256)];
        }
        [self uploadHeaderImage:_img];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 退出登录

- (IBAction)gooutClick:(id)sender {
    
    
    @weakify(self);
    EDSStudentLogoutRequest *request = [EDSStudentLogoutRequest requestWithSuccessBlock:^(NSInteger errCode, NSDictionary *responseDict, id model) {
        
        if (errCode == 1) {
            
            @strongify(self);
            EDSAccount *account = [EDSSave account];
            account.userID = @"";
            account.schoolId = @"";
            account.phone = @"";
            [EDSSave save:account];
            [[XGPushTokenManager defaultTokenManager] unbindWithIdentifer:[EDSSave account].phone type:XGPushTokenBindTypeAccount];
            self.navigationController.tabBarController.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    request.showHUD = YES;
    [request  startRequest];
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

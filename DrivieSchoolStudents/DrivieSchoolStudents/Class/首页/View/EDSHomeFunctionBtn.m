//
//  EDSHomeFunctionBtn.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/25.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSHomeFunctionBtn.h"

@interface EDSHomeFunctionBtn ()
@property (weak, nonatomic) IBOutlet UIImageView *btnImgView;
@property (weak, nonatomic) IBOutlet UILabel *btnTitleLbl;

@end

@implementation EDSHomeFunctionBtn

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setBtnArr:(NSArray *)btnArr
{
    _btnArr = btnArr;
    
    _btnImgView.image = [UIImage imageNamed:@"yybml_content_icon_default"];
    _btnTitleLbl.text = @"adfsd";
}

@end

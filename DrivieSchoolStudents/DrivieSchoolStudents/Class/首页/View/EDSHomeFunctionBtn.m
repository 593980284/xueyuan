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

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSHomeFunctionBtn" owner:self options:nil] lastObject];
        
    }
    return self;
}

- (void)setBtnArr:(NSArray *)btnArr
{
    _btnArr = btnArr;
    
    self.btnImgView.image = [UIImage imageNamed:btnArr[1]];
    self.btnTitleLbl.text = btnArr[0];
}

@end

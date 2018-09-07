//
//  EDSPracticeFooterView.m
//  DrivieSchoolStudents
//
//  Created by 卓森 on 2018/8/30.
//  Copyright © 2018年 班文政. All rights reserved.
//

#import "EDSPracticeFooterView.h"

@interface EDSPracticeFooterView ()
@property (weak, nonatomic) IBOutlet UILabel *correctLbl;
@property (weak, nonatomic) IBOutlet UILabel *errorLbl;
@property (weak, nonatomic) IBOutlet UILabel *progressLbl;

@end

@implementation EDSPracticeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        return [[[NSBundle mainBundle] loadNibNamed:@"EDSPracticeFooterView" owner:self options:nil] lastObject];
    }
    return self;
}
//下一题
- (IBAction)nextClick:(id)sender {
    if (self.practiceFooterViewDidSelectStringback) {
        
        self.practiceFooterViewDidSelectStringback(@"下一题");
    }
}

//收藏
- (IBAction)collectionClick:(id)sender {
    if (self.practiceFooterViewDidSelectStringback) {
        
        self.practiceFooterViewDidSelectStringback(@"下一题");
    }
}

//清除
- (IBAction)closeClick:(id)sender {
    
    if (self.practiceFooterViewDidSelectStringback) {
        
        self.practiceFooterViewDidSelectStringback(@"下一题");
    }
}

- (instancetype)init
{
    return [self initWithFrame:self.frame];
}

@end
